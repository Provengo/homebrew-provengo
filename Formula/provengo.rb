class Provengo < Formula
  desc "Scenario-based modeling and testing tool"
  homepage "https://www.provengo.tech/"
  url "https://downloads.provengo.tech/releases/Provengo-2025-03-30.uber.jar"
  sha256 "c63c50ed4b8d7e12a7dda289e3503d8bdd92cd9b1b7dd0dfa6c5c62df8a9a0a8"

  def check_java_version
    java_version = `java -version 2>&1 | awk -F '"' '/version/ {print $2}'`.chomp
    java_major = java_version.split(".").then { |parts| ((parts[0] == "1") ? parts[1].to_i : parts[0].to_i) }

    if java_major < 11
      odie "Error: Java 11 or higher is required. Detected version: #{java_version}"
    else
      ohai "Java version #{java_version} detected — OK"
    end
  end

  def install
    check_java_version

    libexec.install "Provengo-2025-03-30.uber.jar"
    (bin/"provengo").write <<~EOS
      #!/bin/bash
      exec java -jar "#{libexec}/Provengo-2025-03-30.uber.jar" "$@"
    EOS
  end

  test do
    system bin/"provengo", "--version"
  end
end
