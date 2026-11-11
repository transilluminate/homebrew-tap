class Aspero < Formula
  desc "Find, resolve and verify scholarly literature from the command line"
  homepage "https://github.com/transilluminate/aspero"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.1/aspero-aarch64-apple-darwin.tar.xz"
      sha256 "8583a59d3f149d2f66e8b790ff3c5e4ddf872c8504c5118424edff06e00b7797"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.1/aspero-x86_64-apple-darwin.tar.xz"
      sha256 "66dcd105e327066bf102830677edd7fe3a3c4a9d0c2704d9f88e5def124fc655"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.1/aspero-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f5f0faec4adf4d3a12f6eb99307d871d1f7827bece7425a3f5813bcc0d40e9cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.1/aspero-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ea13134288ca39b74f52d5e677a6d605ccea660823bb0b23c50e47acee250d60"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "aspero"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "aspero"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "aspero"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "aspero"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
