require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class Epl < EmacsFormula
  desc "package.el API"
  homepage "https://github.com/cask/epl"
  url "https://github.com/cask/epl/archive/0.7.tar.gz"
  sha256 "9cde82f2b1b8243e8eab8146fcdae3e191cf291e734ef7e0ad4c820c7ad9020d"
  head "https://github.com/cask/epl.git"

  depends_on :emacs => "24.1"
  depends_on "cask"

  def install
    system "make", "compile", "CASK=#{Formula["cask"].bin}/cask"
    system "make", "test"
    (share/"emacs/site-lisp/epl").install Dir["*.el"],
                                          Dir["*.elc"]
    doc.install "README.md"
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{share}/emacs/site-lisp/epl")
      (load "elp")
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
