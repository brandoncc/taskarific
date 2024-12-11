json.extract! task, :id, :name, :description, :parent_id, :status, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)
