defmodule  BankingChallengeWeb.FallbackController do
  use BankingChallengeWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BankingChallengeWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
