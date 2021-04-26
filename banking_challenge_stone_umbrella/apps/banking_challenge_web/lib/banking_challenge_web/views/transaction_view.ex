defmodule BankingChallengeWeb.TransactionView do

  #alias BankingChallenge.Accounts.Schemas.Transaction

  def render("transaction.json",  %{
    transaction: %{transaction: transaction, source_acc: source_acc, target_acc: target_acc}
    })do

    %{
      message: "Transaction successfully",
      transaction: %{
        transaction: %{
          from_account_id: transaction.from_account_id,
          to_account_id: transaction.to_account_id,
          amount: transaction.amount

        },
        source_acc: %{
          id: source_acc.id,
          balance: source_acc.balance
        },
        target_acc: %{
          id: target_acc.id,
          balance: target_acc.balance
        }
      }
    }
  end

  def render("withdraw.json",  %{
    transaction: %{transaction: withdraw, source_acc: source_acc}
    })do

    %{
      message: "Withdraw successfully",
      transaction: %{
        withdraw: %{
          from_account_id: withdraw.from_account_id,
          amount: withdraw.amount

        },
        source_acc: %{
          id: source_acc.id,
          balance: source_acc.balance
        },
      }
    }
  end
end
