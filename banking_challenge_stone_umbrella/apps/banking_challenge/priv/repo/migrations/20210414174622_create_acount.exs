defmodule BankingChallenge.Repo.Migrations.CreateAcount do
  use Ecto.Migration

  def change do
    create table(:account, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :number_account, :integer
      add :balance, :integer

      timestamps()
    end

    create unique_index(:account, [:number_account])

    create constraint(:account, :balance_must_be_greater_then_or_equal_to_zero, check: "balance >= 0")


  end
end
