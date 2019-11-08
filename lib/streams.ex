defmodule CodeFlow.Streams do
  @moduledoc """
  Code that sets up scenarios where you can play and develop a better sense for
  how Enum and Stream compare.
  """

  def experiment_1_enum(data) do
    simple_measurements(fn ->
      data
      |> Enum.map(&(&1 * 2))
      |> Enum.map(&(&1 + 1))
      |> Enum.map(&(&1 + 2))
      |> Enum.map(&(&1 + 3))
      |> Enum.map(&(&1 + 4))
      |> Enum.map(&(&1 + 5))
      |> Enum.map(&(&1 + 6))
      |> Enum.map(&(&1 + 7))
      |> Enum.map(&(&1 + 8))
      |> Enum.map(&(&1 + 9))
      |> Enum.map(&(&1 - 10))
      |> Enum.to_list()
    end)
  end

  def experiment_1_stream(data) do
    simple_measurements(fn ->
      data
      |> Stream.map(&(&1 * 2))
      |> Stream.map(&(&1 + 1))
      |> Stream.map(&(&1 + 2))
      |> Stream.map(&(&1 + 3))
      |> Stream.map(&(&1 + 4))
      |> Stream.map(&(&1 + 5))
      |> Stream.map(&(&1 + 6))
      |> Stream.map(&(&1 + 7))
      |> Stream.map(&(&1 + 8))
      |> Stream.map(&(&1 + 9))
      |> Stream.map(&(&1 - 10))
      |> Enum.to_list()
    end)
  end

  def steps_in_enum(data) do
    data
    |> IO.inspect(label: "original")
    |> Enum.map(&(&1 * 2))
    |> IO.inspect(label: "* 2")
    |> Enum.map(&(&1 + 3))
    |> IO.inspect(label: "+ 3")
    |> Enum.map(&to_string(&1))
    |> IO.inspect(label: "to_string")
    |> Enum.map(&(&1 <> ".00"))
  end

  def steps_in_enum2(data) do
    data
    |> IO.inspect(label: "original")
    |> Enum.map(&IO.inspect(&1 * 2, label: "Step 1"))
    |> IO.inspect(label: "* 2")
    |> Enum.map(&IO.inspect(&1 + 3, label: "Step 2"))
    |> IO.inspect(label: "+ 3")
    |> Enum.map(&IO.inspect(to_string(&1), label: "Step 3"))
    |> IO.inspect(label: "to_string")
    |> Enum.map(&IO.inspect("$#{&1}.00", label: "Step 4"))
    |> Enum.take(5)
  end

  def steps_in_enum3(data) do
    # self()
    # |> Process.info()
    # |> Keyword.get(:heap_size)
    # |> IO.inspect(label: "Process heap size BEFORE")
    :erlang.garbage_collect()
    IO.puts(process_memory())
    start = Time.utc_now()

    data
    |> Enum.map(&(&1 * 2))
    |> Enum.map(&(&1 + 1))
    |> Enum.map(&(&1 + 2))
    |> Enum.map(&(&1 + 3))
    |> Enum.map(&(&1 + 4))
    |> Enum.map(&(&1 + 5))
    |> Enum.map(&(&1 + 6))
    |> Enum.map(&(&1 + 7))
    |> Enum.map(&(&1 + 8))
    |> Enum.map(&(&1 + 9))
    |> Enum.map(&(&1 - 10))
    # |> Enum.map(&to_string(&1))
    # |> Enum.map(&"$#{&1}.00")
    # |> Enum.take(5)
    # |> Enum.to_list()
    |> Enum.sum()

    stop = Time.utc_now()
    IO.puts(process_memory())
    IO.puts("#{Time.diff(stop, start, :millisecond)} msec")
    # self()
    # |> Process.info()
    # |> Keyword.take([:heap_size, :total_heap_size])
    # |> IO.inspect(label: "Process heap size AFTER")

    :ok
  end

  def process_memory() do
    {:memory, value} = :erlang.process_info(self(), :memory)
    :erlang.float_to_binary(value / 1024 / 1024, decimals: 2) <> " MB"
  end

  @doc """
  This function just helps wrap the experimental one inside some crude
  measurement tools. These help give some feedback about how the function
  performed.
  """
  def simple_measurements(fun) do
    # Force garbage collection before running the experiment.
    # You would never do this in a production system!
    :erlang.garbage_collect()
    # Print out the starting memory usage
    IO.puts(process_memory())

    # start the timer
    start = Time.utc_now()

    # execute the passed in function. Ignore the result as that isn't what we
    # care about right now.
    _result = fun.()

    # stop the timer, output the final memory usage and time.
    stop = Time.utc_now()
    IO.puts(process_memory())
    IO.puts("#{Time.diff(stop, start, :millisecond)} msec")

    # We don't actually care to receive the function's result. Return an `:ok`
    # prevents a very large returned value from being added to the IEx history
    # which takes up more RAM and isn't part of a normal running system.
    :ok
  end

  # NOTE: This is NOT precise. Strings are managed on a separate binary heap,
  # garbage collection kicks in for long running processes, etc. This just helps
  # give a snapshot idea of what's going on.
  #
  # CodeFlow.Streams.steps_in_enum3(1..10_000_000)

  def steps_in_stream(data) do
    data
    |> IO.inspect(label: "original")
    |> Stream.map(&(&1 * 2))
    |> IO.inspect(label: "* 2")
    |> Stream.map(&(&1 + 3))
    |> IO.inspect(label: "+ 3")
    |> Stream.map(&to_string(&1))
    |> IO.inspect(label: "to_string")
    |> Stream.map(&"$#{&1}.00")
    |> IO.inspect(label: "final")
    |> Enum.to_list()
  end

  def steps_in_stream2(data) do
    data
    |> IO.inspect(label: "original")
    |> Stream.map(&IO.inspect(&1 * 2, label: "Step 1"))
    |> IO.inspect(label: "* 2")
    |> Stream.map(&IO.inspect(&1 + 3, label: "Step 2"))
    |> IO.inspect(label: "+ 3")
    |> Stream.map(&IO.inspect(to_string(&1), label: "Step 3"))
    |> IO.inspect(label: "to_string")
    |> Stream.map(&IO.inspect("$#{&1}.00", label: "Step 4"))
    |> Enum.take(5)
  end

  def steps_in_stream3(data) do
    # self()
    # |> Process.info()
    # |> Keyword.get(:heap_size)
    # |> IO.inspect(label: "Process heap size BEFORE")
    :erlang.garbage_collect()
    IO.puts(process_memory())
    start = Time.utc_now()

    data
    |> Stream.map(&(&1 * 2))
    |> Stream.map(&(&1 + 1))
    |> Stream.map(&(&1 + 2))
    |> Stream.map(&(&1 + 3))
    |> Stream.map(&(&1 + 4))
    |> Stream.map(&(&1 + 5))
    |> Stream.map(&(&1 + 6))
    |> Stream.map(&(&1 + 7))
    |> Stream.map(&(&1 + 8))
    |> Stream.map(&(&1 + 9))
    |> Stream.map(&(&1 - 10))
    # |> Stream.map(&to_string(&1))
    # |> Stream.map(&"$#{&1}.00")
    # |> Enum.take(5)
    # |> Enum.to_list()
    |> Enum.sum()

    stop = Time.utc_now()
    IO.puts(process_memory())
    IO.puts("#{Time.diff(stop, start, :millisecond)} msec")

    # self()
    # |> Process.info()
    # |> Keyword.take([:heap_size, :total_heap_size])
    # |> IO.inspect(label: "Process heap size AFTER")

    :ok
  end

  # CodeFlow.Streams.steps_in_stream3(1..1_000_000)

  @doc """
  Count the number of words in a large text file.
  """
  @spec count_words(filename :: String.t()) :: {:ok, integer()} | {:error, String.t()}
  def count_words(filename) do
    File.open(filename, [:read], fn file ->
      IO.read(file, :line)
    end)
  end

  def via_resource(filename) do
    file_stream =
      Stream.resource(
        fn -> File.open!(filename) end,
        fn file ->
          case IO.read(file, :line) do
            data when is_binary(data) ->
              word_count = data |> String.split(" ") |> Enum.count()
              {[word_count], file}

            _ ->
              # :eof
              {:halt, file}
          end
        end,
        fn file -> File.close(file) end
      )

    Enum.to_list(file_stream)
    # Returns a list of the number of words per line
    #
    # [33, 36, 33, 42, 21, 16, 12, 20, 19, 16, 10, 33, 36, 32, 38, 36, 39, 38, 15, 30,
    #  18, 26, 22, 21, 40, 12, 27, 19, 15, 30, 21, 26, 37, 38, 29, 21, 15, 21, 25, 23,
    #  21, 40, 28, 26, 44, 15, 22, 34, 18, 34, ...]
  end

  def file_stream(filename) do
    File.stream!(filename, [:read], :line)
    |> Stream.map(fn line -> line |> String.split(" ") |> Enum.count() end)
    |> Enum.to_list()

    # Returns a list of the number of words per line
    # [33, 36, 33, 42, 21, 16, 12, 20, 19, 16, 10, 33, 36, 32, 38, 36, 39, 38, 15, 30,
    #  18, 26, 22, 21, 40, 12, 27, 19, 15, 30, 21, 26, 37, 38, 29, 21, 15, 21, 25, 23,
    #  21, 40, 28, 26, 44, 15, 22, 34, 18, 34, ...]
  end

  # CodeFlow.Streams.steps_in_enum2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  # CodeFlow.Streams.steps_in_stream2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  # TODO: create a graphic that explains/shows the Enum process and one for the Stream process
  # The Stream doesn't execute a single call until something requests a value. Enum functions will do that.

  # CodeFlow.Streams.steps_in_stream3(1..10_000_000)
end

# CodeFlow.Streams.steps_in_enum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# CodeFlow.Streams.steps_in_stream2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# :erlang.garbage_collect()

# Using System Monitor, able to see the `beam.smp` process, do work, grow RAM and do some level of GC. Force GC, run the stream version. Very fast, no RAM increase!

# Code organization Notes
#
# -- This is really about RDMBs design
#
# They share 99% of information, the only difference are `is_client` and `is_supplier` fields
# It's for an internal invoicing and office management tool

# gregvaughn
# `parties` is how old-school Data Architects referred to that sort of thing
# a `party` represents some individual or group that can engage in some other relationship
# I learned it from a co-worker when I was at a bank. Here's a reasonable result from googling "data architecture pattern party" http://tdan.com/a-universal-person-and-organization-data-model/5014

# TODO: Generate a CSV file using Faker names, phone numers, emails, etc. Create a value for 6 months of sales Jan-June. Stream process to get a total for June numbers

# TODO: CodeDesign course -- use mix to create a project.
#   - add mix dependencies
#   - could monitor for CSV files to appear in a watched folder
#   - use a GenServer to monitor... launch a Task to process a file
#   - Generate a report file
#   - drop multiple files in and have them concurrently processed
#   - Can build all the pieces, put it together to have a working app
#   - A specific file could intentionally cause it to blow up. Discuss supervision strategies?

# Spotting problems:

# Installing Erlang via `asdf` could show this...

# Building Erlang/OTP 19.3.6.9 (asdf_19.3.6.9), please wait...
# APPLICATIONS DISABLED (See: /home/mark/.asdf/plugins/erlang/kerl-home/builds/asdf_19.3.6.9/otp_build_19.3.6.9.log)
#  * crypto         : No usable OpenSSL found
#  * jinterface     : No Java compiler found
#  * ssh            : No usable OpenSSL found
#  * ssl            : No usable OpenSSL found

# mark@mark-desktop-wd code_flow [master !?]$ asdf current
# elixir         1.9.1-otp-22 (set by /home/mark/.tool-versions)
# erlang         19.3.6.9 (set by /home/mark/thinking_code/code_flow/.tool-versions)

# $ elixir -v
# {"init terminating in do_boot",{undef,[{elixir,start_cli,[],[]},{init,start_em,1,[]},{init,do_boot,3,[]}]}}
# init terminating in do_boot ()

# Crash dump is being written to: erl_crash.dump...done

# $ erl
# Erlang/OTP 19 [erts-8.3.5.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

# Having an umbrella project, openning and editing an app within the umbrella. Need to open the root of the project.

# Starting VS Code, the ElixirLS output shows the environment:

#     Started ElixirLS
#     Elixir version: "1.7.4 (compiled with Erlang/OTP 21)"
#     Erlang version: "22"
#
# Note it shows OTP 21 yet the Erlang version is 22? They should be the same
