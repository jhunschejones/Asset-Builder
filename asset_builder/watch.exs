Code.require_file("./asset_builder.exs")

if length(System.argv()) > 0 do
  [file | action] = System.argv()

  case action do
    ["unlink"] ->
      IO.puts("\e[33m'#{file}' was deleted. Make sure to clean up the /priv/static/ directory!\e[0m")
    _ ->
      if AssetBuilder.compilable_file?(file), do: AssetBuilder.compile(file)
  end
end
