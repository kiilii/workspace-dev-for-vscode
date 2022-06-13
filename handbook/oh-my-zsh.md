## oh-my-zsh

### 安装

``` sh
# 方式一
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 方式二
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

### 配置

- 插件推荐
  - emoji
  - dotenv
  - macos
  - zsh-completions
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - colored-man-pages
  - extract

``` sh
# 
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

- 主题推荐
  - powerlevel10k

``` sh
# 
```

- 字体推荐
  - Monaco
  - MesloLGM Nerd Font Mono
  - [nerd-icon](https://github.com/ryanoasis/nerd-fonts)
  
``` sh
# install nerd-font as a icon font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

### 常见问题解决

每次打开终端都回又一串报错信息

``` sh
Last login: Mon May 28 13:35:31 on ttys001
You have mail.
[oh-my-zsh] Insecure completion-dependent directories detected:
drwxrwxrwx 7 hans admin 238 2 9 10:13 /usr/local/share/zsh
drwxrwxrwx 6 hans admin 204 10 1 2017 /usr/local/share/zsh/site-functions

[oh-my-zsh] For safety, we will not load completions from these directories until
[oh-my-zsh] you fix their permissions and ownership and restart zsh.
[oh-my-zsh] See the above list for directories with group or other writability.

[oh-my-zsh] To fix your permissions you can do so by disabling
[oh-my-zsh] the write permission of "group" and "others" and making sure that the
[oh-my-zsh] owner of these directories is either root or your current user.
[oh-my-zsh] The following command may help:
[oh-my-zsh] compaudit | xargs chmod g-w,o-w
 
[oh-my-zsh] If the above didn't help or you want to skip the verification of
[oh-my-zsh] insecure directories you can set the variable ZSH_DISABLE_COMPFIX to
[oh-my-zsh] "true" before oh-my-zsh is sourced in your zshrc file.

```

- `~/.zshrc` 中添加 `ZSH_DISABLE_COMPFIX="true"` (亲测有效)
- 对文件权限修改

``` sh
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions
```
