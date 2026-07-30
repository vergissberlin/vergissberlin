# typed: false
# frozen_string_literal: true

class Vergissberlin < Formula
  desc "This is a useless tool without any features! Trust me!"
  homepage "https://github.com/vergissberlin/vergissberlin-cli"
  url "https://github.com/vergissberlin/vergissberlin-cli/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "1875aa112154889ec836fd7c3bd3373eed9d2ac79d3e6acde050eabc23cb6c59"
  license "MIT"
  head "https://github.com/vergissberlin/vergissberlin-cli.git", branch: "main"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "vergissberlin.gemspec"
    system "gem", "install", "vergissberlin-#{version}.gem", "--no-document"

    bin.install libexec/"bin/vergissberlin"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV.fetch("GEM_HOME", nil))
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vergissberlin --version")
  end
end
