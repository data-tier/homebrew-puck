class PuckAgent < Formula
  desc "Privacy-first network intelligence agent"
  homepage "https://puck.data-tier.com"
  version "1.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-arm64"
      sha256 "25a647cd1a4b2efad91697d1b9f083a8e05afdae7bb3ab7b0d8035fdf98dbd18"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-amd64"
      sha256 "079abd2fcac55fa7681b902781cb6c0660079ec917fc56854eb7e47e2b1ae4bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-arm64"
      sha256 "eeef2fc885185eb9f93e57b91f8256d7bec6e8872133d92c051d0fdc7e06c578"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-amd64"
      sha256 "3716537773d9f2fec6ff4dd90d6cee5f0ea87d6ff3c254beaccd8bdb38f6bea3"
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
