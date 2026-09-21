class Wt < Formula
  desc "Create isolated, ready-to-code Git worktrees"
  homepage "https://github.com/yungweng/wt"
  url "https://github.com/yungweng/wt/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "e439250b5dd922ddef2c069b479b0fe5732c0c9d44ff0945d11770fb0343e23c"
  license "MIT"

  depends_on "rust" => :build
  depends_on "gh"

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"wt", shell_parameter_format: :clap)
  end

  def caveats
    <<~EOS
      To change into new worktrees after `wt add`, add one line to your shell:
        fish  ~/.config/fish/config.fish:  wt shell fish | source
        zsh   ~/.zshrc:                    eval "$(wt shell zsh)"
        bash  ~/.bashrc:                   eval "$(wt shell bash)"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wt --version")
    assert_match "Create a worktree", shell_output("#{bin}/wt --help")
    assert_match "function wt", shell_output("#{bin}/wt shell fish")
  end
end
