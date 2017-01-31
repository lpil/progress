defmodule Progress.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  #
  defp deps do
    [{:mix_test_watch, "~> 0.2.0", only: [:dev]}]
  end
end
