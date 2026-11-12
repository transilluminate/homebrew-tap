class Aspero < Formula
  desc "Find, resolve and verify scholarly literature from the command line"
  homepage "https://github.com/transilluminate/aspero"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.8.1/aspero-aarch64-apple-darwin.tar.xz"
      sha256 "02d0bc3bd89466666f35edc200114a3524d9c97700935c070d7e7574dacd39a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.8.1/aspero-x86_64-apple-darwin.tar.xz"
      sha256 "59bc6fcc03b553629c9d280c05db3b6df03e258932e1327c3501c4c0e9cdcb2a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.8.1/aspero-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cc9a9c50281d044f58fdc67db7af89b8f8301dd7bb9b8e55de443ee5f39ad9d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.8.1/aspero-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "746b59705c83b3399b5e1eff3b60b56a024f61fae964c25686ac8ba5d388a344"
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
