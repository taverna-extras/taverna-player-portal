json.array!(@workflows) do |workflow|
  json.extract! workflow, :id, :title, :description
  json.url workflow_url(workflow, format: :json)
end
