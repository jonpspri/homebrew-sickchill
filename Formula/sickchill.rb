class Sickchill < Formula
  include Language::Python::Virtualenv

  desc "Media library mega tool, packaged into a homebrew bottle with a service"
  homepage "https://sickchill.github.io"
  url "https://files.pythonhosted.org/packages/ba/75/d27b26bdac593423026a8d606551de134f745fb36ec991ff0a70d4dfb2a0/sickchill-2023.5.30.tar.gz"
  sha256 "be49f0d6c01f479cb0f066e88582c4971b683a11d50149ffe81b1bdc4447c2ab"

  depends_on "rust" => :build
  depends_on "python3"

  uses_from_macos "libxml2"
  uses_from_macos "libxslt"

  def install
    virtualenv_create(libexec, "python3")
    system "#{libexec}/bin/pip", "install", buildpath
    bin.install_symlink "#{libexec}/bin/sickchill"
  end

  service do
    run [opt_bin/"sickchill", "--datadir", etc/"sickchill", "--quiet", "--nolaunch"]
    keep_alive true
    working_dir var
  end

  test do
    system opt_bin/"sickchill", "--help"
  end
end
