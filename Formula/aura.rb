class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.9"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.9/aura-v0.0.9-x86_64-apple-darwin.tar.xz"
      sha256 "f8b248881dd6096c40fc705900cfe508b807dc74dc9c7eea07a833340ea1685a"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.9/aura-v0.0.9-aarch64-apple-darwin.tar.xz"
      sha256 "48d26ac55df2e2fc6f2c3f81e89addf7084222a4c97eb1f878f8360a9f0a9721"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.9/aura-v0.0.9-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dff219c494d876f325d6ef7f637e6f0d960374dab173a06d09793e38230b13f8"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.9/aura-v0.0.9-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "57a155ec7ff878b9b62255be54e0a38008901626b6321e883060f44717b4daa0"
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
