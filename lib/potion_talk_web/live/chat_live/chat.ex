defmodule PotionTalkWeb.ChatLive.Chat do
  use PotionTalkWeb, :live_view

  def mount(_params, %{"username" => username, "chat_id" => chat_id} = _session, socket) do
    if connected?(socket) do
      PotionTalkWeb.Endpoint.subscribe(chat_id)
    end
    {:ok, assign(socket, username: username, chat_id: chat_id, messages: [])}
  end

  def handle_event("send", %{"text" => text}, socket) do
    PotionTalkWeb.Endpoint.broadcast(socket.assigns.chat_id, "message", %{text: text, name: socket.assigns.username})
    {:noreply, socket}
  end

  def handle_info(%{event: "message", payload: message}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end
end
