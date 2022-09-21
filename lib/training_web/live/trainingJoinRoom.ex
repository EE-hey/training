defmodule TrainingWeb.TrainingJoinRoom do
  use TrainingWeb, :live_view
  def mount(_params, _session,socket) do
    if connected?(socket) do
      #TrainingWeb.Endpoint.subscribe("room")
      #TrainingWeb.Endpoint.subscribe("One")
      #TrainingWeb.Endpoint.subscribe("Two")
    end
    {:ok, assign(socket, transport: %{"rooms" => [:one, :two, :three, :four], "title" => "Home", "message" => []})}
  end

  def handle_info(%{event: "One", payload: payload}, socket) do
    IO.inspect(payload)
    {:noreply, assign(socket, transport: %{"rooms" => [:one, :two, :three, :four], "title" => "One", "message" => payload[:transport]["message"]} )}
  end
  def handle_info(%{event: "Two", payload: payload}, socket) do
    IO.inspect(payload)
    {:noreply, assign(socket, transport: %{"rooms" => [:one, :two, :three, :four], "title" => "Two", "message" => payload[:transport]["message"]} )}
  end
  def handle_info(%{event: "Three", payload: payload}, socket) do
    IO.inspect(payload)
    {:noreply, assign(socket, transport: %{"rooms" => [:one, :two, :three, :four], "title" => "Three", "message" => payload[:transport]["message"]} )}
  end
  def handle_info(%{event: "Four", payload: payload}, socket) do
    IO.inspect(payload)
    {:noreply, assign(socket, transport: %{"rooms" => [:one, :two, :three, :four], "title" => "Four", "message" => payload[:transport]["message"]} )}
  end
  def handle_event("One", %{"text" => text}, socket) do
    TrainingWeb.Endpoint.broadcast("One", "One", transport: %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "One", "message" => socket.assigns.transport["message"] ++ [text]})
    IO.inspect "###"
    IO.inspect(socket.assigns.transport["message"])
    IO.inspect "###"
    {:noreply, socket}
  end
  def handle_event("Two", %{"text" => text}, socket) do
    TrainingWeb.Endpoint.broadcast("Two", "Two", transport: %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "Two", "message" => socket.assigns.transport["message"] ++ [text]})
    IO.inspect "###"
    IO.inspect(socket.assigns.transport["message"])
    IO.inspect "###"
    {:noreply, socket}
  end
  def handle_event("Three", %{"text" => text}, socket) do
    TrainingWeb.Endpoint.broadcast("Three", "Three", transport: %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "Three", "message" => socket.assigns.transport["message"] ++ [text]})
    IO.inspect "###"
    IO.inspect(socket.assigns.transport["message"])
    IO.inspect "###"
    {:noreply, socket}
  end
  def handle_event("Four", %{"text" => text}, socket) do
    TrainingWeb.Endpoint.broadcast("Four", "Four", transport: %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "Four", "message" => socket.assigns.transport["message"] ++ [text]})
    IO.inspect "###"
    IO.inspect(socket.assigns.transport["message"])
    IO.inspect "###"
    {:noreply, socket}
  end
  def handle_event("one", _, socket) do
    TrainingWeb.Endpoint.subscribe("One")
    socket = assign(socket, transport:  %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "One", "message" => []})
    {:noreply, socket}
  end
  def handle_event("two", _, socket) do
    TrainingWeb.Endpoint.unsubscribe("*")
    TrainingWeb.Endpoint.subscribe("Two")
    socket = assign(socket, transport:  %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "Two", "message" => []})
    {:noreply, socket}
  end
  def handle_event("three", _, socket) do
    TrainingWeb.Endpoint.subscribe("Three")
    socket = assign(socket, transport:  %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "Three", "message" => [] })
    {:noreply, socket}
  end
  def handle_event("four", _, socket) do
    TrainingWeb.Endpoint.subscribe("Four")
    socket = assign(socket, transport:  %{"rooms" => [:ok, :ok, :ok, :ok], "title" => "Four", "message" => [] })
    {:noreply, socket}
  end
  def handle_event("ok", _, socket) do
    socket = assign(socket, transport:  %{"rooms" => [:one, :two, :three, :four], "title" => "Home", "message" => [] })
    {:noreply, socket}
  end


  def render(assigns) do
    ~H"""
      <h1>Select the room in which you want to join :</h1>
      <h2><%= @transport["title"] %></h2>
      <form  class="flex my-5 py-5" phx-submit={@transport["title"]}>
        <div class="flex-auto">
          <input class="" type="text" name="text"/>
          <button class="text-white font-bold bg-blue-600 hover:bg-blue-800 mx-5 py-2 px-4 rounded">Envoyer <%= @transport["title"] %> !</button>
        </div>
      </form>
      <%= for room <- @transport["rooms"] do %>
        <button phx-click={room}><%= room %></button>
      <% end %>
      <br>
      <%= for message <- @transport["message"] do %>
        <%= message %>
        <br>
      <% end %>


    """
  end
end
