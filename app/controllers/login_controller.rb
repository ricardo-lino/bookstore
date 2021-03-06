class LoginController < ApplicationController
  layout "pub"

  def login
    if request.post?
      email = params[:email]
      password = params[:password]

      if email.blank? && password.blank?
        flash[:notice] = "Informe email e senha"
        return
      end

      if email.blank?
        flash[:notice] = "Informe o email"
        return
      end

      if password.blank?
        flash[:notice] = "Informe a senha"
        return
      end

      person = Person.auth(email, password)

      if !person
        flash[:notice] = "Falha no login"
        return
      end


      flash[:notice] = "Bem-vindo, #{person.name}!"
      session[:id] = person.id
      session[:name] = person.name
      session[:admin] = person.admin

      redirect_to people_path
    end
  end

  def logout
    session[:id] = nil
    session[:name] = nil
    session[:admin] = nil

    redirect_to action: :login
  end

end