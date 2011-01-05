module Mousetrap
  class Invoice < Resource
    attr_accessor \
      :id,
      :number,
      :billing_date,
      :vat_rate,
      :created_at,
      :transactions

    def self.new_from_api(attributes)
      invoice = new(attributes_from_api(attributes))
      invoice.transactions = attributes['transactions'] ?
        Transaction.build_resources_from(attributes) : []
      invoice
    end

    protected

    def self.plural_resource_name
      'invoices'
    end

    def self.singular_resource_name
      'invoice'
    end

    def self.attributes_from_api(attributes)
      {
        :id           => attributes['id'],
        :number       => attributes['number'],
        :billing_date => attributes['billingDatetime'],
        :created_at   => attributes['createdDatetime'],
        :vat_rate     => attributes['vatRate'],
      }
    end
  end
end
