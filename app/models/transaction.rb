class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category

  enum :transaction_type, { receita: 0, despesa: 1 }

  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_date, presence: true

  after_create :apply_balance_change
  after_update :adjust_balance_change, if: :saved_change_to_amount?
  after_destroy :revert_balance_change, unless: :previously_new_record?

  private

  def signed_amount
    receita? ? amount : -amount
  end

  def apply_balance_change
    ActiveRecord::Base.transaction do
      account.update!(balance: account.balance + signed_amount)
    end
  end

  def adjust_balance_change
    old_amount, new_amount = saved_change_to_amount
    old_signed = receita? ? old_amount : -old_amount
    new_signed = receita? ? new_amount : -new_amount
    difference = new_signed - old_signed

    ActiveRecord::Base.transaction do
      account.update!(balance: account.balance + difference)
    end
  end

  def revert_balance_change
    ActiveRecord::Base.transaction do
      account.update!(balance: account.balance - signed_amount)
    end
  end
end
