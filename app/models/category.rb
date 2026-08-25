class Category < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :restrict_with_error

  enum :category_type, { receita: 0, despesa: 1 }

  validates :name, presence: true, uniqueness: { scope: [ :user_id, :category_type ] }
end
