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
    IO.inspect(params)

    #with %{valid?: true} <- Account.changeset(params),
    #    {:ok, account} <- Repo.insert(changeset) do
#
#
    #    end

    case  changeset = Account.changeset(params) do
      %{valid?: true} ->
        case  Repo.insert(changeset) do
          {:ok, account} -> {:ok, account}
          {error, account} -> {error, account}
        end
      %{valid?: false} ->
        Logger.error("Error while creating new account. Error: #{inspect(changeset)}")
        {:error, changeset}
    end
  end

  @doc """
  Fetch a balance of an account from the database.
  """
  def fetch(%{"account_id" => account_id} = params) when is_map(params) do
    Logger.debug("Fetch account_balance by number_account: #{inspect(params)}")


    case Repo.get(Account, account_id) do

      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end

end
