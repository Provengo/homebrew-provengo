  class Provengo < Formula
    desc "Scenario-based modeling and testing tool"
    homepage "https://www.provengo.tech/"
    url "https://downloads.provengo.tech/releases/Provengo-2025-03-30.uber.jar"
    version "0.9.5"
    sha256 "c63c50ed4b8d7e12a7dda289e3503d8bdd92cd9b1b7dd0dfa6c5c62df8a9a0a8"

    depends_on "openjdk@17"
    depends_on "graphviz"

    def install
      libexec.install "Provengo-2025-03-30.uber.jar"
      (bin/"provengo").write <<~EOS
        #!/bin/bash
        exec "#{Formula["openjdk@17"].opt_bin}/java" -jar "#{libexec}/Provengo-2025-03-30.uber.jar" "$@"
      EOS
    end

    test do
      system "#{bin}/provengo", "--version"
    end
  end

