json.array!(@tapes) do |tape|
  json.extract! tape, :id, :tape_ref, :customer_id
  json.url tape_url(tape, format: :json)
end
