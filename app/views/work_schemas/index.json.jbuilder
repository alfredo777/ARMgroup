json.array!(@work_schemas) do |work_schema|
  json.extract! work_schema, :id, :name, :customer_id, :campaing_id
  json.url work_schema_url(work_schema, format: :json)
end
