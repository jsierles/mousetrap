require 'factory_girl'

Factory.define :new_customer, :class => Mousetrap::Customer, :default_strategy => :stub do |f|
  f.email { random_email_address }
  f.first_name { random_string }
  f.last_name { random_string }
  f.company { random_string }
  f.code { |me| me.email }
  f.is_vat_exempt true
  f.add_attribute :id, nil
  f.subscription_attributes { Factory.attributes_for :subscription }
end

Factory.define :existing_customer, :parent => :new_customer, :default_strategy => :stub do |f|
  f.add_attribute :id, '2d1244e8-e338-102c-a92d-40402145ee8b'
end

Factory.define :alt_new_customer, :parent => :new_customer, :default_strategy => :stub do |f|
  # TODO: international?
end

Factory.define :subscription, :class => Mousetrap::Subscription, :default_strategy => :stub do |f|
  f.plan_code 'TEST'
  f.billing_first_name { random_string }
  f.billing_last_name { random_string }
  f.credit_card_number '4111111111111111'
  f.credit_card_expiration_month '12'
  f.credit_card_expiration_year '2012'
  f.credit_card_code '123'
  f.billing_address "400 W 7th St\n#200"
  f.billing_city 'Bloomington'
  f.billing_state 'IN'
  f.billing_country 'US'
  f.billing_zip_code '47404'
end

Factory.define :alternate_subscription, :parent => :subscription, :default_strategy => :stub do |f|
  f.credit_card_number '5555555555554444'
  f.credit_card_expiration_month '7'
  f.credit_card_expiration_year '2013'
  f.credit_card_code '456'
  f.billing_zip_code '12345'
end
