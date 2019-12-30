class HiptestPublisher < Formula
  desc "Publisher for HipTest projects"
  homepage "https://github.com/hiptest/hiptest-publisher"
  url "https://github.com/hiptest/hiptest-publisher/archive/v2.0.0.tar.gz"
  sha256 "ec2e89637655935616e7f427778c4dbe205891ea0f58e9b30c7130532a48dcfe"
  head "https://github.com/hiptest/hiptest-publisher.git"

  depends_on "ruby"

  resource "colorize" do
    url "https://rubygems.org/downloads/colorize-0.8.1.gem"
    sha256 "0ba0c2a58232f9b706dc30621ea6aa6468eeea120eb6f1ccc400105b90c4798c"
  end

  resource "parseconfig" do
    url "https://rubygems.org/downloads/parseconfig-1.0.8.gem"
    sha256 "b86e117fcb635eb850b6dbae2454fc7a5a7b3767482951a07a9eb06f667a222f"
  end

  resource "i18n" do
    url "https://rubygems.org/downloads/i18n-0.7.0.gem"
    sha256 "a81cd327bd0f2c490ecf9f62f4a91ffaf5061aa2bf22cdbafe1a7e44a70fbfc4"
  end

  resource "nokogiri" do
    url "https://rubygems.org/downloads/nokogiri-1.10.7.gem"
    sha256 "96ce81f44eb9b47494d09b6e74f5eae00bbdf01b267b73c224e64080dcbb1864"
  end

  resource "multipart-post" do
    url "https://rubygems.org/downloads/multipart-post-2.1.1.gem"
    sha256 "d2dd7aa957650e0d99e0513cd388401b069f09528441b87d884609c8e94ffcfd"
  end

  resource "ruby_version" do
    url "https://rubygems.org/downloads/ruby_version-1.0.1.gem"
    sha256 "f235625aa8c24849f579cebbc346a13620b6412db4806c9539c1142f5788a420"
  end

  resource "ruby-handlebars" do
    url "https://rubygems.org/downloads/ruby-handlebars-0.4.0.gem"
    sha256 "00966241fbb9b6bd76c08cc43b6e9dbb16c5d58eff3c1c52e3947dce7022c300"
  end

  resource "pry" do
    url "https://rubygems.org/downloads/pry-0.12.0.gem"
    sha256 "be0c56587dcde86387c5cd69173a49f5f939d9e812b64517bafadc6a13082790"
  end

  resource "pry-byebug" do
    url "https://rubygems.org/downloads/pry-byebug-3.7.0.gem"
    sha256 "f1839e259cdfa33db03fa7bacda768f2b21717ce4eb37db73693908ffe231fab"
  end

  resource "rspec" do
    url "https://rubygems.org/downloads/rspec-3.9.0.gem"
    sha256 "90a037a7cc02365d7c112201881839aafbc875a88094423bc8cba778c98bfac3"
  end

  resource "rspec-mocks" do
    url "https://rubygems.org/downloads/rspec-mocks-3.9.0.gem"
    sha256 "4e76c19071bfeb1125b732472eb7bd6913a24bbca3da35e8169368d8b3452e61"
  end

  resource "codeclimate-test-reporter" do
    url "https://rubygems.org/downloads/codeclimate-test-reporter-1.0.9.gem"
    sha256 "952124ee3f11b209ca7b4ae591701a5ce0c00d7d8c5d053207902637587201c3"
  end

  resource "i18n-tasks" do
    url "https://rubygems.org/downloads/i18n-tasks-0.9.29.gem"
    sha256 "4efd9675652c611b4756bd0d481f5a9773860945294ffad4edae5d0924640086"
  end

  resource "i18n-coverage" do
    url "https://rubygems.org/downloads/i18n-coverage-0.1.1.gem"
    sha256 "f5d0586cc0de507f3f3c70990c3653577f7d48c194bce79cc7a9b23ea3c31301"
  end

  def install
    ENV["GEM_HOME"] = libexec
    resources.each do |r|
      r.fetch
      system "gem", "install", r.cached_download, "--no-document", "--install-dir", libexec
    end

    system "gem", "build", "hiptest-publisher.gemspec"
    system "gem", "install", "--ignore-dependencies", "hiptest-publisher-#{version}.gem"
    bin.install libexec/"bin/hiptest-publisher"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    output = shell_output("#{bin}/hiptest-publisher --version")
    assert_match "hiptest-publisher #{version}", output
  end
end
