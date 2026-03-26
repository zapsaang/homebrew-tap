class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.8"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.8/aura-v0.0.8-x86_64-apple-darwin.tar.xz"
      sha256 "758a6402e2343e79b593cf79007ceb2a94543a0b4f53344fa889ba64d3c1aa73"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.8/aura-v0.0.8-aarch64-apple-darwin.tar.xz"
      sha256 "c12a15ad32e25f1022a37e4957853a7635a9c44af5b3fe44d6121c419178ea8a"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.8/aura-v0.0.8-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf81a745fc0544121355695533b07000ffab9e80552f7c12cb359261ed306018"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.8/aura-v0.0.8-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "537c573da6c05f8a92435d0c8246cc4d145448bf79026343411ec94053f94d9e"
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
