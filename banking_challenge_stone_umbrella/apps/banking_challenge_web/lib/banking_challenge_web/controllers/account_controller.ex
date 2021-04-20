defmodule  BankingChallengeWeb.AccountController do
   @moduledoc """
   Actions related to the account resource.
   """
   use BankingChallengeWeb, :controller

   alias BankingChallenge.Accounts.Account
   # alias BankingChallenge.Transactions.Transaction

   @doc """
   Show the balance in account
   """
   def show(conn, params) do
      with {:ok, account} <- Account.fetch(params) do
         send_json(conn, 200, account.balance)
      else
         {:error, :not_found} ->
            msg = %{ type: "not found", description: "error"}
            send_json(conn, 412, msg)
      end
   end


   @doc """
   Create Account action.
   """
   def create(conn, params) do
      with {:ok, account} <- Account.create_new_account(params) do
        send_json(conn, 200, account)
      else
         {:error, %Ecto.Changeset{errors: errors}} ->
            msg = %{
               type: "bad_input",
               description: "Invalid input",
               details: changeset_errors_to_details(errors)
            }
            send_json(conn, 412, msg)
         {:error, :number_account_conflict} ->
            msg = %{ type: "conflict", description: "error"}
            send_json(conn, 412, msg)
      end
   end

   defp send_json(conn, status, body) do
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(status, Jason.encode!(body))
   end

   defp changeset_errors_to_details(errors) do
      errors
      |> Enum.map(fn {key, {message, _opts}} -> {key, message} end)
      |> Map.new()
   end

 end
