class Aspero < Formula
  desc "Find, resolve and verify scholarly literature from the command line"
  homepage "https://github.com/transilluminate/aspero"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.2/aspero-aarch64-apple-darwin.tar.xz"
      sha256 "aa959a0236899e30efb839682aec411d1d993c2c495bad11362aaa2a10627fc8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.2/aspero-x86_64-apple-darwin.tar.xz"
      sha256 "4611915160a9f001a3727e3016c098c70e586eb21f60bccebba5347a1a4ecffc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.2/aspero-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bea70f623e95555a8a809852ebd66c7fb2804ebfe45d22f3656d58e282e962ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.5.2/aspero-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8b7351db4b579369b57ffd1ece0f3274a9de332e046e7bb7476733ae24eae28e"
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
