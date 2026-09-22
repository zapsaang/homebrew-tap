class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/zapsaang/aura.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.5/aura-aarch64-apple-darwin.tar.gz"
      sha256 "eb591a47a54a7ed55ac645c5f65cd7101ea2318f13f152d28dd323a12b6f91bf"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.5/aura-x86_64-apple-darwin.tar.gz"
      sha256 "0de06cce7abe1f8ff818f9ca463dcd72e065f8e526c0cfe2cf886550da30364a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.5/aura-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9f11d6cbb26b17892066b2830f9fb4461046898df486d0742a526c46fa1f6963"
    end
    on_intel do
      url "https://github.com/zapsaang/aura/releases/download/v1.0.5/aura-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "378ea6d8e26d4ea1b5ef6e5d6863434fb0652123eb411b19c49bc34dd61d36a4"
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
