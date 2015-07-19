defmodule MyApp_7191136.AuthController do
  use MyApp_7191136.Web, :controller

  def index(conn, _params) do
    redirect conn, external: Fitbit.authorize_url!(scope: "settings sleep")
  end
end
