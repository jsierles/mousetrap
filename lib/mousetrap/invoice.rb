module Mousetrap
  class Invoice < Resource
    attr_accessor \
      :id,
      :number,
      :created_at,
      :billing_date,
      :vat_rate,
      :paid_transaction_id,
      :transactions

    def self.new_from_api(attributes)
      invoice = new(attributes_from_api(attributes))
      invoice.transactions = attributes['transactions'] ?
        Transaction.build_resources_from(attributes) : []
      invoice
    end

    def paid?
      @paid_transaction_id.present?
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
        :id                  => attributes['id'],
        :number              => attributes['number'],
        :created_at          => attributes['createdDatetime'],
        :billing_date        => attributes['billingDatetime'],
        :vat_rate            => attributes['vatRate'],
        :paid_transaction_id => attributes['paidTransactionId'],
      }
    end
  end
end
