json.array!(@publications) do |publication|
  json.extract! publication, :id, :title, :content, :admin_id, :head_image
  json.url publication_url(publication, format: :json)
end
