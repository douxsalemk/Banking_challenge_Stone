defmodule BankingChallengeWeb.AccountView do

  alias BankingChallenge.Accounts.Schemas.Account

  def render("account.json",  %{account: %Account{id: id, number_account: number_account, balance: balance}}) do
    %{
      message: "ok",
      account: %{
        id: id,
        number_account: number_account,
        balance: balance
      }
    }
  end
end
