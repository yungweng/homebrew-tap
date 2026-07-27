class Babysit < Formula
  desc "Iterate an open PR through review, fixes, and CI until it is clean"
  homepage "https://github.com/yungweng/babysit"
  url "https://github.com/yungweng/babysit/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "cf7945bee470d22bf67dad49b7bd41326bf26c1dfdedd49617d536a9910d7ce6"

  deprecate! date: "2026-07-27", because: "babysit is now `quorum babysit`"

  depends_on "direnv"
  depends_on "gh"
  depends_on "jq"
  depends_on "yungweng/tap/pr-codex-review"

  def install
    bin.install "bin/babysit"
  end

  def caveats
    <<~EOS
      babysit also needs the Codex CLI, which Homebrew ships as a cask:
        brew install --cask codex
      Alternatively: npm install -g @openai/codex
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/babysit --help")
  end
end
