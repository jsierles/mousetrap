module Mousetrap
  class Transaction < Resource
    attr_accessor \
      :id,
      :amount,
      :response,
      :created_at,
      :transacted_at

    protected

    def self.plural_resource_name
      'transactions'
    end

    def self.singular_resource_name
      'transaction'
    end

    def self.attributes_from_api(attributes)
      {
        :id            => attributes['id'],
        :amount        => attributes['amount'],
        :response      => attributes['response'],
        :created_at    => attributes['createdDatetime'],
        :transacted_at => attributes['transactedDatetime'],
      }
    end
  end
end
