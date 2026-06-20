# How to Use

这份文档说明当前这套 Neovim、Yazi、tmux 配置怎么用，以及最值得先记住的快捷键。

## 1. Neovim

### 当前风格

- 主题：catppuccin mocha
- 文件树：neo-tree
- 搜索：telescope
- LSP：lua / python / ruff
- 自动补全：nvim-cmp + luasnip

### 你现在已经配置好的快捷键

#### 通用

- `Space w` 保存
- `Space q` 退出
- `Esc` 清除搜索高亮

#### 窗口移动

- `Ctrl-h` 左
- `Ctrl-j` 下
- `Ctrl-k` 上
- `Ctrl-l` 右

#### 文件 / 搜索

- `Space e` 打开或关闭文件树
- `Space f f` 查找文件
- `Space f g` 全局搜索
- `Space f b` 切换 buffer

#### LSP

- `gd` 跳转定义
- `gr` 查找引用
- `K` 查看文档

### 必学经典 Vim 快捷键

#### 模式

- `i` 插入
- `a` 在后方插入
- `o` 下方新开一行
- `Esc` 回普通模式

#### 移动

- `h j k l` 左下上右
- `w` 下一个词
- `b` 上一个词
- `e` 到词尾
- `0` 到行首
- `^` 到第一个非空字符
- `$` 到行尾
- `gg` 文件开头
- `G` 文件结尾

#### 编辑

- `x` 删除字符
- `dd` 删除行
- `yy` 复制行
- `p` 粘贴
- `u` 撤销
- `Ctrl-r` 重做
- `.` 重复上一次修改

#### 经典组合

- `dw` 删除一个词
- `cw` 修改一个词
- `d$` 删除到行尾
- `cc` 修改整行

#### 搜索

- `/text` 向下搜索
- `n` 下一个
- `N` 上一个
- `*` 搜当前单词
- `#` 反向搜当前单词

#### 滚屏

- `Ctrl-d` 下半页
- `Ctrl-u` 上半页
- `Ctrl-f` 下一页
- `Ctrl-b` 上一页
- `zz` 当前行居中

### 一句核心理解

Vim 最核心的是：

```text
操作符 + 移动 = 编辑
```

比如：

- `d` + `w` = `dw`
- `c` + `w` = `cw`
- `y` + `$` = 复制到行尾

这套思路吃透了，后面会越用越快。

## 2. Yazi

### 当前风格

- 显示隐藏文件
- 自然排序
- 带 git 状态插件
- 文字文件默认用 `nvim` 打开
- 有边框美化
- 加了 bunny 书签跳转

### 当前自定义键

- `Enter` 使用 `smart-enter`
  - 目录：进入
  - 文件：打开
- `m` 打开 `bunny` 书签跳转

### 建议先学的 Yazi 常用键

- `j` / `k` 上下移动
- `h` 返回上级目录
- `l` 进入目录 / 打开
- `g` 开头，`G` 结尾
- `Space` 选中
- `yy` 复制
- `dd` 剪切
- `pp` 粘贴
- `/` 搜索
- `.` 切换隐藏文件
- `q` 退出

### 你的当前配置特点

- 文本文件直接走 nvim
- 预览开启换行
- 大图预览尺寸放得比较宽
- 适合拿来当 CLI 文件中枢

### 💡 常见问题解答 (Troubleshooting)

#### Q: Yazi 的小图标（Icon）显示不出来（空白/方块/问号）？
**A:** `yazi` 的图标显示完全依赖 **Nerd Fonts**。若显示异常，是因为你的终端软件没有配置图标字体：
1. **如果是 Windows 远程连接 (SSH) 或 WSL2**：
   - 必须在 **Windows 本地** 下载并安装字体，因为画面是由 Windows 终端负责渲染的。
   - 下载并解压 [JetBrainsMono.zip](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip)。
   - 安装其中的 `.ttf` 字体文件。
   - 将终端的字体族（Font Family）修改为 `'JetBrainsMono Nerd Font'` 或 `'JetBrainsMono NFM'`。
2. **如果是 Linux 本地环境**：
   - 需确保系统字体库中已安装 Nerd Font。可将字体文件放入 `~/.local/share/fonts/` 并运行 `fc-cache -fv` 刷新，然后重启终端并应用该字体。


## 3. tmux

### 当前风格

- 鼠标开启
- 历史记录很长
- 窗口从 1 开始编号
- 自动重编号
- 支持系统剪贴板
- 用 TPM 管理插件
- 开了 resurrect + continuum 做会话恢复

### 当前你已经配置的功能

- `prefix r` 重载配置
- `prefix |` 横向分屏
- `prefix -` 纵向分屏
- `prefix c` 在当前目录开新窗口

默认 prefix 是：

- `Ctrl-b`

所以实际按法是：

- `Ctrl-b r`
- `Ctrl-b |`
- `Ctrl-b -`
- `Ctrl-b c`

### 必学 tmux 常用键

#### 会话 / 窗口 / 面板

- `Ctrl-b c` 新建窗口
- `Ctrl-b ,` 重命名窗口
- `Ctrl-b n` 下一个窗口
- `Ctrl-b p` 上一个窗口
- `Ctrl-b w` 窗口列表
- `Ctrl-b |` 左右分屏
- `Ctrl-b -` 上下分屏
- `Ctrl-b o` 切到下一个 pane
- `Ctrl-b x` 关闭 pane
- `Ctrl-b d` detach

#### 复制模式

- `Ctrl-b [` 进入复制模式
- 在复制模式中用 `hjkl` / 翻页移动
- `q` 退出复制模式

#### 插件相关

- `Ctrl-b I` 安装 TPM 插件
- `Ctrl-b r` 重新加载配置

### 这套 tmux 最有价值的点

不是花哨，是：

- 能恢复工作现场
- 多窗口多 pane 稳定
- 和 nvim / yazi 配合很好

## 4. 推荐你的使用套路

### 日常开发 / 学习流

1. 开 `tmux`
2. 一个 pane 放 `nvim`
3. 一个 pane 放 `yazi`
4. 需要搜索时用 telescope
5. 需要跨任务时新建 tmux window

### 一个很顺手的组合

- `tmux` 管工作区结构
- `yazi` 管文件浏览和挑文件
- `nvim` 管编辑

这三者其实就是一整套 CLI 工作台。

## 5. 最值得先背下来的最小集合

### Neovim

- `i a o Esc`
- `h j k l`
- `w b 0 $ gg G`
- `dd yy p u .`
- `dw cw / n`
- `Space e`
- `Space f f`

### Yazi

- `j k h l`
- `Enter`
- `m`
- `/`
- `q`

### tmux

- `Ctrl-b c`
- `Ctrl-b |`
- `Ctrl-b -`
- `Ctrl-b o`
- `Ctrl-b d`
- `Ctrl-b r`

## 6. 学习建议

别追求一次学完。

最好的方式是：

- 连续几天强迫自己不用鼠标
- 只练最小快捷键集
- 每天再加 2 到 3 个新操作

这样会比背大表有效得多。
