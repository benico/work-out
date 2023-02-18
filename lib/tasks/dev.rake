namespace :dev do
  desc "Configura ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD..") {%x(rails db:drop)}      
      show_spinner("Criando BD..") {%x(rails db:create)}
      show_spinner("Migrando BD..") {%x(rails db:migrate)}
      show_spinner("Criando usuário padrão..") {%x(rails dev:add_user)}
      show_spinner("Criando administrador padrão..") {%x(rails dev:add_admin)}
      #show_spinner("Criando tabela dos alimentos..") {%x(rails dev:add_foods)}
      #show_spinner("Criando tabela dos exercicios..") {%x(rails dev:add_exercises)}
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastro usuário padrão"
  task add_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: 123456,
      password_confirmation: 123456
    )
  end
  
  desc "Cadastro administrador padrão"
  task add_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: 123456,
      password_confirmation: 123456
    )
  end 

  #desc "Cadastro alimentos padrão"
  #task add_foods: :environment do
  #  Food.create!(
  #    name: 'Maça',
  #    calories: 105,
  #    protein: 0.5,
  #    fat: 0.0,
  #    carbohydrate: 7.2
  #  )
  #end 

  #desc "Cadastro exercicios padrão"
  #task add_exercises: :environment do
  #  Exercise.create!(
  #    name: 'Supino Reto',
  #    muscle_grup: 'Peito',
  #  )  
  #end
  
  private
  
  def show_spinner(msg_start,msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner::new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
