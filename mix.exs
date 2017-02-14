defmodule Progress.Mixfile do
  use Mix.Project

  def project do
    [app: :progress, # TODO: Remove once mix_docker umbrella name bug is fixed
     version: "0.1.0", # Ditto
     apps_path: "apps",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  #
  defp deps do
    [# Automatic test runner
     {:mix_test_watch, "~> 0.2.0", runtime: false, only: [:dev]},
     # Docker image builder tool
     {:mix_docker, "~> 0.3.2", runtime: false}]
  end
end
