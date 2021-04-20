defmodule BankingChallenge.Accounts.Schemas.Account do
  @moduledoc """
  Database schema representation of account table
  """

  use Ecto.Schema

  import Ecto.Changeset

  #colocar condição para não inserir um balance na criação da conta

  @required_fields [:number_account]
  @optional_fields []
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "account" do

    field :number_account, :integer, null: false
    field :balance, :integer, null: false, default: 1000

    timestamps()

  end

  @doc """
  Generate a changeset for create a new transaction
  """
  def changeset(struct \\ %__MODULE__{}, params) when is_map(params) do
    struct
    |> cast(params, @required_fields ++ @optional_fields ++ [:balance])
    |> check_constraint(:account, name: :balance_must_be_greater_then_or_equal)
    |> validate_required(@required_fields)
    |> validate_number(:balance, greater_than_or_equal_to: 0)
    |> unique_constraint(:number_account)  #?
  end

end
