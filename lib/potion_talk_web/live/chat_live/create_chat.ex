defmodule PotionTalkWeb.ChatLive.CreateChat do
  alias PotionTalk.Storage.ChatStorage
  use PotionTalkWeb, :live_component

  def render(assigns) do
    ~H'''
    <div>
      <% dbg(assigns) %>
      <%= if @show_create_chat do %>
        <form phx-submit="create" phx-target={@myself}>
          <input class="bg-inherit border-0 border-2" type="text" name="chat_name" placeholder="new chat name..."/>
          <button type="submit">Create</button>
        </form>
      <% else %>
        <button phx-click="open_form" phx-target={@myself}>+</button>
      <% end %>
    </div>
    '''
  end

  def handle_event("create", %{"chat_name" => chat_name}, socket) do
    ChatStorage.add_chat(chat_name)
    send self(), {:show_create_chat_form, false}
    {:noreply, socket}
  end

  def handle_event("open_form", _params, socket) do
    send self(), {:show_create_chat_form, true}
    {:noreply, socket}
  end
end
