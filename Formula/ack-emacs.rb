require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class AckEmacs < EmacsFormula
  desc "Emacs interface to Ack-like tools"
  homepage "https://github.com/leoliu/ack-el"
  url "http://elpa.gnu.org/packages/ack-1.3.tar"
  sha256 "e319e9a1ef22ca42d705829598b8bc2168317b6c2b834506546261e2a8e04fbc"
  head "https://github.com/leoliu/ack-el.git"

  depends_on :emacs => "24.1"

  def install
    byte_compile Dir["*.el"]
    (share/"emacs/site-lisp/ack").install Dir["*.el"],
                                          Dir["*.elc"]
    doc.install "README.rst"
  end

  def caveats; <<-EOS.undent
    Add the following to your init file:

    (require 'ack)
  EOS
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{share}/emacs/site-lisp/ack")
      (load "ack")
      (ack-skel-file)
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
