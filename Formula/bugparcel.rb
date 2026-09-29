class Bugparcel < Formula
  desc "Local-first failure parcels for coding agents"
  homepage "https://github.com/AayushGokhale2005/bugparcel-core"
  url "https://github.com/AayushGokhale2005/bugparcel-core/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5f39872ff7ae8e14221294f6c547bf496bd9ce843a0dc2a8bfd82c09322deaf3"
  license "Apache-2.0"
  head "https://github.com/AayushGokhale2005/bugparcel-core.git", branch: "setup/fastapi-sandbox"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "apps/cli")
    system "cargo", "install", *std_cargo_args(path: "apps/mcp-server")
  end

  def caveats
    <<~EOS
      MCP clients should run `bugparcel-mcp` from PATH. Example Cursor config:

        {
          "mcpServers": {
            "bugparcel": {
              "command": "bugparcel-mcp",
              "env": { "BUGPARCEL_HOME": "./.bugparcel" }
            }
          }
        }
    EOS
  end

  test do
    assert_match "capture", shell_output("#{bin}/bugparcel --help")
    assert_path_exists bin/"bugparcel-mcp"
  end
end
