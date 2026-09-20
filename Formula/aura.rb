class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/zapsaang/aura.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.0/aura-aarch64-apple-darwin.tar.gz"
      sha256 "e0ea86c3b2429f7206365e35ce4926ba1b4b68810b1c0f7d05b772e08faf8215"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.0/aura-x86_64-apple-darwin.tar.gz"
      sha256 "55b8c76609cd6e4fb86abaf17f317591b729d9864d4ec4d0889ab7c778f9d49f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.0/aura-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e348d75e19a5e2303e1bfd3fa3cb8778cbb0c500b720792272f0a612542dbd00"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.0/aura-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ce83ece8afd77ac17f3f763e85ab189960bfc6efe2dc10fbfc1e65baf3ab3167"
    end
  end

  def install
    bin.install "aura-daemon", "aura-cli"
  end

  service do
    run [opt_bin/"aura-daemon", "--heartbeat-ms", "500"]
    keep_alive true
    log_path var/"log/aura/aura-daemon.log"
    error_log_path var/"log/aura/aura-daemon.log"
  end

  test do
    assert_equal "[AURA: OFFLINE]\n", shell_output("#{bin}/aura-cli -m cpu", 1)
  end
end
