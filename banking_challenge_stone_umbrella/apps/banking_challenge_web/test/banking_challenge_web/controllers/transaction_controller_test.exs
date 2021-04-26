defmodule BankingChallengeWeb.TransactionControllerTest do

  use BankingChallengeWeb.ConnCase

  alias BankingChallenge.Accounts.Schemas.Account

  describe "send/2" do

    setup %{conn: conn} do
      params1 = %{"number_account" => 12123}
      params2 = %{"number_account" => 12133}

      {:ok, %Account{id: from_account_id}} = BankingChallenge.Accounts.Account.create_new_account(params1)
      {:ok, %Account{id: to_account_id}} = BankingChallenge.Accounts.Account.create_new_account(params2)

      {:ok, conn: conn, from_account_id: from_account_id, to_account_id: to_account_id}
    end

    test "when all params are valid, make de transfer", %{conn: conn, from_account_id: from_account_id, to_account_id: to_account_id} do
      params = %{
        "amount" => 1,
        "from_account_id" => from_account_id,
        "to_account_id" => to_account_id
      }

      response =
        conn
        |> post(Routes.transaction_path(conn, :send), params)
        |> json_response(:ok)

      assert  %{
                 "message" => "Transaction successfully",
                 "transaction" => %{"source_acc" => %{"balance" => 999, "id" => id},
                                    "target_acc" => %{"balance" => 1001, "id" => id2},
                                    "transaction" => %{"amount" => 1, "from_account_id" => id, "to_account_id" => id2}}
      } = response

    end

    #test "when all params are invalid, returns an error", %{conn: conn, from_account_id: from_account_id, to_account_id: to_account_id} do
    #  params = %{
    #    "amount" => "abc",
    #    "from_account_id" => from_account_id,
    #    "to_account_id" => to_account_id
    #  }
#
    #  response =
    #    conn
    #    |> post(Routes.transaction_path(conn, :send), params |> IO.inspect(label: "Response conn"))
    #    |> json_response(:bad_request)
#
    #  assert  %{
    #             "message" => "Transaction successfully",
    #             "transaction" => %{"source_acc" => %{"balance" => 999, "id" => id},
    #                                "target_acc" => %{"balance" => 1001, "id" => id2},
    #                                "transaction" => %{"amount" => 1, "from_account_id" => id, "to_account_id" => id2}}
    #  } = response
#
    #end
  end

  describe "withdraw/2" do

    setup %{conn: conn} do
      params = %{"number_account" => 12125}

      {:ok, %Account{id: from_account_id}} = BankingChallenge.Accounts.Account.create_new_account(params)
      {:ok, conn: conn, from_account_id: from_account_id}
    end

    test "when all params are valid, make the withdraw", %{conn: conn, from_account_id: from_account_id} do

      params = %{
        "amount" => 1,
        "from_account_id" => from_account_id
      }

      response =
        conn
        |> post(Routes.transaction_path(conn, :withdraw), params)
        |> json_response(:ok)

      assert  %{
                "message" => "Withdraw successfully",
                "transaction" => %{"source_acc" => %{"balance" => 999, "id" => id3},
                "withdraw" => %{"amount" => 1, "from_account_id" => id3}}
      } = response

    end

    #test "when all params are invalid, returns an error", %{conn: conn, from_account_id: from_account_id} do
#
    #  params = %{
    #    "amount" => "abc",
    #    "from_account_id" => from_account_id
    #  }
#
    #  response =
    #    conn
    #    |> post(Routes.transaction_path(conn, :withdraw), params)
    #    |> json_response(:bad_request)
#
    #  assert  %{
    #            "message" => "Withdraw successfully",
    #            "transaction" => %{"source_acc" => %{"balance" => 999, "id" => id3},
    #            "withdraw" => %{"amount" => 1, "from_account_id" => id3}}
    #  } = response
#
    #end

  end
end
