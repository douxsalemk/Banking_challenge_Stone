defmodule BankingChallenge.Transactions.Schemas.Transaction do
  @moduledoc """
  Database schema representation of transaction table
  """

  use Ecto.Schema
  alias BankingChallenge.Accounts.Schemas.Account

  import Ecto.Changeset


  @required_fields [:from_account, :amount, :account_id]
  @optional_fields [:to_account]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transaction" do

    field :from_account, :integer, null: false
    field :to_account, :integer
    field :amount, :integer, null: false

    belongs_to :account, Account, primary_key: true

    timestamps()

  end

  @doc """
  Generate a changeset for create a new transaction
  """
  def changeset(params) when is_map(params) do
    %__MODULE__{}
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    #|> cast_assoc(:account_id, required: true, with: &Account.changeset/1)
  end
end
