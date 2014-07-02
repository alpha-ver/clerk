json.array!(@users) do |user|
  json.extract! user, :id, :email, :sign_in_count
  json.url user_url(user, format: :json)
end
