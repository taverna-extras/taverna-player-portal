json.partial! "info", :workflow => @workflow
json.extract! @workflow, :created_at, :updated_at
