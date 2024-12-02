defmodule PotionTalkWeb.ChatLive.List do
  use PotionTalkWeb, :live_view

  def mount(_params, _session, socket) do
    # if connected?(socket) do
    #   PotionTalkWeb.Endpoint.subscribe(:chat_list)
    # end
    {:ok, assign(socket, chats: get_chats())}
  end

  def handle_event("change_chat", %{"content" => chat_id}, socket) do
    PotionTalkWeb.Endpoint.broadcast("change_chat", "new_chat", %{chat_id: chat_id})
    {:noreply, socket}
  end

  # def handle_event("send", %{"text" => text}, socket) do
  #   PotionTalkWeb.Endpoint.broadcast(socket.assigns.chat_id, "message", %{text: text, name: socket.assigns.username})
  #   {:noreply, socket}
  # end

  # def handle_info(%{event: "message", payload: message}, socket) do
  #   {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  # end

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
