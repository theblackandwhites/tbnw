json.extract! event_item, :id, :title, :description, :training, :support, :color_hex, :created_at, :updated_at
json.url event_item_url(event_item, format: :json)
