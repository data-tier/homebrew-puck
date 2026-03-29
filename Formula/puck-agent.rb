class PuckAgent < Formula
  desc "Privacy-first network intelligence agent"
  homepage "https://puck.data-tier.com"
  version "1.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-arm64"
      sha256 "7e28c12c171713c76bff95df492996170b9e14a6ef0b3feba7504385693773cd"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-amd64"
      sha256 "d40133d6538ef3c8b7b016efe95ca69d11c14f4b5f6a1a21e19ecdeb4670821b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-arm64"
      sha256 "721b8d63808d7714ad8e27a51a87ced4ccd35bd72f1cfb2e6dcd1f87d02feb6d"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-amd64"
      sha256 "931c89791112d931290ff42103ac29d3dae95342d160754d6c8426c32e71cf2b"
    end
  end

  def install
    binary = Dir["puck-agent-*"].first || "puck-agent"
    chmod 0755, binary
    bin.install binary => "puck-agent"
  end

  service do
    run [opt_bin/"puck-agent"]
    keep_alive true
    log_path var/"log/puck-agent.log"
    error_log_path var/"log/puck-agent-error.log"
    working_dir var/"lib/puck"
  end

  def post_install
    (var/"lib/puck").mkpath
    (var/"log").mkpath
  end

  def caveats
    <<~EOS
      To get started:
        1. Run: puck-agent login
        2. Start the service: brew services start puck-agent

      The agent needs to run continuously to monitor your network.
      Use `brew services` to manage it as a background service.

      Data is stored in: #{var}/lib/puck
      Logs are written to: #{var}/log/puck-agent.log
    EOS
  end

  test do
    assert_match "puck-agent", shell_output("#{bin}/puck-agent version")
  end
end
