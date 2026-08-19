class User < ApplicationRecord
  has_secure_password validations: false

  has_many :accounts, dependent: :destroy
  has_many :categories, dependent: :destroy

  before_validation :normalize_email
  after_create :create_default_categories

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true, if: -> { new_record? || !password.nil? }

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end

  def create_default_categories
    receitas_padrao = [ "Salário", "Freelance", "Investimentos", "Outros" ]
    despesas_padrao = [ "Alimentação", "Transporte", "Moradia", "Saúde", "Educação", "Lazer", "Compras", "Contas", "Outros" ]

    receitas_padrao.each do |nome|
      categories.create(name: nome, category_type: :receita)
    end

    despesas_padrao.each do |nome|
      categories.create(name: nome, category_type: :despesa)
    end
  end
end
