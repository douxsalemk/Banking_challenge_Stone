defmodule BankingChallenge.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transaction, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :from_account_id, references(:account, type: :uuid )
      add :to_account_id, references(:account, type: :uuid )
      add :amount, :integer

      timestamps()
    end

    create constraint(:transaction, :amount_must_be_greater_then_or_equal_to_zero, check: "amount >= 0")

  end
end
