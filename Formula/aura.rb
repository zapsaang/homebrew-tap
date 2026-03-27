class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.14"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.14/aura-v0.0.14-x86_64-apple-darwin.tar.xz"
      sha256 "5e1511be357aa5a8b69c43408ad5f146059f9f07e5669559d534b8995810b587"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.14/aura-v0.0.14-aarch64-apple-darwin.tar.xz"
      sha256 "2fdbb212ea118cd284c6e2a104e53079af44510e60a6c030525b80dca99587cb"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.14/aura-v0.0.14-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b78b58d2b230227ade95837608f7daa91a46fa55141a7ec484911cbc1ffccf5b"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.14/aura-v0.0.14-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a33a0ec1e8add46d064462ffca4e0dd1b2ae5ae87ab32391c1a2a2184a98e1b"
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
