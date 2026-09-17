class Wt < Formula
  desc "Create isolated, ready-to-code Git worktrees"
  homepage "https://github.com/yungweng/wt"
  url "https://github.com/yungweng/wt/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "eb1fb8a6cd848047ac53102df02833f67f84c48cff2edabe9cf25cf58407f46b"
  license "MIT"

  depends_on "rust" => :build
  depends_on "gh"

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"wt", shell_parameter_format: :clap)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wt --version")
    assert_match "Create a worktree", shell_output("#{bin}/wt --help")
  end
end
