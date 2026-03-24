class PuckAgent < Formula
  desc "Privacy-first network intelligence agent"
  homepage "https://getpuck.com"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/puck-network/puck-agent/releases/download/v#{version}/puck-agent-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER_SHA256"
    end
    on_intel do
      url "https://github.com/puck-network/puck-agent/releases/download/v#{version}/puck-agent-darwin-amd64.tar.gz"
      sha256 "PLACEHOLDER_SHA256"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/puck-network/puck-agent/releases/download/v#{version}/puck-agent-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER_SHA256"
    end
    on_intel do
      url "https://github.com/puck-network/puck-agent/releases/download/v#{version}/puck-agent-linux-amd64.tar.gz"
      sha256 "PLACEHOLDER_SHA256"
    end
  end

  def install
    bin.install "puck-agent"
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
