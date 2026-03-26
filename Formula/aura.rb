class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.11"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.11/aura-v0.0.11-x86_64-apple-darwin.tar.xz"
      sha256 "3e629c5c064f8630979d5833a22d0839700b27b46e488316c47ea8de7d1e31cf"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.11/aura-v0.0.11-aarch64-apple-darwin.tar.xz"
      sha256 "f9338950e5fa86dfee4dea183da0eeb882930966187d7811ce22f85a9e607a0c"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.11/aura-v0.0.11-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "691171b4c580bd9e0334beb93d606f66b6385253af6e2cda333e60f75c3bc8e3"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.11/aura-v0.0.11-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "862837516ff8ce8b91eef9697fec9eec7cb3dbecbd6bfb3fa6acbacbfbffe075"
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
