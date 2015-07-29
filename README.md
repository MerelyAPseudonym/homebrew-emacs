homebrew-emacs
==============

homebrew-emacs is a [Homebrew](http://brew.sh) tap for Emacs packages.

It enables you to install [Emacs](https://gnu.org/s/emacs/) packages
like [flycheck][], [org-mode][] and [markdown-mode][] using `brew
install`.

Like [Eric Davis](https://github.com/edavis), who I forked this from,
I’m trying to use it as an alternative to the built-in `package.el`
system that ships with Emacs 24.  The advantage is more customizable
builds and a much better interface.  Those who have many more packages
installed will probably not find those considerations compelling.

[flycheck]: http://www.flycheck.org
[org-mode]: http://orgmode.org/
[markdown-mode]: http://jblevins.org/projects/markdown-mode/

Install
-------

You can install any of the packages in `./Formula` by prefixing them
with the tap name, `dunn/emacs`:

```
brew install dunn/emacs/smex
```

That will automatically “tap” the repository (which you can do
manually with `brew tap dunn/emacs`), so then you can install formula
without prefixing:

```
brew install flycheck
```

`brew update` will then update formulae in your taps as well as those
in the core repository.

Configuration
-------------

Add this to your init file to make sure Emacs can find packages
installed by Homebrew:

```elisp
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
```

If you installed Homebrew in a non-standard location (run `brew
--prefix` to check), replace `/usr/local` with the correct Homebrew
prefix.

"Where is ___?"
---------------

- **Magit** is in the core repository: `brew install magit`

- **AucTeX** is in the TeX tap: `brew install homebrew/tex/auctex`

- **That Neat New Package** can be added by you: `brew emacs
  neat-new-package` to get started.  Pull requests are always welcome!

Uninstall
---------

To uninstall homebrew-emacs, you just need to “untap” it:

```
brew untap dunn/emacs
```

All files installed from this tap will still exist, but the formulae
will no longer be updated.
