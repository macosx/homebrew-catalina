class GoAT122 < Formula
    desc "Open source programming language to build simple/reliable/efficient software"
    homepage "https://go.dev/"
    # 替换为预编译二进制包 URL（Intel 架构）
    url "https://go.dev/dl/go1.18.10.darwin-amd64.tar.gz"
    # 对应二进制包的 SHA256 校验值
    sha256 "5614904f2b0b546b1493f294122fea7d67b2fbfc2efe84b1ab560fb678502e1f"
    version "1.18.10"
    license "BSD-3-Clause"
  
    # 移除 macOS 11+ 系统限制（适配 10.15）
    # on_macos do
    #   depends_on macos: "11.0"
    # end
  
    # 删除编译依赖（go-bootstrap 不再需要）
    # depends_on "go-bootstrap" => :build

    keg_only :versioned_formula
  
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