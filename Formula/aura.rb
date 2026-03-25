class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.5"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.5/aura-v0.0.5-x86_64-apple-darwin.tar.xz"
      sha256 "c6804839dfeebfb3823bbb6384ea0372fac908d787bd39a0239327910eb04215"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.5/aura-v0.0.5-aarch64-apple-darwin.tar.xz"
      sha256 "00e8bafbf0aad0b46fe950cc4ea5ae160458c66dcc290fb9dbfd509b1c271cfb"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.5/aura-v0.0.5-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e8fa3d16bdf6e2bbfb0e9efcdfcadf82c8b84ec5aa0ab0b4678a301d06a1b0c2"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.5/aura-v0.0.5-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "76edb7ca4376ff51f75c1fc1f5419c06aa232f4da81479b9ed1e93bce3214553"
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
