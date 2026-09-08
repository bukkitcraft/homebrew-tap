class Omn < Formula
  desc "Dependency-free terminal notes tool — plain JSON on disk"
  homepage "https://github.com/bukkitcraft/ohmynotes"
  url "https://github.com/bukkitcraft/ohmynotes/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "7155714656f5ae7b572d173d2b89aa28b9f3c03db219bdd0b117acd25b25611c"
  license "MIT"

  depends_on "python@3.12"

  def install
    libexec.install "omn", "src"
    libexec.install "bannerlong.txt", "bannershort.txt"

    # Wrapper runs the launcher with Homebrew's python3 and the source tree on
    # PYTHONPATH, so it works wherever the user's own python3 points.
    python = Formula["python@3.12"].opt_bin/"python3"
    (bin/"omn").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/src"
      exec "#{python}" "#{libexec}/omn" "$@"
    EOS
    (bin/"omn").chmod 0755
    bin.install_symlink bin/"omn" => "ohmynotes"
  end

  test do
    assert_match "omn", shell_output("#{bin}/omn --version")
  end
end