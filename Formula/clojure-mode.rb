require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class ClojureMode < EmacsFormula
  desc "Emacs major mode for Clojure"
  homepage "https://github.com/clojure-emacs/clojure-mode"
  url "https://github.com/clojure-emacs/clojure-mode/archive/5.5.2.tar.gz"
  sha256 "75367f1a677a1c1b4c21e0f0de4d981cf3d345c159f06fcb1a38b9435ab1fc72"
  head "https://github.com/clojure-emacs/clojure-mode.git"

  option "with-inf", "Build with the inferior REPL"

  depends_on :emacs => "24.3"
  depends_on "cask"

  resource "inf" do
    url "https://github.com/clojure-emacs/inf-clojure/archive/v1.4.0.tar.gz"
    sha256 "1fb5be82a970c285e0dd6253ba77236397908ca2cc7e49a6074633ed442b91ec"
  end

  def install
<<<<<<< Updated upstream
=======
    system "make", "test", "CASK=#{Formula["cask"].bin}/cask"
    system "make", "compile", "CASK=#{Formula["cask"].bin}/cask"
    (share/"emacs/site-lisp/clojure-mode").install Dir["*.el"],
                                                   Dir["*.elc"]
    generate_autoloads "clojure-mode"
    doc.install "README.md"

>>>>>>> Stashed changes
    if build.with? "inf"
      resource("inf").stage do
        byte_compile "inf-clojure.el"
        elisp.install "inf-clojure.el", "inf-clojure.elc"
      end
    end
<<<<<<< Updated upstream
    system "make", "test"
    system "make", "compile"
    elisp.install Dir["*.el"], Dir["*.elc"]
=======
  end

  def caveats; <<-EOS.undent
    Add the following to your init file:

    (require 'clojure-mode-autoloads)
  EOS
>>>>>>> Stashed changes
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{elisp}")
      (load "clojure-mode")
      (print clojure-mode-version)
    EOS
    assert_equal "\"#{version}\"", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
