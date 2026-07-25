class Prbot < Formula
  desc "Run pr-codex-review automatically on GitHub PRs that request your review"
  homepage "https://github.com/yungweng/prbot"
  url "https://github.com/yungweng/prbot/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "95b522d2dafc708a11493195b1314102c6ccd9f5efeb9b9a9378469c609e0e0e"
  license "MIT"

  depends_on "gh"
  depends_on "jq"
  depends_on "yungweng/tap/pr-codex-review"

  def install
    bin.install "bin/prbot"
  end

  def caveats
    <<~EOS
      prbot drives pr-codex-review, which needs the Codex CLI. Homebrew ships it
      as a cask, and formulas cannot depend on casks:
        brew install --cask codex
      Alternatively: npm install -g @openai/codex

      Then authenticate GitHub and start the agent:
        gh auth login
        prbot install

      Reviews are posted to your PRs automatically. To review without posting,
      set REVIEW_ARGS="--dry-run" in ~/.config/prbot/config.
    EOS
  end

  test do
    assert_match "prbot install", shell_output("#{bin}/prbot --help")
  end
end
