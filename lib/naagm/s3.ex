defmodule Naagm.S3 do
  @region "us-west-2"
  @bucket "naagm"

  @gallery_prefix "gallery/"
  @guest_prefix "gallery/guest/"
  @house_prefix "gallery/house/"
  @kolby_prefix "gallery/kolby/"
  @upload_prefix "uploads/"

  def presign_upload(%{client_name: client_name, prefix: prefix}) do
    key = prefix <> client_name

    ExAws.S3.presigned_post(ExAws.Config.new(:s3, region: @region), @bucket, key,
      expires_in: 3600
    )
  end

  def list_objects(prefix \\ "") do
    @bucket
    |> ExAws.S3.list_objects(prefix: prefix)
    |> ExAws.request!(region: @region)
  end

  def list_keys(prefix \\ "") do
    prefix
    |> list_objects
    |> Map.get(:body, %{})
    |> Map.get(:contents, [])
    |> Enum.reduce(
      [],
      fn object, keys ->
        key = object.key
        [_, key_name] = String.split(object.key, prefix)

        if String.contains?(key_name, "/") or String.ends_with?(key, "/") do
          keys
        else
          # only return non-nested and non-directory keys
          [key | keys]
        end
      end
    )
  end

  def delete_key(key) when is_binary(key) do
    @bucket
    |> ExAws.S3.delete_object(key)
    |> ExAws.request!(region: @region)
  end

  def prefixes do
    [
      @gallery_prefix,
      @guest_prefix,
      @house_prefix,
      @kolby_prefix,
      @upload_prefix
    ]
  end

  def gallery_render_tuples do
    [
      {@gallery_prefix, "Life", :random},
      {@kolby_prefix, "Kolby Wall Photography", :random},
      {@guest_prefix, "Guest Uploads", :random},
      {@house_prefix, "House Construction", :alpha}
    ]
  end

  def gallery_prefix, do: @gallery_prefix
  def guest_gallery_prefix, do: @guest_prefix
  def house_gallery_prefix, do: @house_prefix
  def kolby_gallery_prefix, do: @kolby_prefix

  def can_upload?(%Naagm.Accounts.User{} = user, prefix) when is_binary(prefix) do
    Naagm.Accounts.admin?(user) or prefix == @guest_prefix
  end

  def list_upload_keys(), do: list_keys(@upload_prefix)
  def list_gallery_keys(), do: list_keys(@gallery_prefix)
  def list_guest_keys(), do: list_keys(@guest_prefix)
  def list_house_keys(), do: list_keys(@house_prefix)
  def list_kolby_keys(), do: list_keys(@kolby_prefix)

  def make_label(key) do
    key
    |> String.split(".")
    |> hd
    |> String.replace(~r"^.+/", "")
    |> String.replace(~r"^[0-9]+_", "")
    |> String.replace("_", " ")
    |> String.replace("-", " ")
  end
end
