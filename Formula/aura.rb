class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.15"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.15/aura-v0.0.15-x86_64-apple-darwin.tar.xz"
      sha256 "dffcd31591a0f22f67c28b9778ae0e17b98ee747a4dd64d3ead83990c02110ef"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.15/aura-v0.0.15-aarch64-apple-darwin.tar.xz"
      sha256 "3ad7663b16785de039cb62f5aa0016bd0166bedd43335d9a25a2939e15142434"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.15/aura-v0.0.15-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3793affa7b4a94b79c1b08ea49896a53e77bac563ad1c62ef1d842f16633bab7"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.15/aura-v0.0.15-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7035f58c27abcdf61397d5868afaff3c922cb402c3ad472bf00a7d98b711874d"
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
