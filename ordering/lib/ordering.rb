module Ordering

  class OnCancelOrder
    include CommandHandler

    def call(command)
      with_aggregate(Order, command.aggregate_id) do |order|
        order.cancel
      end
    end
  end

  class OnMarkOrderAsPaid
    include CommandHandler

    def call(command)
      with_aggregate(Order, command.aggregate_id) do |order|
        order.confirm
      end
    end
  end

  class OnSetOrderAsExpired
    include CommandHandler

    def call(command)
      with_aggregate(Order, command.aggregate_id) do |order|
        order.expire
      end
    end
  end
  class OnSubmitOrder
    include CommandHandler

    def initialize(number_generator:)
      @number_generator = number_generator
    end

    def call(command)
      with_aggregate(Order, command.aggregate_id) do |order|
        order_number = number_generator.call
        order.submit(order_number, command.customer_id)
      end
    end

    private

    attr_accessor :number_generator
  end
end



