defmodule BankingChallengeWeb.Router do
  use BankingChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingChallengeWeb do
    pipe_through :api

    # Criar conta e verificar saldo

    post "/account/create", AccountController, :create
    get  "/account/saldo/:account_id", AccountController, :show

    # Listar transaction
    get "/account/transaction_list", TransactionController, :all

    # Realizar transaction
     post "/account/transfer", TransactionController, :send


     #Realisar saque
     post "/account/withdraw", TransactionController, :withdraw

  end

end
