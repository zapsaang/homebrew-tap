class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.4"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.4/aura-v0.0.4-x86_64-apple-darwin.tar.xz"
      sha256 "f0908879e1a3964af91b22e8a775b96247104ed332abb8cc46ce3469d52d8d5a"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.4/aura-v0.0.4-aarch64-apple-darwin.tar.xz"
      sha256 "59c4d4afe7dbf134a040b91674eeda61174a2913a97152856d9e7085afdce133"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.4/aura-v0.0.4-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "420b04d1aeead1ae88ab39794224674cf3127f370c4fbd6f50916450d5433ea5"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.4/aura-v0.0.4-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d08b82604d187d2d433517b248f5ace13bea49a0f302ddd68f0259052f928ca8"
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
