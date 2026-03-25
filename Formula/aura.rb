class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.3"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.3/aura-v0.0.3-x86_64-apple-darwin.tar.xz"
      sha256 "8567f5645a0729802a5e8aca64135c61abf2ff9b2bb113b73fe705c86a103192"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.3/aura-v0.0.3-aarch64-apple-darwin.tar.xz"
      sha256 "81b73315e3d1ced41d51db6446ca92c7028beee3aed2893e0d2953e25a453444"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.3/aura-v0.0.3-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0c8c9cfa85c9ca5bab4b6d69f47314163d246561bc24407a48a16ed9a183a3f"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.3/aura-v0.0.3-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2dc47cfe10f64711d740ba4b2eae58d418fdec78b9f0334e64e0c7bf749d8648"
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
