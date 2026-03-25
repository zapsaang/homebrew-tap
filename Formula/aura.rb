class Aura < Formula
  desc "Nanosecond-level system telemetry probe"
  homepage "https://github.com/zapsaang/aura"
  version "0.0.1"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.1/aura-v0.0.1-x86_64-apple-darwin.tar.xz"
      sha256 "0477964cd008a5eeb766426f3a5277ee8c021dc62618d49f07b5ae5ab0d1a869"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.1/aura-v0.0.1-aarch64-apple-darwin.tar.xz"
      sha256 "796e02c75ebed1130eccc30744ed8899e70d827c1a9ef78a55d87adf52f6c6f0"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.1/aura-v0.0.1-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0bed046fae39ca47abe1fde935f183a94b150028a8981f9e0ec1861863a46569"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/zapsaang/aura/releases/download/v0.0.1/aura-v0.0.1-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e311a4b2344fd32c74df96db0bd1537893d8da1f915b3133afe94b5375076d2"
      def install
        bin.install "aura-daemon", "aura-cli"
      end
    end
  end

  def caveats
    <<~EOS
      Start daemon: aura-daemon &
      Query telemetry: aura-cli -m cpu
    EOS
  end

  test do
    assert_match "aura", shell_output("#{bin}/aura-cli --version")
  end
end
