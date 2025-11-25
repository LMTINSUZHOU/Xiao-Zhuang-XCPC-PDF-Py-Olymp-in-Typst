# Xiao-Zhuang-XCPC-PDF-Py-Olymp-in-Typst

## 使用说明

> 此处文字借鉴自项目：[Olymp in Typst](https://github.com/lihaoze123/olymp-in-typst)

### 1前提条件

- 安装[Typst](https://typst.app/)
- 安装Vscode及Tinymist Typst、vscode-pdf插件
- 安装本模板使用的字体：New Computer Modern、FZShuSong-Z01、CMU Sans Serif、FZHei-B01、FZKai-Z03、Times New Roman

### 2 配置竞赛信息

用户可在`main.typ`文件中配置竞赛信息

```typescript
#import "template.typ": contest-conf
#import "problems.typ": problems  // 或者从您的题目文件中导入
#import "@preview/mitex:0.2.6": *

#show: contest-conf.with(
  title: "2026年南晓开放原子社大学生程序设计新年赛",
  subtitle: "正式赛",
  author: "本次竞赛由南晓开放原子社ICPC竞赛集训队命题",
  date: "2026年2月2日",
  problems: problems
)

```

### 3 配置问题

用户可在`problem.json`中使用以下JSON格式定义您的竞赛题目：

```json
[
  {
    "problem": {
      "display_name": "复杂LaTeX题目", \\题目名称
      "latex": true, \\开启latex
      "samples": [ \\样例
        {
          "input": "World",
          "output": "Hello, World!"
        },
        {
          "input": "Typst",
          "output": "Hello, Typst!"
        }
      ]
    },
    "statement": { \\题面
      "description": "给定一个函数$f(x) = \\frac{x^2 + 1}{x - 1}$，计算...",
      "input": "输入包含一个整数$n$。",
      "output": "输出结果为 $\\boldsymbol{\\frac{result}{2}}$。",
      "notes": "约束：$0 \\le n \\le 10^9$"
    }
  },
  {
    "problem": {
      "display_name": "复杂LaTeX题目",
      "latex": true,
      "samples": [
        {
          "input": "World",
          "output": "Hello, World!"
        },
        {
          "input": "Typst",
          "output": "Hello, Typst!"
        }
      ]
    },
    "statement": {
      "description": "给定一个函数$f(x) = \\frac{x^2 + 1}{x - 1}$，计算...",
      "input": "输入包含一个整数$n$。",
      "output": "输出结果为 $\\boldsymbol{\\frac{result}{2}}$。",
      "notes": "约束：$0 \\le n \\le 10^9$"
    }
  }
]
```

- **`problem.display-name`**: 题目标题
- **`problem.latex`**: 设置为`true`时，使用`mitex`渲染LaTeX格式的题目字段（默认：`false`）
- **`problem.samples`**: 样例输入输出对的数组，用于题目说明
- **`statement.description`**: 完整的题目描述（支持数学符号）
- **`statement.input`**: 输入数据格式说明
- **`statement.output`**: 输出数据格式说明
- **`statement.notes`**: 可选的约束、提示或额外注释

### 4 构建PDF

1. 克隆或下载此模板

2. 编辑`problems.json`以添加您的竞赛题目、`main.typ`来编辑比赛信息

3. 构建PDF：

```shell
typst compile main.typ
```

---

本项目参考自：https://github.com/lihaoze123/olymp-in-typst

感谢[lihaoze123](https://github.com/lihaoze123)大佬的开源项目！