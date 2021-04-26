defmodule  BankingChallengeWeb.AccountController do

   @moduledoc """
   Actions related to the account resource.
   """
   use BankingChallengeWeb, :controller

   alias BankingChallenge.Accounts.Account

   action_fallback BankingChallengeWeb.FallbackController

   @doc """
   Show the balance in account
   """
   def show(conn, params) do
       params
       |> Account.fetch()
       |> handle_response(conn)
   end

   @doc """
   Create Account action.
   """
   def create(conn, params) do
      params
      |> Account.create_new_account()
      |> handle_response(conn)
   end

   defp handle_response({:ok, account}, conn) do
      conn
      |> put_status(:ok)
      |> render("account.json", account: account)
   end

   defp handle_response({:error, _result} = error, _conn), do: error

 end
