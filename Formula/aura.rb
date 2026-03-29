class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.16"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.16/aura-v0.0.16-x86_64-apple-darwin.tar.xz"
      sha256 "210f62c90e96407723b5a50e608b7c9b2fc7d12c89b44e97d04ae635bd569439"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.16/aura-v0.0.16-aarch64-apple-darwin.tar.xz"
      sha256 "40e965c946db3ff828e20378ae58e1d6c5b23426b9dc4328b3cd7ef8604f081c"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.16/aura-v0.0.16-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c75b0066819e09eddf213c8e3aeaab5881adf91d9658dc21ccbc121e4e3f92a6"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.16/aura-v0.0.16-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "056cf743742d95e0d3c545ce374d75453b9cea4eb93bc3af225850798547516d"
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
