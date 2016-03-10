defmodule Kairos.Project.Server do
  use GenServer
  import Kairos.Project.Calculations

  defstruct [
    id: nil,
    name: nil,
    description: nil,
    stories: [],
    total_story_points: 0,
    total_completed_points: 0,
    total_estimated_hours: 0,
    total_worked_hours: 0,
    deviation: 0
  ]

  @doc """
  Creates a new Project process if it doesn't exist. If it's been previously
  created it returns it.
  """
  def create(project) do
    case GenServer.whereis(ref(project.id)) do
      nil -> Supervisor.start_child(Kairos.Project.Supervisor, [project])
      server -> server
    end
  end

  def start_link(project) do
    GenServer.start_link(Kairos.Project.Server, project, name: ref(project.id))
  end

  def init(project) do
    stories = get_stories(project.pivotal_tracker_id)

    state = %__MODULE__{
      id: project.id,
      name: project.name,
      description: project.description,
      stories: stories,
      total_story_points: total_story_points(stories),
      total_completed_points: total_completed_points(stories),
      total_estimated_hours: total_estimated_hours(stories)
    }

    {:ok, state}
  end

  @doc """
  Returns the state of the process
  """
  def get_state(project_id) do
    try_call(project_id, :get_state)
  end

  defp try_call(project_id, call_function) do
    case GenServer.whereis(ref(project_id)) do
      nil -> {:error, :invalid_project}
      project -> GenServer.call(project, call_function)
    end
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  defp ref(project_id), do: {:global, {:project_id, project_id}}

  defp get_stories(pivotal_tracker_id), do: Kairos.Story.Fetcher.get_stories(pivotal_tracker_id)
end
