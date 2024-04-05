# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

config :kafka_ex,
  brokers: [
    {"10.0.2.2", 9092}
  ],
  consumer_group: :no_consumer_group,
  disable_default_worker: false,
  sync_timeout: 3000,
  # Supervision max_restarts - the maximum amount of restarts allowed in a time frame
  max_restarts: 10,
  # Supervision max_seconds -  the time frame in which :max_restarts applies
  max_seconds: 60,
  # Interval in milliseconds that GenConsumer waits to commit offsets.
  commit_interval: 5_000,
  # Threshold number of messages consumed for GenConsumer to commit offsets
  # to the broker.
  commit_threshold: 100,
  # The policy for resetting offsets when an :offset_out_of_range error occurs
  # Options:
  # - `:earliest` - Will move to the offset to the oldest available
  # - `:latest` - Will move the offset to the most recent.
  # - `:none` - The error will simply be raised
  auto_offset_reset: :none,
  # Interval in milliseconds to wait before reconnect to kafka
  sleep_for_reconnect: 400,
  # This is the flag that enables use of ssl
  use_ssl: false
