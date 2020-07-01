class AflFuzz < Formula
  desc "American fuzzy lop: Security-oriented fuzzer"
  homepage "https://github.com/google/AFL"
  url "https://github.com/google/AFL/archive/v2.57b.tar.gz"
  version "2.57b"
  sha256 "a6416350ef40e042085337b0cbc12ac95d312f124d11f37076672f511fe31608"

  bottle do
    sha256 "7b72b8e23c2227ced43e7cd51fd14e9134af5dab41acefcd76b2dd9671f483ad" => :catalina
    sha256 "8746ae555c6f7fb52b8deff1a9584e121568da557eb29e967147dc1c6beee305" => :mojave
    sha256 "cb0c464f59c82a4df3a8ec0cae87ceea54b49445da53be4f32c6a343d7180601" => :high_sierra
  end

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    cpp_file = testpath/"main.cpp"
    cpp_file.write <<~EOS
      #include <iostream>

      int main() {
        std::cout << "Hello, world!";
      }
    EOS

    system bin/"afl-clang++", "-g", cpp_file, "-o", "test"
    assert_equal "Hello, world!", shell_output("./test")
  end
end
