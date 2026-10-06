class Provengo < Formula
  desc "Scenario-based modeling and testing tool"
  homepage "https://www.provengo.tech/"
  url "https://downloads.provengo.tech/binaries/jar/Provengo-2025-09-03.uber.jar"
  sha256 "e4e9ec6914d8ceb0e2fb91d2322472d8208d9c01b735412dbe4db3cacfd392cc"

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

    libexec.install "Provengo-2025-09-03.uber.jar"
    (bin/"provengo").write <<~EOS
      #!/bin/bash
      exec java --enable-native-access=ALL-UNNAMED -jar "#{libexec}/Provengo-2025-09-03.uber.jar" "$@"
    EOS
  end

  test do
    system bin/"provengo", "--version"
  end
end
