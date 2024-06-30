defmodule NaagmWeb.UploadLive do
  alias Naagm.S3
  use NaagmWeb, :live_view

  @region "us-west-2"
  @bucket "naagm"
  defp make_key(client_name), do: "uploads/#{client_name}"

  defp error_to_string(reason) do
    case reason do
      :external_client_failure -> "Failed to contact S3 server"
      :not_accepted -> "File type not supported"
      :too_large -> "Too large"
      :too_many_files -> "You have selected too many files"
    end
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> allow_upload(:content, accept: :any, max_entries: 3, external: &presign_upload/2)}
  end

  defp presign_upload(entry, socket) do
    uploads = socket.assigns.uploads
    key = make_key(entry.client_name)

    config =
      %{
        region: @region,
        access_key_id: Application.fetch_env!(:naagm, :aws_key_id),
        secret_access_key: Application.fetch_env!(:naagm, :aws_key_secret)
      }
      |> dbg

    {:ok, fields} =
      S3.sign_form_upload(config, @bucket,
        key: key,
        content_type: entry.client_type,
        max_file_size: uploads[entry.upload_config].max_file_size,
        expires_in: :timer.hours(1)
      )

    meta = %{
      uploader: "S3",
      key: key,
      url: "http://#{@bucket}.s3-#{config.region}.amazonaws.com",
      fields: fields
    }

    {:ok, meta, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :content, ref)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="">
      <form id="upload-form" phx-submit="save" phx-change="validate">
        <.live_file_input upload={@uploads.content} />
        <button type="submit">Upload</button>
      </form>
      <section phx-drop-target={@uploads.content.ref}>
        <%= for entry <- @uploads.content.entries do %>
          <article class="upload-entry">
            <figure>
              <.live_img_preview entry={entry} />
              <figcaption><%= entry.client_name %></figcaption>
            </figure>

            <%!-- entry.progress will update automatically for in-flight entries --%>
            <progress value={entry.progress} max="100"><%= entry.progress %>%</progress>

            <%!-- a regular click event whose handler will invoke Phoenix.LiveView.cancel_upload/3 --%>
            <button
              type="button"
              phx-click="cancel-upload"
              phx-value-ref={entry.ref}
              aria-label="cancel"
            >
              &times;
            </button>

            <%!-- Phoenix.Component.upload_errors/2 returns a list of error atoms --%>
            <%= for err <- upload_errors(@uploads.content, entry) do %>
              <p class="alert alert-danger"><%= error_to_string(err) %></p>
            <% end %>
          </article>
        <% end %>

        <%!-- Phoenix.Component.upload_errors/1 returns a list of error atoms --%>
        <%= for err <- upload_errors(@uploads.content) do %>
          <p class="alert alert-danger"><%= error_to_string(err) %></p>
        <% end %>
      </section>
    </div>
    """
  end
end