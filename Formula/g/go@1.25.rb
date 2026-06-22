class GoAT125 < Formula
    desc "Open source programming language to build simple/reliable/efficient software"
    homepage "https://github.com/alovn/go/"
    url "https://github.com/alovn/go/releases/download/go1.25.11-macosx/go-1.25.11.darwin-amd64.tar.gz"
    sha256 "cfa7a7fbedc15b2e532cb62b70d38eb15efda94091206e593de6203ca6610829"
    version "1.25.11"
    license "BSD-3-Clause"
  
    # keg_only :versioned_formula
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
  