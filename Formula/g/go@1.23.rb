class GoAT124 < Formula
    desc "Open source programming language to build simple/reliable/efficient software"
    homepage "https://go.dev/"
    url "https://go.dev/dl/go1.23.12.darwin-amd64.tar.gz"
    sha256 "0f6efdc3ffc6f03b230016acca0aef43c229de022d0ff401e7aa4ad4862eca8e"
    version "1.23.12"
    license "BSD-3-Clause"
  
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
  