defmodule Consumers.Application do
  use Application

  @impl true
  def start(_type, _args) do
    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]

    # gen_consumer_impl = Consumers.AttrsChanges.Inserts
    # consumer_group_name = "attrs_changes_insets_group"
    # topic_names = ["insert.contact_analytics.contacts", "update.contact_analytics.contacts"]

    children = [
      # ... other children
      %{
        id: Consumers.AttrsChanges.Inserts,
        start: {
          KafkaEx.ConsumerGroup,
          :start_link,
          [Consumers.AttrsChanges.Inserts, "attrs_changes_insets_group", ["insert.contact_analytics.contacts"], consumer_group_opts]
        }
      },
      %{
        id: Consumers.AttrsChanges.Updates,
        start: {
          KafkaEx.ConsumerGroup,
          :start_link,
          [Consumers.AttrsChanges.Updates, "attrs_changes_updates_group", ["update.contact_analytics.contacts"], consumer_group_opts]
        }
      }
      # ... other children
    ]

    # Supervisor.start_link(children, strategy: :one_for_one)

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end