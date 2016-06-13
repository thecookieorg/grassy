json.array!(@store_policies) do |store_policy|
  json.extract! store_policy, :id, :name, :content
  json.url store_policy_url(store_policy, format: :json)
end
