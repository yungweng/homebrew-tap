class PrCodexReview < Formula
  desc "Run parallel Codex PR reviews and aggregate them into one GitHub comment"
  homepage "https://github.com/yungweng/pr-codex-review"
  url "https://github.com/yungweng/pr-codex-review/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "cc4b82c8f3579b775c1dc544dbbe96ba984bbd6b66cdc30a8cd55efa0e06cd73"

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
