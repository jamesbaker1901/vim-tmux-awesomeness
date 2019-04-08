# OSX Vim + Tmux Awesomness

## Introduction
This repo contains everything you need to get set up with a beautiful and highly productive vim + tmux environment on OSX (linux guide coming soon!) ... I use this exact setup daily as a Site Reliability Engineer at [Skuid](https://www.skuid.com/), writing Go, making quick bash scripts, troubleshooting kubernetes, etc. There are lots of similar guides out there, but none of them delivered the exact experience I was looking for. 

## Setup up MacVim
In order to take advantage of the excellent vim plugin [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) for code completion, we need to install [MacVim](https://github.com/macvim-dev/macvim). If you don't want code completion, or already have a completion plugin you like, then feel free to skip this step. I've used the rest of the plugins with OSX default vim without issue. However, if you're just feeling lazy, then I _highly_ recommend you push through and set up MacVim and YouCompleteMe. It really takes the whole vim coding experience to another level.


```$ brew install vim
$ echo "export PATH=\"/usr/local/sbin:$PATH\" >> ~/.bash_profile # ensure homebrew bin is in your $PATH
$ source ~/.bash_profile
```

Ensure homebrew vim is in your path:
```$ which vim 
/usr/local/bin/vim   # this is the default vim from OSX, not what we want

$ brew info vim
vim: stable 8.1.1100 (bottled), HEAD
Vi 'workalike' with many additional features
https://www.vim.org/
Conflicts with:
  ex-vi (because vim and ex-vi both install bin/ex and bin/view)
  macvim (because vim and macvim both install vi* binaries)
/usr/local/Cellar/vim/8.1.1100 (1,845 files, 30.9MB) *
... 
```

`/usr/local/Cellar/vim/8.1.1100`  that's the path we're looking for.
Now we create a symlink to get the homebrew vim in our path. You could put this symlink anywhere
in your path that's before the system default vim, but homebrew will put other symlinks at `/usr/local/sbin` 
so we may as well put it there.

```
$ ln -s /usr/local/Cellar/vim/8.1.1100/vim /usr/local/sbin/vim
```

### Clone my vimrc



### SetUp Vim Plugins
Open vim and run `:PluginInstall`. 
``` 
$ vim
:PluginInstall
:q
:q
```
That's it! All of the plugins should install without issue. If anything fails or complains, just try googling the error.

### Set up YouCompleteMe
This is such a great plugin. I've tinkered with most of the completion plugins for Vim and YouCompleteMe is the best. If there's one you like better, then feel free to skip the MacVim installation above (it's a requirement for YCM and the only reason I bother with it).
Detailed instructions are here: [github.com/Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe), but
we since we set up homebrew vim, we'll just go straight to the installation.

```
$ cd ~/.vim/bundle/YouCompleteMe 
$ ./install.py --all
```

Passing `--all` will have the isntaller compile completion binaries for C#, Go, JavaScript and TypeScript, Rust, and Java. 
If you only want support for just one, then head here: [github.com/Valloric/YouCompleteMe#mac-os-x](https://github.com/Valloric/YouCompleteMe#mac-os-x)
and pick out the individual flags for just the language(s) you want and replace `--all` with them.

### Vim Theme
Super important to pick a good theme. If you have a popular one from VS code or another editor that you like, it probably exists for Vim as well.
This site, [vimcolors.com](https://vimcolors.com/) has lots of themes to browse and search through with previews. Many themes can
be installed with the Vundle plugin manager. Otherwise, you typically just clone the theme repo and copy/symlink the `colors/theme-name.vim`
file to your `~/.vim/colors`

### Vim Plugins
I use quite a few plugins, but all of them are there because I use them. Always make time to prune your plugins, lest your `~/.vimrc` become unruly. If you start having problems, you'll be hard pressed to track it down to a single config line or plugin when you have dozens of them. I write Go and Rust, so a lot of these plugins are there to support that work. If you use python or another language, there are plenty of guides to help you get a more fine grained setup for your language of choice. Just google `vim <language> setup` and you'll get plenty of inspiration. 

## Set up tmux
```
$ brew install tmux
```

### Oh My Tmux!
[Oh My Tmux!](https://github.com/gpakosz/.tmux) is a really well done and thoughtout tmux config with lots of goodies set up for you.
You could of course build your own config from scratch or clone any number of other tmux configs. If you don't care for the powerline
look or some of the config decisions the Oh My Tmux! maintainer made, then definitely shop around! Or, do like I did and fork his repository
and use it as the base of your own, superior config :)

### Additional tmux config
Add this to the bottom of your `~/.tmux.conf.local` file:

```
# clipboard sync
if-shell -b 'test $(uname) = "Linux"' 'bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"'
if-shell -b 'test $(uname) = "Darwin"' 'bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"'

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# Configure plugins
set -g @continuum-restore 'on' #auto restore last saved env
set -g @resurrect-strategy-vim 'session' #auto restore vim sessions
set -g focus-events on #required for vim focus events to work

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'
```

## Workflow
Now we get to the good stuff. How do you actually get work done without an IDE? Without a mouse?! Once you've learned the keyboard shortcuts, it's very efficient, fast and easy. The learning curve will be steep at first, but eventually these shortcuts will become second nature to you and you won't even have to think about it. The same is true of any vim, tmux set up, not just this one.

The benefit to this particular set up, is that you won't have to leave vim (_or_ lose focus) to compile your code, run tests, run your binaries, etc. Because we're using `tmux` and the lovely [vim-slime](https://github.com/jpalardy/vim-slime) plugin, we can send commands to another tmux pane without leaving vim!

### Shortcuts
This set up is all about the shortcuts ... one of the main reasons to adopt a terminal only, vim+tmux development environment is the efficiency gain from being able to keep your findgers not just on the keyboard, but on the home keys as much as possible. The basic vim keybindings do a great job of this already, and this setup tries to keep true to vim conventions as much as possible, while adding additional functionality. We won't cover the basics of getting around vim, just the changes I've made in my `~/.vimrc`. 

Something to consider is the `<leader>` key. By default it's `]`, but I've remapped it to `,` with `let mapleader = ","` since I find it to be more convenient to use. Feel free to keep the default or choose your own `<leader>` key.

#### General remaps
##### Vim
Normal mode:
* `;;` | `<Esc>` - exit INSERT mode. This one is super useful as exiting INSERT mode happens all the time, and now you can do it with a home key! If you actually need to type two semi-colons, just do it a bit more slowly. 
* `<CTRL>+j` | `:bd` - Next buffer. Using `j` and `k` to navigate buffers, keeps with the vim convention for moving around.
* `<CTRL>+k` | `:bp` - Previous buffer.
* `<CTRL>+d` | `:bd` - Close buffer. just like `<CTRL>+d` closes a shell in bash.
* `<RightMouse>` - Exits and enters INSERT mode. If you happen to have your hand on the mouse, right click will cycle through INSERT/NORMAL mode.

Plugin specific remaps:
* `<CTRL>+n` - Open or close the NERDTree file browser.
* `<CTRL>+ww` - Cycle trhough open windows. If you have NERDTree open, this will bring you back to the main file you're editing.

Vim+Tmux remaps:
* `,c` - Uses `tmux send-keys` to send `<CTRL>-c` to the `right` pane. Generally when coding, I have vim in a left pane and a few panes on the right to run my compiled code, run tests, etc. If you're tmxu layout is different, you'll need to edit  this line: nnoremap `<buffer> <leader>c :!tmux send-keys -t right C-c<CR><CR>`. The vim pane will flicker when you run this. That's normal. Basically, vim has to pause to run a terminal command. 
* `,b` - Uses [vim-slime](https://github.com/jpalardy/vim-slime) to send a build command to the right pane, based on the file type, i.e., while editing a `*.go` file, `go build` will be sent to the right pane. For rust (`*.rs`), `cargo build` will be sent. 
* `,r` - Uses vim-slime to send the build command for the language, and also runs `./.run.sh` This way, you can just add a `./.run.sh` hidden file to your project with the command to run your compiled binary, and any extra arguments it needs. These might change between projects. Of course, this is just one way to handle this. You can modify the remap to run anything you like (use make, etc.).
* `,ll` - Uses vim-slime to send `ll` to the right pane. `ll` is a common alias for `ls -alF` on linux distributions. Personally I use the beautiful [exa](https://github.com/ogham/exa) as an `ls` replacement, so I have `ll` alias'd to `exa -bghHliS`.

##### Tmux
I didn't really mess with the tmux bindings set up by the Oh My Tmux! author, you can view them here: [github.com/gpakosz/.tmux#bindings](https://github.com/gpakosz/.tmux#bindings).
