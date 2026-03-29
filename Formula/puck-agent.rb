class PuckAgent < Formula
  desc "Privacy-first network intelligence agent"
  homepage "https://puck.data-tier.com"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-arm64"
      sha256 "b78f0f59af385daf0d7a3da92cc2becb566f390cf15962c652886294fd1b4059"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-amd64"
      sha256 "c4e72570b519bf86f598015eb75d3982105a550fee86b372d6e97f2cc2e6395a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-arm64"
      sha256 "1fb25bd25316ce3fc7714fdb156e7c8fb24bee6527073949f700114965aefcc7"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-amd64"
      sha256 "2ba81d0eda110efc635cacfafbfdbaffadf56fa25db80ba63c50d4da5bebe1c8"
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
