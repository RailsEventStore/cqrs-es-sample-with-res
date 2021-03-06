module Ordering
  class OrderSubmitted < Event
    attribute :order_id,     Types::UUID
    attribute :order_number, Types::OrderNumber
    attribute :customer_id,  Types::UUID
  end
end