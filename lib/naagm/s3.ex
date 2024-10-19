defmodule Naagm.S3 do
  @region "us-west-2"
  @bucket "naagm"
  @upload_prefix "uploads/"
  @gallery_prefix "gallery/"

  def presign_upload(%{client_name: client_name, gallery?: gallery?}) do
    prefix = if gallery?, do: @gallery_prefix, else: @upload_prefix
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
    |> Enum.map(& &1.key)
  end

  def list_upload_keys(), do: list_keys(@upload_prefix)
  def list_gallery_keys(), do: list_keys(@gallery_prefix)

  def make_label(key) do
    key
    |> String.replace("_", " ")
    |> String.replace("-", " ")
    |> String.replace(@gallery_prefix, "")
    |> String.replace(@upload_prefix, "")
    |> String.split(".")
    |> hd
  end
end
