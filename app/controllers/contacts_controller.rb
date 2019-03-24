class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    if ContactMailer.welcome(contact_params).deliver
      redirect_to new_contact_path, notice: "Mensagem enviada"
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end