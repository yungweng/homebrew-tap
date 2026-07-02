class PrCodexReview < Formula
  desc "Run parallel Codex PR reviews and aggregate them into one GitHub comment"
  homepage "https://github.com/yungweng/pr-codex-review"
  url "https://github.com/yungweng/pr-codex-review/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "7798e1fb6b70f3da624e6531c5ab09d81e27d1889f9f3b34e5f2602cb34f59d1"

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
