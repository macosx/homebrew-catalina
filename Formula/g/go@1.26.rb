class GoAT126 < Formula
    desc "Open source programming language to build simple/reliable/efficient software"
    homepage "https://github.com/alovn/go/"
    url "https://github.com/alovn/go/releases/download/go1.26.4-macosx/go-1.26.4.darwin-amd64.tar.gz"
    sha256 "0a18ba8121319809146a8cce349bc1edf2073933d3d4264d4630237fda503ba8"
    version "1.26.4"
    license "BSD-3-Clause"
  
    keg_only :versioned_formula
    depends_on macos: :catalina
  
    def install
      libexec.install Dir["*"]
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
  