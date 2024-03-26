# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  type_of_product_id :integer          not null
#
# Indexes
#
#  index_products_on_type_of_product_id  (type_of_product_id)
#
# Foreign Keys
#
#  type_of_product_id  (type_of_product_id => type_of_products.id)
#
class Product < ApplicationRecord
  belongs_to :type_of_product
end