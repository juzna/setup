# My Mac OS X Setup

1. Install Homebrew:
    ```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

1. Prepare SSH keys: either copy from backup or generate new and add it to GitHub & GitLab.

1. Clone this repo, private setup and company setup:
    ```shell
    mkdir -p ~/projects/juzna
    git clone git@github.com:juzna/setup.git ~/projects/juzna/setup
    git clone git@github.com:juzna/setup-private.git ~/projects/juzna/setup/private
    git clone git@gitlab.skypicker.com:juzna/setup-company.git ~/projects/juzna/setup/company
   ```
   
1. Unlock all git-crypt in all these repos:
    ```shell
    echo "<GIT-CRYPT-KEY>" | base64 -D | git-crypt unlock -
    ```

1. Install everything from Brewfile:
  `cd ~/projects/juzna/setup; brew bundle`

1. Launch Google Drive and let it sync (needed for dotfiles)

1. Install dotfiles
  `~/projects/juzna/setup/install-dotfiles.sh`
  `/Volumes/GoogleDrive/My\ Drive/dotfiles/install-dotfiles.sh`

1. Log in to GitHub, create & link new ssh key: `gh auth login`

1. Make this repo writeable
  ```sh
  cd ~/projects/juzna/setup
  git remote set-url origin git@github.com:juzna/setup.git
  ```

## Apps

### [Oh-my-zsh](https://ohmyz.sh)
Install:
```sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Preferences:
TODO

### Google Drive
Thoughts:
* link work account; share any needed personal files


### [Keyboard maestro](http://www.keyboardmaestro.com/)
 * **Why?**: Keyboard automation
 * **Install**: 


### Alfred
* Preferences
  - Set preferences syncing to `~/GoogleDrive/My Drive/dotfiles/Alfred`
  - Set main keyboard shortcut to `F13` (not synced)
  - Set Clipboard history persistence (not synced)


### [Moom](https://manytricks.com/moom/)
* Why: Move windows via keyboard shortcuts
* Install: via `mas` (**Do not install from cask, cannot transfer license**)
* Preferences import: `plutil -convert xml1 preferences/Moom.plist.json -o - | defaults import com.manytricks.Moom -`
* Preferences export: `defaults export com.manytricks.Moom - | plutil -convert json - -o - | jq > preferences/Moom.plist.json`


### BetterTouchTool
* Why? Trackpad & keyboard shortcuts
* Install: via brew (`cask "bettertouchtool"`)
* License: in Google Drive
* Preferences import: Manually, import the preset from preferences dir
* Preferences export: Manually, export the *preset* 


### [PopClip](https://pilotmoon.com/popclip/)
* Why? Toolbar with useful quick tools
* Install: brew
* Extensions: (requires php binary installed)
  ```sh
  open preferences/PopClip/Extensions/*.popclipext
  
  wget -P /tmp/ https://pilotmoon.com/popclip/extensions/ext/{Reminders,GoogleTranslate,Alfred,WordCount,CharCount}.popclipextz
  open /tmp/*.popclipextz
  ```
* Preferences:
  * Enable Start at Login (not part of defaults)


## Thoughts

### dotfiles
 - public in git ([`dotfiles`](/dotfiles))
 - private in Google Drive
 - install via `install-dotfiles.sh` wrapper
 - secrets in Google Drive `~/.secrets`
 - TODO: direnv secrets?
