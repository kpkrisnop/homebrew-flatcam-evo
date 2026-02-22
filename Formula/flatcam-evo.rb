class FlatcamEvo < Formula
  include Language::Python::Virtualenv

  desc "2D Computer-Aided PCB Manufacturing (patched fork)"
  homepage "https://github.com/kpkrisnop/flatcam"
  url "https://github.com/kpkrisnop/flatcam/archive/refs/tags/v8.9.95.2.tar.gz"
  sha256 "a99c91d175f99fe86b88bd265457ea9e92dd4c962969da97c01817b0a8adc4e1"

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "gdal"
  depends_on "geos"
  depends_on "pyqt"
  depends_on "python-tk@3.11"
  depends_on "python@3.11"
  depends_on "qpdf"
  depends_on "spatialindex"

  def install
    virtualenv_create(libexec, "python3.11", without_pip: false)
    inreplace "flatcam.py", /\A/, "#!#{libexec}/bin/python3\n"
    system libexec/"bin/pip", "install",
           "--no-binary", "pillow",
           "-r", "requirements.txt"
    libexec.install Dir["*.py", "appCommon", "appEditors", "appGUI",
                        "appHandlers", "appObjects", "appParsers", "appPlugins",
                        "assets", "config", "descartes", "doc", "libs", "locale",
                        "locale_template", "preprocessors", "tclCommands", "Utils"]
    (libexec/"flatcam.py").chmod(0755)
    bin.install_symlink libexec/"flatcam.py" => "flatcam"
  end

  test do
    system "true"
  end
end
