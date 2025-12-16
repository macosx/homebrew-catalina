class GoAT122 < Formula
    desc "Open source programming language to build simple/reliable/efficient software"
    homepage "https://go.dev/"
    # 替换为预编译二进制包 URL（Intel 架构）
    url "https://go.dev/dl/go1.22.12.darwin-amd64.tar.gz"
    # 对应二进制包的 SHA256 校验值
    sha256 "e7bbe07e96f0bd3df04225090fe1e7852ed33af37c43a23e16edbbb3b90a5b7c"
    version "1.22.12"
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
      # 保留测试逻辑，验证二进制包可用
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