class Provengo < Formula
  desc "Scenario-based modeling and testing tool"
  homepage "https://www.provengo.tech/"
  url "https://downloads.provengo.tech/binaries/jar/Provengo-2026-10-06.uber.jar"
  sha256 "ed4cbf2437d3350b253556caaf0a8a88e74d347b38008a7f8a243a007de694ab"

  depends_on "graphviz"

  def check_java_version
    java_version = `java -version 2>&1 | awk -F '"' '/version/ {print $2}'`.chomp
    java_major = java_version.split(".").then { |parts| ((parts[0] == "1") ? parts[1].to_i : parts[0].to_i) }

    if java_major < 25
      odie "Error: Java 25 or higher is required. Detected version: #{java_version}. You can install one using 'brew install openjdk'"
    else
      ohai "Java version #{java_version} detected — OK"
    end
  end

  def install
    check_java_version

    libexec.install "Provengo-2026-10-06.uber.jar"
    (bin/"provengo").write <<~EOS
      #!/bin/bash
      JAVA_VERSION=$(java --version | head -n1 | awk '{ print $2 }' | cut -d. -f1)
      exec java --enable-native-access=ALL-UNNAMED -jar "#{libexec}/Provengo-2026-10-06.uber.jar" "$@"
    EOS
  end

  test do
    system bin/"provengo", "--version"
  end
end
