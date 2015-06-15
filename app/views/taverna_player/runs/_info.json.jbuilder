json.extract! run, :id, :name, :workflow_id, :state, :start_time, :finish_time

json.user do |json|
  if run.user.nil?
    json.name "Guest"
  else
    json.(run.user, :id, :name)
  end
end
