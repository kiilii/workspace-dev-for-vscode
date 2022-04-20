## homebrew 


### 换源

``` sh
# 替换brew.git
cd "$(brew --repo)"
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git

# 替换homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git

# 刷新源
brew update
```

- ali: https://mirrors.aliyun.com/homebrew/brew.git
- tencent: https://mirrors.cloud.tencent.com/homebrew/brew.git
- tsinghua: https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
- ustc: https://mirrors.ustc.edu.cn/homebrew/brew.git