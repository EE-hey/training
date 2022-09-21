defmodule TrainingWeb.TrainingMessage do
  use TrainingWeb, :live_view
  def mount(_params,_session, socket) do
    # Check if a user is in the database that can access to this specific room
    # use case to check if that is true
    # ok : lets speak
    # not ok : redirect
    # get username
    if connected?(socket) do
      TrainingWeb.Endpoint.subscribe("chat")
    end
    {:ok, assign(socket, message: [])}
  end
  def handle_info(%{event: "msg", payload: message}, socket) do
    {:noreply, assign(socket, message: socket.assigns.message ++ [message])}
  end
  def handle_event("envoyer", %{"text" => text}, socket) do
    TrainingWeb.Endpoint.broadcast("chat", "msg", text)
    {:noreply, socket}
  end
  def render(assigns) do
    ~H"""
    <h1>Chat : </h1>
    <form phx-submit="envoyer">
      <input type="text" name="text">
      <button class="bg-green-300 rounded">Envoyer</button>
    </form>
    <div class="alert-info ">
      <%= for m <- @message  do %>
        <%= m %>
        <br>
      <% end %>
    </div>
    """
  end
end
