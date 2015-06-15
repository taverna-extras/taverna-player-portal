json.extract! workflow, :id, :title, :description

json.url workflow_url(workflow, :format => :json)

json.user do |json|
  json.(workflow.user, :id, :name)
end
