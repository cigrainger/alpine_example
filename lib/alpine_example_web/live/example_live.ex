defmodule AlpineExampleWeb.ExampleLive do
  use AlpineExampleWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
      <button phx-click="click">Click me</button>
      <div>LiveView value: <%= @shadowed %></div>
      <div x-data={"{shadowed: '#{@shadowed}'}"}>
        Alpine value: <span x-text="shadowed"></span>
      </div>
      <div x-data="{shadowed: ''}" x-init={"shadowed = '#{@shadowed}'"}>
        Alpine x-init value: <span x-text="shadowed"></span>
      </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, shadowed: "foo")}
  end

  @impl true
  def handle_event("click", _params, socket) do
    {:noreply, update(socket, :shadowed, &set_shadowed/1)}
  end

  defp set_shadowed("foo"), do: "bar"
  defp set_shadowed("bar"), do: "foo"
end
