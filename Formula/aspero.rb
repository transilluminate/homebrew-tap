class Aspero < Formula
  desc "Find, resolve and verify scholarly literature from the command line"
  homepage "https://github.com/transilluminate/aspero"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.16.0/aspero-aarch64-apple-darwin.tar.xz"
      sha256 "459ced2e5d6ef5b06f2eb4323a379cd2c9689650d447b3395ea9ce3a286f0fdf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.16.0/aspero-x86_64-apple-darwin.tar.xz"
      sha256 "02d076f33b47006f130e9776d5112b2428946eaf3c41ebf72b9ee96a7b2b77d8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.16.0/aspero-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "458c33584d965d9db6301cc08e5f922121cf79fe859cd39938ed8d4711e388e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.16.0/aspero-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb227c3f1e331e88b3e611a7b94185fae61e23b1c8a44b293ef21bbfeedb3290"
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
