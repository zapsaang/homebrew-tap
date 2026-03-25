class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.2"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.2/aura-v0.0.2-x86_64-apple-darwin.tar.xz"
      sha256 "43843a53fcd0ecd3ad88ef70423b9175a1d52459325b0154e6970ee444c1a10c"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.2/aura-v0.0.2-aarch64-apple-darwin.tar.xz"
      sha256 "127adb3766a3b5abc844c7de3dd6b2fa45097095b054cc13e7bc942ff70c031b"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.2/aura-v0.0.2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ee70ee27ff608d85ef2f391ecab1bd898d810118ce2c6c0457c32facfc84b360"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.2/aura-v0.0.2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef1c224998c7660f9277f1538d2c7ea719ee3ba422e0d937a132776546b99d86"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  service do
    run opt_bin/"aura-daemon"
    working_dir HOMEBREW_PREFIX
    keep_alive
    error_log_path var/"log/aura/error.log"
  end

  def caveats
    <<~EOS
      AURA telemetry daemon is now registered as a service.

      To start the service:
        brew services start aura

      To check service status:
        brew services info aura

      To stop the service:
        brew services stop aura

      Or run manually:
        aura-daemon &
        aura-cli -m cpu
    EOS
  end

  test do
    assert_match "aura", shell_output("#{bin}/aura-cli --version")
  end
end
