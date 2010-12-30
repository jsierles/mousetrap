module Mousetrap
  class Subscription < Resource
    # Attributes we send _to_ the API.
    attr_accessor \
      :plan_code,
      :billing_first_name,
      :billing_last_name,
      :credit_card_number,
      :credit_card_expiration_month,
      :credit_card_expiration_year,
      :credit_card_code,
      :billing_country,
      :billing_address,
      :billing_city,
      :billing_state,
      :billing_zip_code,
      :plan,
      :change_bill_date

      :customer_code # belongs to customer

    # Attributes that come _from_ the API.
    attr_reader \
      :id,
      :canceled_at,
      :created_at,
      :credit_card_expiration_date,
      :credit_card_last_four_digits,
      :credit_card_type,
      :invoices,
      :items

    def self.[](code)
      raise_api_unsupported_error
    end

    def self.all
      raise_api_unsupported_error
    end

    def self.destroy_all
      raise_api_unsupported_error
    end

    def self.exists?(code)
      raise_api_unsupported_error
    end

    def current_invoice
      invoice_attributes = if invoices['invoice'].kind_of?(Array)
        invoices['invoice'][0]
      else
        invoices['invoice']
      end

      Invoice.new(invoice_attributes)
    end

    def attributes
      {
        :id                           => id,
        :plan_code                    => plan_code,
        :billing_first_name           => billing_first_name,
        :billing_last_name            => billing_last_name,
        :credit_card_number           => credit_card_number,
        :credit_card_expiration_month => credit_card_expiration_month,
        :credit_card_expiration_year  => credit_card_expiration_year,
        :credit_card_code             => credit_card_code,
        :billing_country              => billing_country,
        :billing_address              => billing_address,
        :billing_city                 => billing_city,
        :billing_state                => billing_state,
        :billing_zip_code             => billing_zip_code,
        :change_bill_date             => change_bill_date
      }
    end

    def attributes_for_api
      self.class.attributes_for_api(attributes)
    end

    def destroy
      self.class.raise_api_unsupported_error
    end

    def exists?
      self.class.raise_api_unsupported_error
    end

    def self.new_from_api(attributes)
      subscription = new(attributes_from_api(attributes))
      subscription.plan = Plan.new_from_api(attributes['plans']['plan'])
      subscription
    end

    def self.update(customer_code, attributes)
      mutated_attributes = attributes_for_api(attributes)

      mutated_attributes.delete_if { |k, v| v.blank? }

      response = put_resource(
        'customers',
        'edit-subscription',
        customer_code,
        mutated_attributes
      )

      raise response['error'] if response['error']
    end


    protected

    attr_writer \
      :id,
      :canceled_at,
      :created_at,
      :credit_card_expiration_date,
      :credit_card_last_four_digits,
      :credit_card_type,
      :credit_card_verification_code,
      :items,
      :invoices

    def self.plural_resource_name
      'subscriptions'
    end

    def self.singular_resource_name
      'subscription'
    end

    def self.attributes_for_api(attributes)
      {
        :planCode       => attributes[:plan_code],
        :ccFirstName    => attributes[:billing_first_name],
        :ccLastName     => attributes[:billing_last_name],
        :ccNumber       => attributes[:credit_card_number],
        :ccExpMonth     => ("%02d" % attributes[:credit_card_expiration_month] if attributes[:credit_card_expiration_month]),
        :ccExpYear      => attributes[:credit_card_expiration_year],
        :ccCardCode     => attributes[:credit_card_code],
        :ccCountry      => attributes[:billing_country],
        :ccAddress      => attributes[:billing_address],
        :ccCity         => attributes[:billing_city],
        :ccState        => attributes[:billing_state],
        :ccZip          => attributes[:billing_zip_code],
        :changeBillDate => attributes[:change_bill_date],
      }
    end

    def self.attributes_from_api(attributes)
      {
        :id                           => attributes['id'],
        :canceled_at                  => attributes['canceledDatetime'],
        :created_at                   => attributes['createdDatetime'],
        :credit_card_expiration_date  => attributes['ccExpirationDate'],
        :credit_card_last_four_digits => attributes['ccLastFour'],
        :credit_card_type             => attributes['ccType'],
        :invoices                     => attributes['invoices'],
        :items                        => attributes['items']
      }
    end
  end
end
