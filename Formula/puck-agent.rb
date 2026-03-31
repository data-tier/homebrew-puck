class PuckAgent < Formula
  desc "Privacy-first network intelligence agent"
  homepage "https://puck.data-tier.com"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-arm64"
      sha256 "4780d00bd3b9e5fc3401ff1b6940115899b8a9ec3c7cd97c2a7db67a24823d61"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-amd64"
      sha256 "82b8f480936678613db6cd50dfa5e8c47962b7e1225f7f1016614c4ab77e2836"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-arm64"
      sha256 "58a717e92bed708676f4f97a60b7bbc74b24eb935993a6c0d70555059a1df68e"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-amd64"
      sha256 "0ebbd273188d8e59aab8b574d8041788ca82a4db2510746b44dd8a98db6f81d2"
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
