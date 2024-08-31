defmodule NaagmWeb.CoreComponents do
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  import NaagmWeb.Gettext

  @doc """
  Renders flash notices.

  ## Examples

      <.flash kind={:info} flash={@flash} />
      <.flash kind={:info} phx-mounted={show("#flash")}>Welcome Back!</.flash>
  """
  attr :id, :string, doc: "the optional id of flash container"
  attr :flash, :map, default: %{}, doc: "the map of flash messages to display"
  attr :title, :string, default: nil
  attr :kind, :atom, values: [:info, :error], doc: "used for styling and flash lookup"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"

  slot :inner_block, doc: "the optional inner block that renders the flash message"

  def flash(assigns) do
    assigns = assign_new(assigns, :id, fn -> "flash-#{assigns.kind}" end)

    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      phx-click={JS.push("lv:clear-flash", value: %{key: @kind}) |> hide("##{@id}")}
      role="alert"
      class={"flash #{@kind}"}
      {@rest}
    >
      <div class="flash-title">
        <span>
          <%= if @kind == :info do %>
            🗣️️
          <% else %>
            ❗
          <% end %>
          <%= @title %>
        </span>
        <button type="button" aria-label={gettext("close")}>
          Ⅹ
        </button>
      </div>
      <p><%= msg %></p>
    </div>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} class="flash-group">
      <.flash kind={:info} title="Success!" flash={@flash} />
      <.flash kind={:error} title="Error!" flash={@flash} />
      <.flash
        id="js-client-error"
        kind={:error}
        title="no connection"
        phx-disconnected={show("#js-client-error")}
        phx-connected={hide("#js-client-error")}
        hidden
      >
        Attempting to reconnect ♺
      </.flash>

      <.flash
        id="js-server-error"
        kind={:error}
        title="unknown problem"
        phx-disconnected={show("#js-server-error")}
        phx-connected={hide("#js-server-error")}
        hidden
      >
        please wait 🤷‍♀️
      </.flash>
    </div>
    """
  end

  @doc """
  Renders a simple form.

  ## Examples

      <.simple_form for={@form} phx-change="validate" phx-submit="save">
        <.input field={@form[:email]} label="Email"/>
        <.input field={@form[:username]} label="Username" />
        <:actions>
          <.button>Save</.button>
        </:actions>
      </.simple_form>
  """
  attr :for, :any, required: true, doc: "the datastructure for the form"
  attr :class, :string, default: ""
  attr :as, :any, default: nil, doc: "the server side parameter to collect all input under"

  attr :rest, :global,
    include: ~w(autocomplete name rel action enctype method novalidate target multipart),
    doc: "the arbitrary HTML attributes to apply to the form tag"

  slot :inner_block, required: true
  slot :actions, doc: "the slot for form actions, such as a submit button"

  def simple_form(assigns) do
    ~H"""
    <.form :let={f} for={@for} as={@as} {@rest} class={["simple-form", @class]}>
      <%= render_slot(@inner_block, f) %>
      <div :for={action <- @actions}>
        <%= render_slot(action, f) %>
      </div>
    </.form>
    """
  end

  @doc """
  Renders a button.

  ## Examples

      <.button>Send!</.button>
      <.button phx-click="go" class="ml-2">Send!</.button>
  """
  attr :type, :string, default: nil
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <button type={@type} {@rest}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  @doc """
  Renders an input with label and error messages.

  A `Phoenix.HTML.FormField` may be passed as argument,
  which is used to retrieve the input name, id, and values.
  Otherwise all attributes may be passed explicitly.

  ## Types

  This function accepts all HTML input types, considering that:

    * You may also set `type="select"` to render a `<select>` tag

    * `type="checkbox"` is used exclusively to render boolean values

    * For live file uploads, see `Phoenix.Component.live_file_input/1`

  See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input
  for more information.

  ## Examples

      <.input field={@form[:email]} type="email" />
      <.input name="my-input" errors={["oh no!"]} />
  """
  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any

  attr :type, :string,
    default: "text",
    values: ~w(checkbox color date datetime-local email file hidden month number password
               range radio search select tel text textarea time url week)

  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :errors, :list, default: []
  attr :checked, :boolean, doc: "the checked flag for checkbox inputs"
  attr :prompt, :string, default: nil, doc: "the prompt for select inputs"
  attr :options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2"
  attr :multiple, :boolean, default: false, doc: "the multiple flag for select inputs"

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  slot :inner_block

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(field.errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(%{type: "checkbox"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        Phoenix.HTML.Form.normalize_value("checkbox", assigns[:value])
      end)

    ~H"""
    <div phx-feedback-for={@name} class={["input-wrapper", length(@errors) > 0 && "has-error"]}>
      <label>
        <input type="hidden" name={@name} value="false" />
        <input type="checkbox" id={@id} name={@name} value="true" checked={@checked} {@rest} />
        <%= @label %>
      </label>
    </div>
    <.error :for={msg <- @errors}><%= msg %></.error>
    """
  end

  def input(%{type: "select"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name} class={["select-wrapper", length(@errors) > 0 && "has-error"]}>
      <.label for={@id}><%= @label %></.label>
      <select id={@id} name={@name} multiple={@multiple} {@rest}>
        <option :if={@prompt} value=""><%= @prompt %></option>
        <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
      </select>
    </div>
    <.error :for={msg <- @errors}><%= msg %></.error>
    """
  end

  def input(%{type: "textarea"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name} class={["textarea-wrapper", length(@errors) > 0 && "has-error"]}>
      <.label for={@id}><%= @label %></.label>
      <textarea id={@id} name={@name} {@rest}><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
    </div>
    <.error :for={msg <- @errors}><%= msg %></.error>
    """
  end

  # All other inputs text, datetime-local, url, password, etc. are handled here...
  def input(assigns) do
    ~H"""
    <div phx-feedback-for={@name} class={["input-wrapper", length(@errors) > 0 && "has-error"]}>
      <.label for={@id}><%= @label %></.label>
      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
      />
    </div>
    <.error :for={msg <- @errors}><%= msg %></.error>
    """
  end

  @doc """
  Renders a label.
  """
  attr :for, :string, default: nil
  slot :inner_block, required: true

  def label(assigns) do
    ~H"""
    <label for={@for}>
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  @doc """
  Generates a generic error message.
  """
  slot :inner_block, required: true

  def error(assigns) do
    ~H"""
    <p class="error">
      <span class="error-icon">❗️</span>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  def image(assigns) do
    ~H"""
    <image class={@class} src={"https://d33j1my2155sn6.cloudfront.net/#{@path}"} />
    """
  end

  def show(js \\ %JS{}, selector) do
    JS.remove_class(js, "hidden", to: selector)
  end

  def hide(js \\ %JS{}, selector) do
    JS.add_class(js, "hidden", to: selector)
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # However the error messages in our forms and APIs are generated
    # dynamically, so we need to translate them by calling Gettext
    # with our gettext backend as first argument. Translations are
    # available in the errors.po file (as we use the "errors" domain).
    if count = opts[:count] do
      Gettext.dngettext(NaagmWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(NaagmWeb.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end
end
