class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.13"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.13/aura-v0.0.13-x86_64-apple-darwin.tar.xz"
      sha256 "a478ab35159410e2ddeb4a08f8c20582ef341555137580c3bf6015798b120ffd"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.13/aura-v0.0.13-aarch64-apple-darwin.tar.xz"
      sha256 "0937fda6c8377daf178257d81b05338c3f0e216f0042cd2f307746ea40858340"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.13/aura-v0.0.13-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "acca80f1985c84d7192aa0a1bb7057c90c029fd9b8a01225124ce04aa840a5b4"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.13/aura-v0.0.13-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f509fb43c009f6f9f52435df7c9fe05b5e24b5a1191ba08cb132df65e0c7f3c9"
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
