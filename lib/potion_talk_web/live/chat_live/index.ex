defmodule PotionTalkWeb.ChatLive.Index do
  use PotionTalkWeb, :live_view
  def mount(%{"uname" => uname}, _session, socket) do
    if connected?(socket) do
      PotionTalkWeb.Endpoint.subscribe(topic())
    end
    {:ok, assign(socket, username: uname, messages: [])}
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      PotionTalkWeb.Endpoint.subscribe(topic())
    end
    {:ok, assign(socket, username: username(), messages: [])}
  end

  def handle_event("send", %{"text" => text}, socket) do
    PotionTalkWeb.Endpoint.broadcast(topic(), "message", %{text: text, name: socket.assigns.username})
    {:noreply, socket}
  end

  def handle_info(%{event: "message", payload: message}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  defp username do
    "DEFAULT"
  end

  defp topic do
    "chat"
  end
end
