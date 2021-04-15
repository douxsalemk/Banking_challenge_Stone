defmodule BankingChallenge.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transaction, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :from_account, :integer
      add :to_account, :integer
      add :amount, :integer

      add :account_id, references(:account, column: :id, type: :binary_id )

      timestamps()
    end

  end
end
