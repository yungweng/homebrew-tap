class Wt < Formula
  desc "Create isolated, ready-to-code Git worktrees"
  homepage "https://github.com/yungweng/wt"
  url "https://github.com/yungweng/wt/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "9a04e7f6615e4721d3b591334cdbe34289008308a93df0b81332f2120246294f"
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
