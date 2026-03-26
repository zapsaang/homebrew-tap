class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.10"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.10/aura-v0.0.10-x86_64-apple-darwin.tar.xz"
      sha256 "a6495080647c8abf9d8ed2fe2f7f2d0d64e9479538c6185afb3e2cad8c646006"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.10/aura-v0.0.10-aarch64-apple-darwin.tar.xz"
      sha256 "611923c8bef4acfc9f969b845da5bcd892da3820354a90edec6668aa7dd8e6b1"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.10/aura-v0.0.10-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dcd058e35f4d8025535f95e277b8e498d5a6057461a045753286ac1a3c6c54fd"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.10/aura-v0.0.10-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c21ac3232b43eb8594ff5e36e63b4542bca5bf645a9f3b4826ff76f9b114e545"
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
