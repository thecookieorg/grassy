Rails.configuration.stripe = {
  :publishable_key => "pk_test_YlbxGRV2G1WBNuYZVNqdFjpi",
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]