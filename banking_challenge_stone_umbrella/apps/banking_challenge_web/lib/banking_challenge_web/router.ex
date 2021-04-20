defmodule BankingChallengeWeb.Router do
  use BankingChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingChallengeWeb do
    pipe_through :api

    # Criar conta e verificar saldo

    post "/account/create", AccountController, :create
    get  "/account/saldo", AccountController, :show

    # Listar transaction
    get "/account/transaction_all", TransactionController, :all

    # Realizar transaction
     post "/account/transaction_to/", TransactionController, :send


     #Realisar saque
     post "/account/transaction", TransactionController, :withdraw

  end

end
