class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.6"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.6/aura-v0.0.6-x86_64-apple-darwin.tar.xz"
      sha256 "84f95a6477faf4a53c8c0d6c826e8af3370e74a322731b467060b73edbbf4d02"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.6/aura-v0.0.6-aarch64-apple-darwin.tar.xz"
      sha256 "99f4baadc48397bdb6e3460c12e2d515a4599408179cc6e71b416bd81de44119"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.6/aura-v0.0.6-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0ffd15300b4e7e754c6d316262fa2590149f2cec22a48f6d3b3f6728d3b88dcb"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.6/aura-v0.0.6-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1009d0ee0ca1f9fd217903a11a80e914bec7fc34d057a44903a70315f125685c"
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
