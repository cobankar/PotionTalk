defmodule PotionTalkWeb.ChatLive.List do
  alias PotionTalk.Storage.ChatStorage
  use PotionTalkWeb, :live_view

  def mount(_params, %{"username" => username} =  _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(PotionTalk.PubSub, "chat:events")
    end
    {:ok, assign(socket, chats: get_chats(), username: username, show_create_chat: false)}
  end

  def handle_event("change_chat", %{"content" => chat_id}, socket) do
    dbg(socket)
    PotionTalkWeb.Endpoint.broadcast("change_chat", "new_chat", %{chat_id: chat_id, username: socket.assigns.username})
    {:noreply, socket}
  end

  def handle_event("open_form", _params, socket) do
    {:noreply, assign(socket, show_create_chat: true)}
  end

  def handle_info({:chat_added, chat_id}, socket) do
    new_chat = %{id: chat_id}
    {:noreply, assign(socket, chats: socket.assigns.chats ++ [new_chat])}
  end

  def handle_info({:show_create_chat_form, open}, socket) do
    {:noreply, assign(socket, show_create_chat: open)}
  end

  def handle_info(other, socket) do
    dbg(other)
    {:noreply, socket}
  end

  defp get_chats() do
    ChatStorage.get_all_chats()
  end
end
