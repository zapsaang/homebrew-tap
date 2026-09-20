class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/zapsaang/aura.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.1/aura-aarch64-apple-darwin.tar.gz"
      sha256 "df21785c2175542e80acde388ef82179cb4c0e286ce5b705110c52dd71345176"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.1/aura-x86_64-apple-darwin.tar.gz"
      sha256 "759ff3f86468280d1e9575d1a80c331a34e8bdd005304d75efe0772fcf3d2a24"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.1/aura-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "409bc54e61f08defeb37a8c90822408b2951892cbbffb9ab78e63b3d360e5e7b"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.1/aura-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25f878c5c36f826728833e15fcf3d0507acfd18d4a84ded6bb758d8d0624395e"
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
