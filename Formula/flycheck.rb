require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class Flycheck < EmacsFormula
  desc "On-the-fly syntax checking extension"
  homepage "http://www.flycheck.org/"

  stable do
    url "https://github.com/flycheck/flycheck/archive/0.23.tar.gz"
    sha256 "edda4967780f3566842c87b7a5d7f2630be593b9029a7909e5c02f68c82ee9e3"
    depends_on :emacs => "24.1"
  end

  head do
    url "https://github.com/flycheck/flycheck.git"
    depends_on :emacs => "24.3"
  end

  option "with-package", "Install flycheck-package"

  depends_on "cask"
  depends_on "homebrew/emacs/dash"
  depends_on "homebrew/emacs/let-alist"
  depends_on "homebrew/emacs/pkg-info"

  resource "package" do
    url "https://github.com/purcell/flycheck-package/archive/0.6.tar.gz"
    sha256 "ec81d515d064bffca8bcc88704e4b324f87a6cbfe4b7bb0db69f07ec8d53d0db"
  end

  def install
    if build.with? "package"
      resource("package").stage do
        byte_compile "flycheck-package.el"
        (share/"emacs/site-lisp/flycheck").install "flycheck-package.el"
      end
    end

    system "make", "compile", "CASK=#{Formula["cask"].bin}/cask"
    (share/"emacs/site-lisp/flycheck").install Dir["*.el"],
                                               Dir["*.elc"]
    doc.install "README.md", Dir["doc/*"]
  end

  def caveats
    s = <<-EOS.undent
      Add the following to your init file:

      (require 'flycheck)
      (add-hook 'after-init-hook #'global-flycheck-mode)
    EOS
    if build.with? "package"
      s += <<-EOS.undent

      (eval-after-load 'flycheck
        '(flycheck-package-setup))
    EOS
    end
    s
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{share}/emacs/site-lisp/flycheck")
      (add-to-list 'load-path "#{Formula["homebrew/emacs/pkg-info"].share}/emacs/site-lisp/pkg-info")
      (add-to-list 'load-path "#{Formula["homebrew/emacs/dash"].share}/emacs/site-lisp/dash")
      (add-to-list 'load-path "#{Formula["homebrew/emacs/epl"].share}/emacs/site-lisp/epl")
      (load "flycheck")
      (load "pkg-info")
      (print (flycheck-version))
    EOS
    assert_equal "\"#{version}\"", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
