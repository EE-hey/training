defmodule TrainingWeb.TrainingVote do
  use TrainingWeb, :live_view
  import Training.Accounts

  def mount(_params, _session = %{"user_token" => user_token}, socket) do
    current_user = get_user_by_session_token(user_token)
    if connected?(socket) do
      TrainingWeb.Endpoint.subscribe("converse")
    end
    {:ok, assign(socket,  test: current_user.email ,message:  [])}
  end

  def handle_info(%{event: "msg", payload: payload}, socket) do
    {:noreply, assign(socket, test: socket.assigns.test, message: payload[:message])}
  end

  def handle_event("envoyer", %{"text" => text}, socket) do
    message =  socket.assigns.message  ++ [socket.assigns.test <> " : " <> text]
    TrainingWeb.Endpoint.broadcast("converse", "msg", username: socket.assigns.test, message: message)
    socket = assign(socket, test: socket.assigns.test , message: message)
    {:noreply, socket}
  end
  def render(assigns) do

    IO.inspect(assigns)
    ~H"""
    <h1>Vote</h1>
    <div class="container mx-5 px-5">
      <div class="alert-info rounded">
        <%= for m <- @message  do %>
            <div class="px-2 py-3"><%= m %></div>
            <br>
        <% end %>
      </div>
      <form  class="flex my-5 py-5" phx-submit="envoyer">
        <div class="flex-auto">
          <input class="" type="text" name="text"/>
          <button class="text-white font-bold bg-blue-600 hover:bg-blue-800 mx-5 py-2 px-4 rounded">Envoyer !</button>
        </div>
      </form>
    </div>
    """
  end
end
