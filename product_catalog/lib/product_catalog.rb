module ProductCatalog
  class Product < ApplicationRecord
    AlreadyRegistered = Class.new(StandardError)

    self.table_name = "products"

    def register(name)
      raise AlreadyRegistered unless new_record?
      self.name = name
    end
  end

  class RegisterProduct < Command
    attribute :product_id, Types::UUID
    attribute :name, Types::String
  end

  class ProductRegistrationHandler
    def call(cmd)
      product = Product.find_or_initialize_by(id: cmd.product_id)
      product.register(cmd.name)
      product.save!
    end
  end

  class AssignPriceToProduct
    def call(event)
      product = Product.find_by(id: event.data.fetch(:product_id))
      product.price = event.data.fetch(:price)
      product.save!
    end
  end
end