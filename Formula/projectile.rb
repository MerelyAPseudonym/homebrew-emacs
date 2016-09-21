require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class Projectile < EmacsFormula
  desc "Project Interaction Library for Emacs"
  homepage "http://batsov.com/projectile/"
  url "https://github.com/bbatsov/projectile/archive/v0.14.0.tar.gz"
  sha256 "c7417e25f2fc113194ca68aaecb1a6fe55e44734d5ab0fd643ba7eb0511779d6"
  head "https://github.com/bbatsov/projectile.git"

<<<<<<< Updated upstream
  depends_on :emacs => "24.1"
  depends_on "homebrew/emacs/dash-emacs"
  depends_on "homebrew/emacs/epl"
=======
  option "with-helm", "Helm integration for Projectile"
  option "with-persp", "Perspective integration for Projectile"
  
  depends_on "homebrew/emacs/dash"
>>>>>>> Stashed changes
  depends_on "homebrew/emacs/pkg-info"

  depends_on "homebrew/emacs/helm" if build.with? "helm"
  # depends_on "homebrew/emacs/perspective" if build.with? "persp"

  resource "helm-projectile" do
    url "https://raw.githubusercontent.com/bbatsov/projectile/v0.12.0/helm-projectile.el"
    sha256 "0ba641c02d5897d2702711f411a3a2f6399a8b8576b8dc700f64125425aa2019"
  end

  resource "persp-projectile" do
    url "https://raw.githubusercontent.com/bbatsov/projectile/v0.12.0/persp-projectile.el"
    sha256 "4e4552178674765983e8a43aa7cc0bfa5a15ef16e7169b13504a186740d8a6fa"
  end



  def install
    byte_compile "projectile.el"
    elisp.install "projectile.el", "projectile.elc"
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{Formula["homebrew/emacs/dash-emacs"].opt_elisp}")
      (add-to-list 'load-path "#{Formula["homebrew/emacs/epl"].opt_elisp}")
      (add-to-list 'load-path "#{Formula["homebrew/emacs/pkg-info"].opt_elisp}")
      (add-to-list 'load-path "#{elisp}")
      (load "projectile")
      (print (projectile-version))
    EOS
    assert_equal %("#{version}"), shell_output("emacs --quick --batch --load #{testpath}/test.el").strip
  end
end
