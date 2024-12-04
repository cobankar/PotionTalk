defmodule PotionTalk.Storage.ChatStorage do
  alias Phoenix.PubSub

  def start_link(_opts \\ []) do
    case :ets.info(:chats) do
      :undefined ->
        :ets.new(:chats, [:named_table, :public, :set])
      _ ->
        :ok
    end
    {:ok, self()}
  end

  def child_spec(arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, arg}
    }
  end

  # Add a new chat by ID
  def add_chat(chat_id) when is_bitstring(chat_id) do
    dbg(chat_id)
    :ets.insert(:chats, {chat_id, []})
    notify(:chat_added, chat_id)
  end

  # Add a message to a specific chat
  def add_message(chat_id, username, content) do
    case :ets.lookup(:chats, chat_id) do
      [{^chat_id, messages}] ->
        new_messages = [{username, content} | messages]
        :ets.insert(:chats, {chat_id, new_messages})
        notify(:message_added, %{chat_id: chat_id, username: username, content: content})
        :ok
      [] ->
        {:error, :chat_not_found}
    end
  end

  # Retrieve all messages for a specific chat
  def get_messages(chat_id) do
    case :ets.lookup(:chats, chat_id) do
      [{^chat_id, messages}] -> {:ok, Enum.reverse(messages)}
      [] -> {:error, :chat_not_found}
    end
  end

  def get_all_chats do
    :ets.tab2list(:chats)
    |> Enum.map(fn {chat_id, _messages} -> %{id: chat_id} end)
  end

  defp notify(event, payload) do
    PubSub.broadcast(PotionTalk.PubSub, "chat:events", {event, payload})
  end
end
