defmodule PotionTalkWeb.ChatLive.CreateChat do
  use PotionTalkWeb, :live_component

  def render(assigns) do
    ~H'''
    <form phx-submit="create" phx-target={@myself}>
      <input type="text" name="chat_name" />
      <button type="submit">Create</button>
    </form>
    '''
  end

  def handle_event("create", %{"chat_name" => chat_name}, socket) do
    send self(), {:create_chat, chat_name}
    {:noreply, socket}
  end
end
