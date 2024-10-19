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

  def list_keys(prefix \\ "") do
    @bucket
    |> ExAws.S3.list_objects(prefix: prefix)
    |> ExAws.request!(region: @region)
  end

  def list_upload_keys(), do: list_keys(@upload_prefix)
end
