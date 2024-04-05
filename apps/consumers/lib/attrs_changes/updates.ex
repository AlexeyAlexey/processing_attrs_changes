defmodule Consumers.AttrsChanges.Updates do
  use KafkaEx.GenConsumer

  alias KafkaEx.Protocol.Fetch.Message

  require Logger

  # note - messages are delivered in batches
  def handle_message_set(message_set, state) do

    for %Message{value: message} <- message_set do
      # IO.inspect(message)
      IO.puts("UPDATES")

      Jason.decode!(message)
      |> decode_payload()
      |> IO.inspect()
      # Logger.debug(fn -> "message: " <> inspect(message) end)
    end

    {:async_commit, state}
  end

  defp decode_payload(%{"payload" => payload}) do
    Jason.decode!(payload)
  end

  defp decode_payload(message) do
    message
  end
end

# %{
#   "payload" => "{\"_id\": {\"_data\": \"826610030...\"}, \"operationType\": \"insert\", \"clusterTime\": {\"$timestamp\": {\"t\": 1712325385, \"i\": 2}}, \"wallTime\": {\"$date\": 1712325385755}, \"fullDocument\": {\"_id\": {\"$oid\": \"6610030974b5657c8235a82d\"}, \"app_id\": {\"$oid\": \"65eb23f074b565318d6b51a3\"}, \"inserted_at\": {\"$date\": 1712325385000}, \"updated_at\": {\"$date\": 1712325385000}, \"attr_string\": [{\"id\": 2, \"v\": \"email@mail.com\", \"up_at\": {\"$date\": 1712325385609}}], \"attr_bigint\": [{\"id\": 1, \"v\": 98765, \"up_at\": {\"$date\": 1712325385609}}]}, \"ns\": {\"db\": \"contact_analytics\", \"coll\": \"contacts\"}, \"documentKey\": {\"_id\": {\"$oid\": \"6610030974b5657c8235a82d\"}}}",
#   "schema" => %{"optional" => false, "type" => "string"}
# }

