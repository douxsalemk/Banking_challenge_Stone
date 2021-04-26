defmodule BankingChallenge.Accounts.AccountTest do
  use BankingChallenge.DataCase
  alias BankingChallenge.Accounts.Schemas.Account
  #alias BankingChallenge.Accounts.Account

  describe "create_new_account/1" do
    test "when all params are valid, returms an user" do
      params = %{"number_account" => 1212}

      {:ok, %Account{id: account_id}} = BankingChallenge.Accounts.Account.create_new_account(params)

      account = Repo.get(Account, account_id)

      assert %Account{number_account: 1212, id: ^account_id} = account
    end

    test "when all params are invalid, returms an error" do
      params = %{"number_account" => "abc"}

      {:error, changeset} = BankingChallenge.Accounts.Account.create_new_account(params)

      expected_response = %{number_account: ["is invalid"]}

      assert errors_on(changeset) == expected_response
    end

  end


end
