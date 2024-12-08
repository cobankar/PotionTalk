# PotionTalk
Chat App written in elixir to get to know the language. I used Phoenix and Pheonix LiveView to create the application.

# Overview
You will find instruciton on running the application below. Once you access the app through your browser, you can type in a username where promted. Then you should be able to see the chat interface. You can create new chat rooms (you will have to do so after startup as none exist). You can click on chats on the left to open them. You can send messages in different chat rooms. To see it working you can also open a different tab/browser and connect to the service as well. When logged in you will also see the chat rooms and messages created by your other session.

# Get it running
You need to have erlang, elixir and pheonix installed. You can find installation guidelines for elixir (erlang) [here](https://elixir-lang.org/install.html). Installation for Pheonix requires to run
`mix archive.install hex phx_new`.
If that does not work have a look at the installation instructions [here](https://hexdocs.pm/phoenix/installation.html)

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
