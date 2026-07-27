class Quorum < Formula
  desc "Panel of Codex reviewers for your PRs: review, fix, wait for CI, repeat"
  homepage "https://github.com/yungweng/quorum"
  url "https://github.com/yungweng/quorum/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "c8043103e535c78b291f7926364f9d55101a25a84d702a25d83ad122787c7784"
  license "MIT"

  depends_on "go" => :build
  depends_on "gh"
  # direnv is not required: it is only needed for projects that have an .envrc,
  # and --no-direnv skips it entirely. Installing it anyway is the friendlier
  # default, since a missing direnv otherwise only shows up mid-run.
  depends_on "direnv"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
  end

  def caveats
    <<~EOS
      quorum needs the Codex CLI. Homebrew ships it as a cask, and formulas
      cannot depend on casks:
        brew install --cask codex
      Alternatively: npm install -g @openai/codex

      Then authenticate GitHub and try a review that posts nothing:
        gh auth login
        cd your-repo && quorum review <pr> --dry-run

      quorum replaces pr-codex-review, babysit and prbot. An existing prbot
      config, state and launchd agent are picked up automatically, and
      `quorum install` unloads the old agent so the two cannot race.
    EOS
  end

  test do
    assert_match "quorum review", shell_output("#{bin}/quorum --help")
    assert_match version.to_s, shell_output("#{bin}/quorum --version")
    # The subcommand help is built from the resolved config, so this also
    # catches a format string that no longer matches its arguments.
    assert_match "reviewer passes", shell_output("#{bin}/quorum review --help")
    assert_match "review-fix cycle", shell_output("#{bin}/quorum babysit --help")
  end
end
