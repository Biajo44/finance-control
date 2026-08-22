class UsersController < ApplicationController
  before_action :require_login, only: [ :show, :edit, :update ]
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :require_correct_user, only: [ :edit, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Conta criada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Perfil atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_correct_user
    unless @user == current_user
      redirect_to root_path, alert: "Você não tem permissão para fazer isso."
    end
  end
end
