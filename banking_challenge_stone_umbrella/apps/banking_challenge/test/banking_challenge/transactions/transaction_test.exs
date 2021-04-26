defmodule BankingChallenge.Transactions.TransactionTest do

  use BankingChallenge.DataCase

  alias BankingChallenge.Transactions.Schemas.Transaction
  alias BankingChallenge.Accounts.Schemas.Account

  describe "create_new_transaction/1" do

    setup do
      params1 = %{"number_account" => 12126}
      params2 = %{"number_account" => 12136}

      {:ok, %Account{id: from_account_id}} = BankingChallenge.Accounts.Account.create_new_account(params1)
      {:ok, %Account{id: to_account_id}} = BankingChallenge.Accounts.Account.create_new_account(params2)

      {:ok, from_account_id: from_account_id, to_account_id: to_account_id}
    end

    test "when all params are valid, returms the transaction", %{from_account_id: from_account_id, to_account_id: to_account_id}   do

      params = %{"amount" => 10000, "from_account_id" => from_account_id, "to_account_id" => to_account_id}

      {:ok, %Transaction{id: transaction_id}} = BankingChallenge.Transactions.Transaction.create_new_transaction(params)

      transaction = Repo.get(Transaction, transaction_id)

      assert %Transaction{id: ^transaction_id} = transaction
    end

  end


end
