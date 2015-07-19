defmodule MyApp_7191136.PageControllerTest do
  use MyApp_7191136.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
