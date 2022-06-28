homebrew
----------------

安装
--------------

- 方式一

``` sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


```
- 方式二

``` sh
git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git
/bin/bash install/install.sh
```


如果以上方式出现 fatal: unable to access 'https://github.com/Homebrew/brew/': LibreSSL SSL_connect: SSL_ERROR_SYSCALL in connection to github.com:443 Failed during: git fetch --force origin 的问题则推荐用以下方式

> git config --global --add remote.origin.proxy ""



### 换源

``` sh
# 替换brew.git
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

# 替换homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew/homebrew-core.git

# 替换homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew/homebrew-cask.git

# 刷新源
brew update
```

- ali: <https://mirrors.aliyun.com/homebrew/brew.git>
- tencent: <https://mirrors.cloud.tencent.com/homebrew/brew.git>
- tsinghua: <https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git>
- ustc: <https://mirrors.ustc.edu.cn/brew.git>
