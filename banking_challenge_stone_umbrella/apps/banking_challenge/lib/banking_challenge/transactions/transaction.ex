defmodule BankingChallenge.Transactions.Transaction do

  @moduledoc """
  module for handling account database transactions
  """

  alias BankingChallenge.Transactions.Schemas.Transaction
  alias BankingChallenge.Repo
  require Logger

  @doc """
  to do a new account
  """
  def create_new_transaction(params) when is_map(params) do
    Logger.info("Inserting new transaction")
    Logger.info("#{inspect(params)}")

    with %{valid?: true} = changeset <- Transaction.changeset(params),
         {:ok, %Transaction{}} <- Repo.insert(changeset) do
      Logger.info("Transaction successfull.")
    else
      %{valid?: false} = changeset ->
        Logger.error("Error while doing a new transaction. Error: #{inspect(changeset)}")
        {:error, changeset}
    end
  end
end
