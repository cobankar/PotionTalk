defmodule PotionTalkWeb.ChatLive.Index do
  use PotionTalkWeb, :live_view

  def mount(%{"uname" => uname}, _session, socket) do
    if connected?(socket) do
      PotionTalkWeb.Endpoint.subscribe("change_chat")
    end
    {:ok, assign(socket, username: uname, chat_id: chat_id())}
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      PotionTalkWeb.Endpoint.subscribe("change_chat")
    end
    {:ok, assign(socket, username: username(), chat_id: chat_id())}
  end

  def handle_info(%{event: "new_chat", payload: chat}, socket) do
    IO.puts(chat.chat_id)
    {:noreply, assign(socket, chat_id: chat.chat_id)}
  end

  defp username do
    "DEFAULT"
  end

  defp chat_id do
    "default_chat"
  end
end
