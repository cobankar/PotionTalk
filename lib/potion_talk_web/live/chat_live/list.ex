defmodule PotionTalkWeb.ChatLive.List do
  use PotionTalkWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, chats: get_chats())}
  end

  def handle_event("change_chat", %{"content" => chat_id}, socket) do
    PotionTalkWeb.Endpoint.broadcast("change_chat", "new_chat", %{chat_id: chat_id})
    {:noreply, socket}
  end

  def handle_info({:create_chat, chat_name}, socket) do
    new_chat = %{id: chat_name}
    exists = Enum.member?(socket.assigns.chats, new_chat)
    if exists do
      {:noreply, put_flash(socket, :error, "Could not create: Chat already exists")}
    else
      {:noreply, assign(socket, chats: socket.assigns.chats ++ [new_chat])}
    end
  end

  def get_chats() do
    [
      %{
        id: "default_chat",
      },
      %{
        id: "second_chat",
      }
    ]
  end
end
