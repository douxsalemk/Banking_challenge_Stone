defmodule BankingChallenge.Transactions.Transaction do

  @moduledoc """
  module for handling account database transactions
  """

  alias BankingChallenge.Transactions.Schemas.Transaction
  alias BankingChallenge.Accounts.Schemas.Account
  alias BankingChallenge.Repo
  alias Ecto.Multi
  require Logger

  @doc """
  Transfer
  """
  def send_to_other_account(%{from_account_id: from_account_id, to_account_id: to_account_id, amount: amount} = params) when is_integer(amount) do
    Multi.new()
    |> Multi.run(:create_new_transaction, fn _repo, _changes -> create_new_transaction(params) end)
    |> Multi.run(:get_source_account, fn _repo, _changes -> get_account_by_id(from_account_id) end)
    |> Multi.run(:update_source_acc_balance, fn _repo, %{get_source_account: account} ->
      update_source_acc_balance(account, amount)
    end )
    |> Multi.run(:get_target_account, fn _repo, _changes -> get_account_by_id(to_account_id) end)
    |> Multi.run(:update_target_acc_balance, fn _repo, %{get_target_account: account} ->
      update_target_acc_balance(account, amount)
    end)
    |> Repo.transaction()
  end

  @doc """
  withraw to self account
  """
  def withdraw_to_self_account(%{from_account_id: from_account_id, amount: amount} = params) do
    Multi.new()
    |> Multi.run(:get_source_account, fn _repo, _changes -> get_account_by_id(from_account_id) end)
    |> Multi.run(:update_source_acc_balance, fn _repo, %{get_source_account: account} ->
      update_source_acc_balance(account, amount)
    end )
    |> Multi.run(:create_new_transaction, fn _repo, _changes -> create_new_transaction(params) end)
    |> Repo.transaction()
  end


  #  @doc """
  #  Fetch a balance of an account from the database.
  #  """
  #  def fetch(params) when is_map(params) do
  #    Logger.debug("Fetch all transaction of any account: #{inspect(params)}")
  #
  #    case Repo.get(Transaction, %{number_account: number_account} = params) do
  #      nil -> {:error, :not_found}
  #      transaction -> {:ok, transaction}
  #    end
  #  end



  defp get_account_by_id(account_id) do
    Repo.get(Account, account_id)
    |> case do
      %Account{} = account -> {:ok, account}
      #{:ok, account} -> {:ok, account}
      nil -> {:error, :account_not_found}
    end
  end

  defp update_source_acc_balance(account, amount) do
    account
    |> withdraw_amount_in_balance(amount)
    |> update_account(account)
  end

  defp withdraw_amount_in_balance(%Account{balance: balance}, amount) do
    amount
    |> handle_cast2(balance)
  end

  defp handle_cast2(amount, balance) when balance > amount, do: balance - amount


  defp update_target_acc_balance(account, amount) do
    account
    |> sum_amount_in_balance(amount)
    |> update_account(account)
  end

  defp sum_amount_in_balance(%Account{balance: balance}, amount) do
    amount
    |> handle_cast1(balance)
  end

  defp handle_cast1(amount, balance), do: amount + balance

  defp update_account({:error, _reason} = error, _account), do: error
  defp update_account(amount, account) do
    params = %{balance: amount}

    account
    |> Account.changeset(params)
    |> Repo.update()

  end


  @doc """
  create a new transaction
  """
  def create_new_transaction(params) when is_map(params) do
    Logger.info("Inserting new transaction")
    Logger.info("#{inspect(params)}")

    with %{valid?: true} = changeset <- Transaction.changeset(params) do
          Repo.insert(changeset)
    else
      %{valid?: false} = changeset ->
        Logger.error("Error while doing a new transaction. Error: #{inspect(changeset)}")
        {:error, changeset}
    end
  end
end
