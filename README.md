# 从公式到 Stan · From Formula to Stan

把数学公式逐行翻译成 Stan 代码，并讲清每一处写法背后的“为什么”。

网站：<https://perlatex.github.io/from-formula-to-stan>

## 目录结构

```
from-formula-to-stan/
├── _quarto.yml        # website config (sidebar, freeze: auto)
├── index.qmd          # home page and learning path
├── conventions.qmd    # coding conventions shared with the Stan model library
├── chapters/          # ch01 ... ch15
├── stan/              # one .stan file per model (single source of truth)
├── R/theme.R          # shared ggplot theme (theme_minimal() based)
├── R/utils.R          # show_stan(): print a Stan file or one block of it
├── references.bib     # bibliography (APA via apa.csl)
├── apa.csl
└── _freeze/           # cached computation results, committed on purpose
```

## 本地渲染与发布

需要 R 宏包：tidyverse、cmdstanr、posterior、tidybayes、patchwork，以及已安装的 CmdStan。

首次完整渲染全站约需 10 分钟（第 9 章的模拟校准要拟合 600 次模型，约占一半时间）；之后 `freeze: auto` 只会重新运行改动过的章节。

```bash
quarto render                 # render the whole site locally
quarto preview                # live preview while writing
quarto publish gh-pages       # publish to GitHub Pages
```

`_quarto.yml` 中设置了 `freeze: auto`：只有修改过的 `.qmd` 才会重新运行代码，
其余页面直接使用 `_freeze/` 中缓存的结果。`_freeze/` 提交入库，
换一台电脑也不必重新运行全部模型。

注意：修改 `stan/*.stan` 文件不会自动触发重新渲染，需要对引用它的章节运行
`quarto render chapters/chXX-*.qmd`。

## 许可

- 正文：CC BY 4.0（见 `LICENSE-CONTENT.md`）
- 代码：MIT（见 `LICENSE`）
