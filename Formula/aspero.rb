class Aspero < Formula
  desc "Find, resolve and verify scholarly literature from the command line"
  homepage "https://github.com/transilluminate/aspero"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.7.0/aspero-aarch64-apple-darwin.tar.xz"
      sha256 "a2362eb6bb08cb94cc3dcdb7a49deef38b16aa681f7b0a1a36ba4170b05c0554"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.7.0/aspero-x86_64-apple-darwin.tar.xz"
      sha256 "bfcbd0ca3af72d10ed42635431d30a7a9422e1e745f7358a1ecefe9d05911042"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/transilluminate/aspero/releases/download/v0.7.0/aspero-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fce6a2a6f7fe422600e1c431127fb48c97e291f45dc50f81bd45b7152f096235"
    end
    if Hardware::CPU.intel?
      url "https://github.com/transilluminate/aspero/releases/download/v0.7.0/aspero-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7c248abc2c01f38fd585d6c72604b7d07427fd66a3f90e61ecca1cb5b7f5f3df"
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
