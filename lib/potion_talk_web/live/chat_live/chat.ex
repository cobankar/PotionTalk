defmodule PotionTalkWeb.ChatLive.Chat do
  alias PotionTalk.Storage.ChatStorage
  use PotionTalkWeb, :live_view

  def mount(_params, %{"username" => username, "chat_id" => chat_id} = _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(PotionTalk.PubSub, "chat:events")
    end
    {:ok, assign(socket, username: username, chat_id: chat_id, messages: get_messages(chat_id))}
  end

  def handle_event("send", %{"text" => text}, socket) do
    ChatStorage.add_message(socket.assigns.chat_id, socket.assigns.username, text)
    {:noreply, socket}
  end

  def handle_info({:message_added, %{chat_id: chat_id, username: username, content: message}}, socket) do
    if chat_id != socket.assigns.chat_id do
      {:noreply, socket}
    else
      {:noreply, assign(socket, messages: socket.assigns.messages ++ [%{text: message, name: username}])}
    end
  end

  def handle_info(other, socket) do
    dbg(other)
    {:noreply, socket}
  end

  defp get_messages(chat_id) do
    case ChatStorage.get_messages(chat_id) do
      {:error, reason} ->
        :logger.info("could not fetch messages for chat #{chat_id}: #{reason}")
        []
      {:ok, messages} -> messages
    end
  end
end
