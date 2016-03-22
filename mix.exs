defmodule Kairos.Mixfile do
  use Mix.Project

  def project do
    [app: :kairos,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Kairos, []},
     applications: [
       :phoenix,
       :phoenix_html,
       :cowboy,
       :logger,
       :guardian,
       :gettext,
       :phoenix_ecto,
       :postgrex,
       :comeonin,
       :extracker,
       :togglex,
       :timex,
       :slacker,
       :hound
     ]
   ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.1.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_ecto, "~> 2.0"},
      {:phoenix_html, "~> 2.4"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 2.0"},
      {:guardian, "~> 0.10.0"},
      {:credo, "~> 0.2", only: [:dev, :test]},
      {:poison, "~> 2.0", override: true},
      {:extracker, github: "dashofcode/extracker"},
      {:hound, "~> 0.8"},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:togglex, "~> 0.1.0"},
      {:timex, "~> 2.1.1"},
      {:slacker,  "~> 0.0.2"},
      {:websocket_client, github: "jeremyong/websocket_client"},
      {:exrm, "~> 1.0.2"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
