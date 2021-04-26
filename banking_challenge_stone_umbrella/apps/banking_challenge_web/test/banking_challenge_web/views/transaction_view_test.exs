_defmodule BankingChallengeWeb.TransactionViewTest do

  use BankingChallengeWeb.ConnCase

  alias BankingChallenge.Transactions.Schemas.Transaction
  alias BankingChallengeWeb.TransactionView


  test "render transaction.json" do

    params1 = %{"number_account" => 12126}
    params2 = %{"number_account" => 12136}

    {:ok, %Account{id: from_account_id}} = BankingChallenge.Accounts.Account.create_new_account(params1)
    {:ok, %Account{id: to_account_id}} = BankingChallenge.Accounts.Account.create_new_account(params2)

    {:ok, from_account_id: from_account_id, to_account_id: to_account_id}


    params = {"amount" => 1, "from_account_id" => from_account_id, "to_account_id" => to_account_id}

    {:ok, %Transaction %{
                        transaction: %{transaction: transaction,
                                       source_acc: source_acc,
                                       target_acc: target_acc}
                        } = transaction
    } = BankingChallenge.Transactions.Transaction.create_new_transaction(params)

    response = render(TransactionView, "transaction.json", transaction: transaction )

    assert "test" == response
  end

  test "render withraw.json" do

  end



  #def render("withdraw.json",  %{
  #  transaction: %{transaction: withdraw, source_acc: source_acc}
  #  })do
#
  #  %{
  #    message: "Withdraw successfully",
  #    transaction: %{
  #      withdraw: %{
  #        from_account_id: withdraw.from_account_id,
  #        amount: withdraw.amount
#
  #      },
  #      source_acc: %{
  #        id: source_acc.id,
  #        balance: source_acc.balance
  #      },
  #    }
  #  }
  #end
end
