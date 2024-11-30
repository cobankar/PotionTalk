defmodule PotionTalkWeb.PageController do
  use PotionTalkWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def login(conn, %{"uname" => uname}) do
    conn
    |> Plug.Conn.assign(:uname, uname)
    |> redirect(to: ~p"/chat?uname=#{uname}")
  end
end
