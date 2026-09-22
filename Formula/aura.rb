class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/zapsaang/aura.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.4/aura-aarch64-apple-darwin.tar.gz"
      sha256 "ccf5365de0301bc1064f305b881aa183aa15fd9771350ff3b67dd6101748dbfb"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.4/aura-x86_64-apple-darwin.tar.gz"
      sha256 "fedf6cdb3270e8ce8597bb304c708dc17617419b4ec661832d8a2e998f76277f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.4/aura-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6592498081482ab98bd56d7531b2d0d280a838c955d8fd7a4ed9f5ae09974649"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.4/aura-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f412eb57f08648de09cc9434b2613cb88fbf51dac790a00ff045649eec54b3c5"
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
