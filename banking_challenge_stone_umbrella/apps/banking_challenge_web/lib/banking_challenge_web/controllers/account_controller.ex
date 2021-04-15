defmodule  BankingChallengeWeb.AccountController do
   @moduledoc """
   Actions related to the account resource.
   """
   use BankingChallengeWeb, :controller

   alias BankingChallenge.Accounts.Account
   alias BankingChallenge.Transactions.Transaction

   def show(conn, _params) do
      text(conn, "Welecome to banking")
   end

   def create(conn, params) do
       Account.create_new_account(params)
   end

 end
