with import <nixpkgs> {};


let plugins = let inherit (vimUtils) buildVimPluginFrom2Nix; in {

  "horizon" = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "horizon";
    src = fetchgit {
      url = "https://github.com/ntk148v/vim-horizon";
      rev = "ca8ca90d14190aeadc352cf9f89c3508c304ec02";
      sha256 = "1qwrybl6f0mc57r7bj9x393536inv2pcccy5lc3g663z4k1dixfr";
    };
    dependencies = [];
  };
  "awesome-vim-colorschemes" = buildVimPluginFrom2Nix {
    name = "awesome-vim-colorschemes";
    src = fetchgit {
      url = "https://github.com/rafi/awesome-vim-colorschemes";
      rev = "6b89c217ffa50f92a7afdcb01d2af071ff9b80a0";
      sha256 = "03d12fi90kbhf74p1yh721nfa26r2ns7ad5k6a7n6fwl3anrq4g4";
    };
  };
  "scss-syntax.vim" = buildVimPluginFrom2Nix {
    name = "scss-syntax.vim";
    src = fetchgit {
      url = "https://github.com/cakebaker/scss-syntax.vim";
      rev = "bda22a93d1dcfcb8ee13be1988560d9bb5bd0fef";
      sha256 = "0p6yy6d7lwi87rvk4c6b2ggrvpddrfksrgdwz993gvxxxbnpwi8q";
    };
  };
  "lightline" = buildVimPluginFrom2Nix {
    name = "lightline";
    src = fetchgit {
      url = "https://github.com/itchyny/lightline.vim";
      rev = "09c61dc3f650eccd2c165c36db8330496321aa50";
      sha256 = "14g79s9pn8bb50kwd50sw8knss5mgq8iihxa2bwkjr55jj5ghkwb";
    };
  };
}; in vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = ''
      let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
      set nocompatible
      syntax on
      colo onedark
      set nu
      set autoindent
      set t_Co=256
      set termguicolors
      filetype plugin on
      autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
      nmap <F6> :NERDTreeToggle<CR>
      let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
      autocmd FileType scss set iskeyword+=-
      au BufRead,BufNewFile *.scss set filetype=scss.css
      autocmd Filetype css setlocal tabstop=2
    '';
    # Use the default plugin list shipped with nixpkgs
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // plugins;
    vimrcConfig.vam.pluginDictionaries = [
        { names = [
            # Here you can place all your vim plugins
            # They are installed managed by `vam` (a vim plugin manager)
            "nerdtree"
            "youcompleteme"
            "horizon"
            "awesome-vim-colorschemes"
            "lightline"
            "haskell-vim"
            "vim-nix"
            "scss-syntax.vim"
        ]; }
    ];
}
