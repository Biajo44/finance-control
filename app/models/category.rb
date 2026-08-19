class Category < ApplicationRecord
  belongs_to :user

  enum :category_type, { receita: 0, despesa: 1 }

  validates :name, presence: true, uniqueness: { scope: [ :user_id, :category_type ] }
end
