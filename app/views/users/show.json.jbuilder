json.array!(@my_events) do |event|
  json.extract! event, :id, :event_title, :explanation
  json.title event.event_title
  json.start event.start_date
  json.end event.end_date
  json.url event_url(event, format: :html)
end