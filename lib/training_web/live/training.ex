defmodule TrainingWeb.Training do
  use TrainingWeb, :live_view
  def mount(_params, _session, socket) do

    if connected?(socket) do
      TrainingWeb.Endpoint.subscribe("counting")
    end
    {:ok, assign(socket, :count, 0)}

  end
  def render(assigns) do
    ~H"""
    <%= @count %>
    <button phx-click="plus"> + 1 </button>
    <button phx-click="minus"> - 1</button>
    """
  end

  def handle_info(%{event: "plus", payload: %{count: num} }, socket) do
    {:noreply, assign(socket, :count, num)}
  end
  def handle_info(%{event: "minus", payload: %{count: num} }, socket) do
    {:noreply, assign(socket, :count, num)}
  end
  def handle_event("plus", _, socket) do
    counter = socket.assigns.count + 1
    TrainingWeb.Endpoint.broadcast("counting", "plus", %{count: counter})
    socket = assign(socket, :count, counter)
    {:noreply, socket}
  end
  def handle_event("minus", _, socket) do

    cond do
      socket.assigns.count == 0 ->
        TrainingWeb.Endpoint.broadcast("counting", "minus", %{count: socket.assigns.count})
        {:noreply, socket}
      true ->
        counter = socket.assigns.count - 1
        TrainingWeb.Endpoint.broadcast("counting", "minus", %{count: counter})
        socket = assign(socket, :count, counter)
        {:noreply, socket}
    end
  end
end
