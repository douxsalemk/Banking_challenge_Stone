defmodule BankingChallenge.Accounts.Account do

  @moduledoc """
  module for handling account database transactions
  """

  alias BankingChallenge.Accounts.Schemas.Account
  alias BankingChallenge.Repo
  require Logger

  @doc """
  create a new account
  """
  def create_new_account(params) when is_map(params) do
    Logger.info("Inserting new account")

    with %{valid?: true} = changeset <- Account.changeset(params),
         {:ok, Account} <- Repo.insert(changeset) do
      Logger.info("Account successfully created. Number: #{params}")
    else
      %{valid?: false} = changeset ->
        Logger.error("Error while creating new account. Error: #{inspect(changeset)}")
        {:error, changeset}
    end
 #    rescue
 #      Ecto.ConstraintError ->
 #          Logger.error("Account already taken")
 #          {:error, :account_conflict}
  end

  @doc """
  Fetch a balance of an account from the database.
  """
  def fetch(%{account_id: account_id} = params) when is_map(params) do
    Logger.debug("Fetch account_balance by number_account: #{inspect(params)}")


    case Repo.get(Account, account_id) do

      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end

end
