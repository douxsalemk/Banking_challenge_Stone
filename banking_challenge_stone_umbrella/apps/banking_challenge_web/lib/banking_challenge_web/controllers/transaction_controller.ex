defmodule BankingChallengeWeb.Transaction do
  @moduledoc """
  Actions related to the transactions resource.
  """
  use BankingChallengeWeb, :controller

#  alias BankingChallenge.Accounts.Account
  alias BankingChallenge.Transactions.Transaction

  @doc """
  Send the money to other account
  """
  def send(conn, params) do

    with :ok <- Transaction.send_to_other_account(params) do
      send_json(conn, 200, Transaction)
    else
      :error ->
         msg = %{ type: "invalid action", description: "error"}
         send_json(conn, 412, msg)
    end
  end

 #  def all(conn, params) do
 #      with {:ok, Transaction} <- Transaction.fetch(params) do
 #        send_json(conn, 200, Transaction)
 #      else
 #        {:error, :not_found} ->
 #           msg = %{ type: "not found", description: "error"}
 #           send_json(conn, 412, msg)
 #      end
 #  end

  @doc """
  Withdraw money to self account
  """
  def withdraw(conn, params) do
    with :ok  <- Transaction.withdraw_to_self_account(params) do
      send_json(conn, 200, Transaction)
    else
      :error ->
         msg = %{ type: "invalid action", description: "error"}
         send_json(conn, 412, msg)
    end
  end

  defp send_json(conn, status, body) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end

end
