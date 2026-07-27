class Prbot < Formula
  desc "Run pr-codex-review automatically on GitHub PRs that request your review"
  homepage "https://github.com/yungweng/prbot"
  url "https://github.com/yungweng/prbot/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "d336a081a98cda5da45654f5ef85da94d2d132c0360ce8e083ee086f2d56ffa6"
  license "MIT"

  deprecate! date: "2026-07-27", because: "prbot is now `quorum`, which also replaces pr-codex-review and babysit"

  depends_on "go" => :build
  depends_on "gh"
  depends_on "yungweng/tap/pr-codex-review"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
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
        prbot setup

      Reviews are posted to your PRs automatically. To review without posting,
      choose "keep them local" in prbot setup.
    EOS
  end

  test do
    assert_match "prbot install", shell_output("#{bin}/prbot --help")
    assert_match version.to_s, shell_output("#{bin}/prbot --version")
  end
end
