class PrCodexReview < Formula
  desc "Run parallel Codex PR reviews and aggregate them into one GitHub comment"
  homepage "https://github.com/yungweng/pr-codex-review"
  url "https://github.com/yungweng/pr-codex-review/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "dc61ee1bf3b08742fe3ccff821c19e1c19aab29f2e04956ceee58558a9812fc0"

  depends_on "direnv"
  depends_on "gh"
  depends_on "jq"

  def install
    bin.install "bin/pr-codex-review"
  end

  def caveats
    <<~EOS
      pr-codex-review also needs the Codex CLI, which Homebrew ships as a cask:
        brew install --cask codex
      Alternatively: npm install -g @openai/codex
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/pr-codex-review --help")
  end
end
