class Bandwhich < Formula
  desc "Terminal bandwidth utilization tool (formerly known as \"what\")"
  homepage "https://github.com/imsnif/bandwhich"
  url "https://github.com/imsnif/bandwhich/archive/0.6.0.tar.gz"
  sha256 "df13a4641bee77d1199baffaedd27f99fe3d8e36408e318b85b280cdb76ab62e"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    pipe_output("#{bin}/bandwhich", "q", 0)
  end
end
