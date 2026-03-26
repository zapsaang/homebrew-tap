class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.7"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.7/aura-v0.0.7-x86_64-apple-darwin.tar.xz"
      sha256 "1a7c8c0e6b56a87dcf99af87e8c6800d51f6e94c48bd97013d8e18675c336104"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.7/aura-v0.0.7-aarch64-apple-darwin.tar.xz"
      sha256 "084a6d8c9c1d5603ad54e5c27832928f3571f81439d2cd452cb073faf8697547"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.7/aura-v0.0.7-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f2eb77260457024810c8217fe9b7dbce722291ecb50f0282da4b72b332b4dca4"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.7/aura-v0.0.7-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1f004f8b03b245189ca2db841710f39faa83c1938a90918d9d806527996b267f"
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
