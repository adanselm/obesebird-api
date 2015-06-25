defmodule ObesebirdApi.Scheduler do
  use GenServer

  alias ObesebirdApi.Slot
  alias ObesebirdApi.Tasks
  require Logger

  # Server
  def init(args) do
    case Process.send(self, :check, []) do
      :ok -> {:ok, args}
      _   -> {:stop, :error}
    end
  end

  def handle_call(:stop, _from, state) do
    {:stop, :normal, :ok, state}
  end

  def handle_info(:check, state) do
    check()
    {:noreply, state}
  end

  defp check() do
    {date, time} = :calendar.universal_time()

    # erlang counts days from 1 (mon) to 7 (sun), we need 0 (sun) to 6 (sat)
    day_of_week = rem(:calendar.day_of_the_week(date), 7)

    get_tasks(day_of_week, time)
    |> process_tasks time
  end

  defp get_tasks(day_of_week, time) do
    # select * from tasks t where t.day = day_of_week and (t.hour > hour or (t.hour == hour and t.min >= min)) order by t.hour, t.min
    Tasks.get day_of_week, time
  end

  defp process_tasks([], time) do
    # Sleep til midnight
    remaining_secs = 86400 - :calendar.time_to_seconds(time)
    sleep remaining_secs
  end
  defp process_tasks([%Slot{category_id: cid, hour: thour, min: tmin} | rest], {hour, min, sec} = time) do
    if hour == thour and min == tmin do
      do_task cid
      process_tasks rest, time
    else
      # Sleep until it's this task's time
      remaining_secs = (thour * 60 * 60 + tmin * 60) - (hour * 60 * 60 + min * 60 + sec)
      sleep remaining_secs
    end
  end

  defp sleep(seconds) do
    Logger.info "Waking up in #{seconds} seconds."
    Process.send_after self, :check, seconds * 1000
  end

  defp do_task(category_id) do
    Tasks.execute category_id
  end

  # Client

  @doc """
  Starts the Scheduler
  """
  def start_link([name: name] = args) do
    GenServer.start_link(__MODULE__, args, name: name)
  end
  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @doc """
  Stops the Scheduler
  """
  def stop(server) do
    GenServer.call(server, :stop)
  end

end
