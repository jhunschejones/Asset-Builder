defmodule AssetBuilder do
  def compile(file), do: compile(file, file_extension(file))

  def compile(file, "scss") do
    System.cmd("npm", ["run", "--silent", "compile-scss"],
      env: [{"FROM", file}, {"TO", "../../priv/static/css/#{file_name(file)}.min.css"}])

    IO.puts("\e[36mCompiled '#{String.replace(file, "../../", "")}' to 'priv/static/css/#{file_name(file)}.min.css'\e[0m")
  end

  def compile(file, "css") do
    System.cmd("npm", ["run", "--silent", "minify-css"],
      env: [{"FROM", file}, {"TO", "../../priv/static/css/#{file_name(file)}.min.css"}])

    IO.puts("\e[36mCompiled '#{String.replace(file, "../../", "")}' to 'priv/static/css/#{file_name(file)}.min.css'\e[0m")
  end

  def compile(file, "js") do
    System.cmd("npm", ["run", "--silent", "minify-js"],
      env: [{"FROM", file}, {"TO", "../../priv/static/js/#{file_name(file)}.min.js"}])

    IO.puts("\e[36mCompiled '#{String.replace(file, "../../", "")}' to 'priv/static/js/#{file_name(file)}.min.js'\e[0m")
  end

  def compile(file, _) do
    IO.puts("\e[33m'#{file}' is an incompatible file format for asset builder\e[0m")
  end

  def compilable_file?(file) do
    Enum.member?(["js", "css", "scss", "cs"], file_extension(file))
      && !Enum.member?(["site", "phoenix_html"], file_name(file))
  end

  defp file_name(file) do
    file
    |> String.split("/")
    |> List.last()
    |> String.split(".")
    |> List.first()
  end

  defp file_extension(file) do
    file
    |> String.split(".")
    |> List.last()
  end
end
