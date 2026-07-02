class PrCodexReview < Formula
  desc "Run parallel Codex PR reviews and aggregate them into one GitHub comment"
  homepage "https://github.com/yungweng/pr-codex-review"
  url "https://github.com/yungweng/pr-codex-review/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "518f65dd5386ca494449259eb69480e983496fc23e6451194fddc3e4d7f2e87c"

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
