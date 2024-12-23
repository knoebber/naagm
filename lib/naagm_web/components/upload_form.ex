defmodule NaagmWeb.UploadForm do
  alias Naagm.S3
  require Logger
  use NaagmWeb, :live_component

  defp error_to_string(reason) do
    case reason do
      :external_client_failure -> "Failed to contact S3 server"
      :not_accepted -> "File type not supported"
      :too_large -> "Too large"
      :too_many_files -> "You have selected too many files"
    end
  end

  defp presign_upload(entry, socket) do
    %{url: url, fields: fields} =
      S3.presign_upload(%{
        client_name: entry.client_name,
        prefix: socket.assigns.prefix
      })

    {:ok, %{uploader: "S3", url: url, fields: fields}, socket}
  end

  @impl Phoenix.LiveComponent
  def update(assigns, socket) do
    socket = assign(socket, assigns)

    {
      :ok,
      socket
      |> allow_upload(:content,
        accept: ~w(.jpg .jpeg .webp .png),
        max_entries: 10,
        external: &presign_upload/2
      )
    }
  end

  @impl Phoenix.LiveComponent
  def handle_event("validate", params, socket) do
    {:noreply, assign(socket, :gallery?, params["gallery"] == "true")}
  end

  @impl Phoenix.LiveComponent
  def handle_event("save", _params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :content, fn entry, _ ->
        {:ok, entry.fields["key"]}
      end)

    Logger.info("Uploaded #{inspect(uploaded_files)}")
    send(self(), {:upload_success, uploaded_files})
    {:noreply, socket}
  end

  @impl Phoenix.LiveComponent
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :content, ref)}
  end

  @impl Phoenix.LiveComponent
  def render(assigns) do
    ~H"""
    <div phx-drop-target={@uploads.content.ref} class="container">
      <.form
        class="upload-form"
        id="upload-form"
        phx-submit="save"
        phx-change="validate"
        for={%{}}
        phx-target={@myself}
      >
        <label for={@uploads.content.ref}>
          Drop a file or<.live_file_input upload={@uploads.content} />
        </label>
        <button :if={length(@uploads.content.entries) > 0} class="button" type="submit">
          Upload
        </button>
      </.form>
      <section class="upload-entries">
        <%= for entry <- @uploads.content.entries do %>
          <article class="upload-entry">
            <figure>
              <.live_img_preview entry={entry} />
              <figcaption>{entry.client_name}</figcaption>
            </figure>
            <progress value={entry.progress} max="100">{entry.progress}%</progress>
            <button
              type="button"
              phx-click="cancel-upload"
              phx-value-ref={entry.ref}
              aria-label="cancel"
              phx-target={@myself}
            >
              &times;
            </button>
            <%= for err <- upload_errors(@uploads.content, entry) do %>
              <p class="alert alert-danger">{error_to_string(err)}</p>
            <% end %>
          </article>
        <% end %>
        <%= for err <- upload_errors(@uploads.content) do %>
          <p class="alert alert-danger">{error_to_string(err)}</p>
        <% end %>
      </section>
    </div>
    """
  end
end
