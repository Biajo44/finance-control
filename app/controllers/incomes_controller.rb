class IncomesController < ApplicationController
  before_action :require_login
  before_action :set_income, only: [ :edit, :update, :destroy ]

  def index
    @incomes = current_user_transactions.order(transaction_date: :desc)
  end

  def new
    @income = Transaction.new(transaction_type: :receita)
    load_form_collections
  end

  def create
    @income = Transaction.new(income_params)
    @income.transaction_type = :receita

    if @income.save
      redirect_to incomes_path, notice: "Receita registrada com sucesso!"
    else
      load_form_collections
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_form_collections
  end

  def update
    if @income.update(income_params)
      redirect_to incomes_path, notice: "Receita atualizada com sucesso!"
    else
      load_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @income.destroy
    redirect_to incomes_path, notice: "Receita removida com sucesso!"
  end

  private

  def current_user_transactions
    Transaction.where(account: current_user.accounts, transaction_type: :receita)
  end

  def set_income
    @income = current_user_transactions.find(params[:id])
  end

  def income_params
    params.require(:transaction).permit(:description, :amount, :transaction_date, :note, :account_id, :category_id)
  end

  def load_form_collections
    @accounts = current_user.accounts.order(:name)
    @categories = current_user.categories.receita.order(:name)
  end
end
