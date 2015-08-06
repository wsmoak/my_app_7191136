defmodule MyApp_7191136.AuthController do
  use MyApp_7191136.Web, :controller

  alias MyApp_7191136.User

  def index(conn, _params) do
    redirect conn, external: Fitbit.authorize_url!(scope: "settings sleep")
  end

  def callback(conn, %{"code" => code}) do
    token = Fitbit.get_token!(code: code)
    IO.inspect token

    user = OAuth2.AccessToken.get!(token, "/1/user/-/profile.json")
    IO.inspect user

    changeset = User.changeset(%User{},
      %{name: user["user"]["displayName"],
        email: token.other_params["user_id"],
        access_token: token.access_token,
        refresh_token: token.refresh_token,
#        expires_at: from_timestamp(token.expires_at)
# raises: ** (FunctionClauseError) no function clause matching in Ecto.Adapters.Postgres.DateTime.encode_timestamp/1
# probably need to re-do this all on Phoenix 0.16
      })

    # http://www.phoenixframework.org/v0.14.0/docs/ecto-models
    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      conn
      |> put_flash(:error, "ERROR!")
      |> redirect(to: :"/")
    end

    # This won't work until Phoenix 0.15
    #case Repo.insert(changeset) do
    #  {:ok, _user} ->
    #    conn
    #    |> put_flash(:info, "User added!")
    #    |> redirect(to: "/")
    #  {:error, changeset} ->
    #    IO.inspect changeset.errors
    #    conn
    #    |> put_flash(:error, "Error!")
    #    |> redirect(to: "/")
    #end
  end

  # from http://michal.muskala.eu/2015/07/30/unix-timestamps-in-elixir.html
  epoch = {{1970, 1, 1}, {0, 0, 0}}
  @epoch :calendar.datetime_to_gregorian_seconds(epoch)

  defp from_timestamp(timestamp) do
    timestamp
    |> +(@epoch)
    |> :calendar.gregorian_seconds_to_datetime
  end

end
