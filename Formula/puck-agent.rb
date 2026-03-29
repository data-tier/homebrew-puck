class PuckAgent < Formula
  desc "Privacy-first network intelligence agent"
  homepage "https://puck.data-tier.com"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-arm64"
      sha256 "3af6a60ef1194e0cca4334fe300bbb0447bd87d299337de8ed6fce7b37b6ce17"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-darwin-amd64"
      sha256 "50e2cee61ebed0b0749e9ca1cab60a3d1944ff3484d2871b47ab1191ade89778"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-arm64"
      sha256 "11430857e6d579ade788bc94bd461f0ec86f78cf17662a2015959126e9fe5644"
    end
    on_intel do
      url "https://github.com/data-tier/homebrew-puck/releases/download/v#{version}/puck-agent-linux-amd64"
      sha256 "c7329ef089431b3fab402ecb2f30860ca56646190c398cd2f9565a8ea7653e72"
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
