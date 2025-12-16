class GoAT124 < Formula
    desc "Open source programming language to build simple/reliable/efficient software"
    homepage "https://go.dev/"
    url "https://go.dev/dl/go1.24.11.darwin-amd64.tar.gz"
    sha256 "c45566cf265e2083cd0324e88648a9c28d0edede7b5fd12f8dc6932155a344c5"
    version "1.24.11"
    license "BSD-3-Clause"
  
    livecheck do
      url "https://go.dev/dl/?mode=json"
      regex(/^go[._-]?v?(1\.24(?:\.\d+)*)[._-]src\.t.+$/i)
      strategy :json do |json, regex|
        json.map do |release|
          next if release["stable"] != true
          next if release["files"].none? { |file| file["filename"].match?(regex) }
  
          release["version"][/(\d+(?:\.\d+)+)/, 1]
        end
      end
    end
  
    bottle do
      sha256 cellar: :any_skip_relocation, arm64_tahoe:   "015118cf40fea9fda481f8a3fb2b0a9993e4c9ab5384bd28164730f7dbb04a51"
      sha256 cellar: :any_skip_relocation, arm64_sequoia: "015118cf40fea9fda481f8a3fb2b0a9993e4c9ab5384bd28164730f7dbb04a51"
      sha256 cellar: :any_skip_relocation, arm64_sonoma:  "015118cf40fea9fda481f8a3fb2b0a9993e4c9ab5384bd28164730f7dbb04a51"
      sha256 cellar: :any_skip_relocation, sonoma:        "ec19a7aee9048e68358bc52c4998cfc6e28e50b8d27780ff3f0d10cfedfc49d0"
      sha256 cellar: :any_skip_relocation, arm64_linux:   "8112bee8dece9b9a1040212126579e5b1fd48276188bc262e69b4aa2379a0b21"
      sha256 cellar: :any_skip_relocation, x86_64_linux:  "f61b24360bf1e42a8f5ab284309b81777cdc560426f8e41e5c944ef4e7b11916"
    end
  
    keg_only :versioned_formula
    depends_on macos: :catalina
  
    def install
      # 直接解压二进制包到 libexec（无需编译）
      libexec.install Dir["*"]
      # 创建软链接到 brew 的 bin 目录（全局可调用）
      bin.install_symlink Dir[libexec/"bin/go*"]
    end
  
    test do
      (testpath/"hello.go").write <<~GO
        package main
  
        import "fmt"
  
        func main() {
            fmt.Println("Hello World")
        }
      GO

      system bin/"go", "fmt", "hello.go"
      assert_equal "Hello World\n", shell_output("#{bin}/go run hello.go")
    end
  end
  