defmodule TrainingWeb.TrainingJoin do
  use TrainingWeb, :live_view
  def mount(_params, _session, socket) do
    TrainingWeb.Endpoint.subscribe("messagerie")
    {:ok, assign(socket, message: [],current_channel: :one)}
  end
  def handle_info(%{event: event, payload: payload}, socket) do
    cond do
      payload == "" -> {:noreply, socket}
      true ->
        cond do
          socket.assigns[:current_channel] == :one && event == "one" ->
            {:noreply, assign(socket, message: socket.assigns.message ++ [payload[:text]], current_channel: :one)}
          socket.assigns[:current_channel] == :two && event == "two" ->
            {:noreply, assign(socket, message: socket.assigns.message ++ [payload[:text]], current_channel: :two)}
          true -> {:noreply, socket}

        end
    end
  end
  def handle_event("message", %{"text" => text}, socket) do

    case socket.assigns[:current_channel] do
      :one -> TrainingWeb.Endpoint.broadcast("messagerie", "one", %{text: text})
      :two -> TrainingWeb.Endpoint.broadcast("messagerie", "two", %{text: text})
    end

    {:noreply, socket}
  end
  def handle_event("One", _, socket) do
    {:noreply, assign(socket, %{message: socket.assigns.message, current_channel: :one})}
  end
  def handle_event("Two", _, socket) do
    {:noreply, assign(socket, %{message: socket.assigns.message, current_channel: :two})}
  end
  def render(assigns) do
    ~H"""
    <div class="flex justify-center">
      <button phx-click="One"class="text-white bg-purple-800 hover:bg-purple-300 mx-2 my-2 py-4 px-2 rounded">Channel One</button>
      <button phx-click="Two" class="text-white bg-purple-800 hover:bg-purple-300 mx-2 my-2 py-4 px-2 rounded">Channel Two</button>
    </div>
    <div class="flex justify-center text-white">

    <%= for m <- @message do %>
      <%= m %><br>
    <% end %>
    </div>
    <div class="">
      <div class="flex justify-center" >
        <form phx-submit="message" class="">
          <input type="text" name="text">
          <button class="text-white bg-green-300 hover:bg-green-600 py-2 px-2 rounded ">Envoyer</button>
        </form>
      </div>
    </div>
    """
  end
end
