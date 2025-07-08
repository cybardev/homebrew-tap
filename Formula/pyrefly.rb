class Pyrefly < Formula
  desc "Fast type checker and IDE for Python"
  homepage "https://pyrefly.org/"
  url "https://github.com/facebook/pyrefly/archive/refs/tags/0.23.0.tar.gz"
  sha256 "e5dd1fca929f5a78420b27dac129e6d87e04c9bdccc8775a709d3fa43225cd05"
  license "MIT"
  head "https://github.com/facebook/pyrefly.git", branch: "main"

  depends_on "rust" => :build

  def install
    # Allow unstable features in stable toolchain
    ENV["RUSTC_BOOTSTRAP"] = 1

    # Set JEMALLOC configuration for ARM builds
    ENV["JEMALLOC_SYS_WITH_LG_PAGE"] = "16" if Hardware::CPU.arm?

    system "cargo", "install", *std_cargo_args(path: "pyrefly")
  end

  test do
    # Test version output
    assert_match version.to_s, shell_output("#{bin}/pyrefly --version")
  end
end
