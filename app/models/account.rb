class Account < ApplicationRecord
  belongs_to :user

  enum :account_type, { corrente: 0, poupanca: 1, carteira: 2, investimento: 3 }
  enum :status, { ativa: 0, inativa: 1 }

  validates :name, presence: true
  validates :balance, numericality: true
end
