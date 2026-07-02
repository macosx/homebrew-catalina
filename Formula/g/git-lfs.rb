class GitLfs < Formula
    desc "Git extension for versioning large files"
    homepage "https://git-lfs.com/"
    url "https://github.com/git-lfs/git-lfs/releases/download/v3.7.0/git-lfs-darwin-amd64-v3.7.0.zip"
    sha256 "eab348c3985c55b013d5536965b7a102b2925acf09fbf11bf157e64a7e92b798"
    license "MIT"
    compatibility_version 1
    version "3.7.0"
  
    # Upstream creates releases that are sometimes not the latest stable version,
    # so we use the `github_latest` strategy to fetch the release tagged as "latest".
    livecheck do
      url :stable
      strategy :github_latest
    end
  
    bottle do
      sha256 cellar: :any_skip_relocation, arm64_tahoe:   "34ca9df7031061b8471d53076cb76a974768937a209c3fcaa3de6270ec6465ea"
      sha256 cellar: :any_skip_relocation, arm64_sequoia: "34ca9df7031061b8471d53076cb76a974768937a209c3fcaa3de6270ec6465ea"
      sha256 cellar: :any_skip_relocation, arm64_sonoma:  "34ca9df7031061b8471d53076cb76a974768937a209c3fcaa3de6270ec6465ea"
      sha256 cellar: :any_skip_relocation, sonoma:        "eab348c3985c55b013d5536965b7a102b2925acf09fbf11bf157e64a7e92b798"
      sha256 cellar: :any_skip_relocation, arm64_linux:   "88c24cb0c772cb6570e70f336ef4bb7b6539c5fb9ebeda563e9a5458ca82a98e"
      sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7ebba491af8a54e560be3a00666fa97e4cf2bbbb223178a0934b8ef74cf9bed"
    end
  
    def install
      ENV["GIT_LFS_SHA"] = ""
      ENV["VERSION"] = version
  
      bin.install "git-lfs"
      man1.install Dir["man/man1/*.1"]
      man5.install Dir["man/man5/*.5"]
      man7.install Dir["man/man7/*.7"]
      doc.install Dir["man/html/*.html"]
      generate_completions_from_executable(bin/"git-lfs", "completion")
    end
  
    def caveats
      <<~EOS
        Update your git config to finish installation:
  
          # Update global git config
          $ git lfs install
  
          # Update system git config
          $ git lfs install --system
      EOS
    end
  
    test do
      system "git", "init"
      system "git", "lfs", "track", "test"
      assert_match(/^test filter=lfs/, File.read(".gitattributes"))
    end
  end