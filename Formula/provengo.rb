class Provengo < Formula
  desc "Scenario-based modeling and testing tool"
  homepage "https://www.provengo.tech/"
  url "https://downloads.provengo.tech/releases/Provengo-2025-07-04.uber.jar"
  sha256 "dcb0ead49f8755346e322acce0424bb4c4ac33ab5ac9ee0eb8c363537f27cbbc"

  depends_on "graphviz"

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

    libexec.install "Provengo-2025-07-04.uber.jar"
    (bin/"provengo").write <<~EOS
      #!/bin/bash
      JAVA_VERSION=$(java --version | head -n1 | awk '{ print $2 }' | cut -d. -f1)
      if (( $JAVA_VERSION > 23 )); then
          SWITCH=--enable-native-access=ALL-UNNAMED
      fi
      exec java $SWITCH -jar "#{libexec}/Provengo-2025-07-04.uber.jar" "$@"
    EOS
  end

  test do
    system bin/"provengo", "--version"
  end
end
