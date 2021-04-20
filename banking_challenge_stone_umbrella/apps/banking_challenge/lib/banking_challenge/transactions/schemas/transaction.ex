defmodule BankingChallenge.Transactions.Schemas.Transaction do
  @moduledoc """
  Database schema representation of transaction table
  """

  use Ecto.Schema
  alias BankingChallenge.Accounts.Schemas.Account

  import Ecto.Changeset


  @required_fields [:from_account_id, :amount]
  @optional_fields [:to_account_id]


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transaction" do

    field :amount, :integer

    belongs_to :from_account, Account
    belongs_to :to_account, Account

    timestamps()

  end

  @doc """
  Generate a changeset for create a new transaction
  """
  def changeset(params) when is_map(params) do
    %__MODULE__{}
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> check_constraint(:transaction, name: :amount_must_be_greater_then_or_equal)
  end
end
