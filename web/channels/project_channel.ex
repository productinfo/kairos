defmodule Kairos.ProjectChannel do
  use Kairos.Web, :channel
  require Logger

  def join("project:" <> project_id, _params, socket) do
    current_user = socket.assigns.current_user

    client = ExTracker.Client.new %{access_token: current_user.settings.pivotal_tracker_api_token}
    project = ExTracker.Projects.find(project_id, client)
    stories = ExTracker.Stories.list(client, project_id)

    {:ok, %{project: project, stories: stories}, socket}
  end
end
