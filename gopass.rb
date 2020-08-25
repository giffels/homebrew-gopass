# This file was generated by GoReleaser. DO NOT EDIT.
class Gopass < Formula
  desc "The slightly more awesome Standard Unix Password Manager for Teams."
  homepage "https://www.gopass.pw/"
  version "1.10.1"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/gopasspw/gopass/releases/download/v1.10.1/gopass-1.10.1-darwin-amd64.tar.gz"
    sha256 "a83d643c4d42bbd39b740c05766e122cc545b005a9757a10d62cb241e4565da5"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gopasspw/gopass/releases/download/v1.10.1/gopass-1.10.1-linux-amd64.tar.gz"
      sha256 "aa79f7f9e0af2d2788c7811d5d272d0543b2062b9ddcb204c61e9453365a9a59"
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gopasspw/gopass/releases/download/v1.10.1/gopass-1.10.1-linux-arm64.tar.gz"
        sha256 "4c39191cf4a619c5981fd53a68099d0548ba01d2d5c872c2dae168bf2d34908c"
      else
        url "https://github.com/gopasspw/gopass/releases/download/v1.10.1/gopass-1.10.1-linux-armv6.tar.gz"
        sha256 "e1613fc35b0f3bb4400751b9a4c6d482ba09bb8071690e5ad2e3ce0e7227d67f"
      end
    end
  end
  
  depends_on "git"
  depends_on "gnupg"
  depends_on "terminal-notifier"

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/gopasspw/gopass").install buildpath.children
    
    cd "src/github.com/gopasspw/gopass" do
      ENV["PREFIX"] = prefix
      system "make", "install"
    end
    
    system bin/"gopass completion bash > bash_completion.bash"
    system bin/"gopass completion zsh > zsh_completion.zsh"
    bash_completion.install "bash_completion.bash"
    zsh_completion.install "zsh_completion.zsh"
  end

  def caveats; <<~EOS
    Gopass has been installed, have fun!
    If upgrading from `pass`, everything should work as expected.
    If installing from scratch, you need to either initialize a new repository now...
      gopass init
    ...or clone one from a source:
      gopass clone git@code.example.com:example/pass.git
    In order to use the great autocompletion features (they're helpful with gopass),
    please make sure you have autocompletion for homebrew enabled:
      https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
    More information:
      https://www.gopass.pw/
      https://github.com/gopasspw/gopass/README.md
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gopass version")
  end
end
