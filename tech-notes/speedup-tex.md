## 如何加速 LaTeX 编译


### **十秒钟速览**

1. 换用 Linux 系统
2. 使用批处理模式，即编译时加上 `-interaction=batchmode` 参数
3. 使用预编译技术，涉及到一个宏包（`mylatexformat`）和两条命令：
    1.  `etex -initialize -jobname="hello" "&pdflatex" "mylatexformat.ltx" "hello.tex"`
    2. `pdflatex -shell-escape "&hello" hello.tex`
4. 一些其他（作用较小的或者适用范围狭窄的）技巧

---

### **前言**

“We should forget about small efficiencies, say about 97% of the time: premature optimization is the root of all evil. Yet we should not pass up our opportunities in that critical 3%.”

“我们应该忽略小的开销，比方说97%的时间：过早优化是万恶之源。然而我们不应放弃那重要的3%的机会。”

——Donald E. Knuth. ["Structured Programming with Goto Statements".](http://dl.acm.org/ft_gateway.cfm?id=356640) Computing Surveys 6:4 (December 1974), pp. 268, §1.

<!-- The real problem is that programmers have spent far too much time worrying about efficiency in the wrong places and at the wrong times; premature optimization is the root of all evil (or at least most of it) in programming. -->

<!-- ——1974 Turing Award Lecture, Communications of the ACM 17 (12), (December 1974), pp. 667-673 -->
<!-- ——*[Donald E. Knuth. 1974. Computer programming as an art. Commun. ACM 17, 12 (December 1974), 667-673.](https://doi.org/10.1145/361604.361612)* -->

---

不只一个人跟我抱怨过，“LaTeX 的编译实在是太慢了”。尤其是在入门阶段，用户需要不断重复编译和预览的过程，来验证代码的功能。

实际上，考虑到 TeX 系统在底层要做的大量工作，它的速度已经很快了。然而贪婪的用户只会怀念 Word 这样的文字处理软件，并且由衷地感叹，“为什么 TeX 不能像 Word 那样即改即得呢”。

我这里不会向你介绍 TeX 底层是多么辛苦，做了多少繁琐的工作，兼顾了多少复杂的情况。因为大部分用户并不在乎。

我也不必解释 TeX 的使用方式和 Word 相比是怎样的不同。因为你不应说服一个抡锤子砸墙的人去使用电钻。

这篇文章面向有一定基础并且面临同样问题的 TeX 用户，当然对于新手来说也并不难懂。如果你觉得用不上或者不会用，不必感到烦恼，等你真正需要用的时候自然就能理解了。

---

### **性能瓶颈分析**

正如开篇所言，仅凭模糊猜测和反复试验去做优化是非常低效的，这是企图用战术上的勤奋（不断调试）来掩盖战略上的懒惰（不去探究背后的原理和机制）。

关于 TeX 程序的性能瓶颈，其实在 @李阿玲 的 [这个回答](https://www.zhihu.com/question/294983491/answer/493189992) 中已经说得很好了。

我这里摘抄核心部分如下：

> 任何TeX，影响它速度主要还是文件I/O，尤其是Windows下面的影响，非常显著。同等的硬件，换成Linux+ext4的话，效果会很不一样。

> 其次是解析上的操作，从源文件到token这一级别，中间有可能做编码转换之类。但是这一部分不会耗时太长。之所以能够影响速度是因为调用的包的子文件比较多，尤其是tikz之类的大包。

> 插图其实并不会怎么影响TeX的速度，之所以让人感觉插图会比较耗时，那是因为XeTeX调用了dvipdfmx插图的时候会读文件，会有压缩运算，这速度自然会慢一些。

总结起来就是 TeX 的性能瓶颈在于：**文件 I/O**。

而文件 I/O 速度主要取决于操作系统和硬件。

这是因为在不同的操作系统下，TeX 系统的实现是有区别的，这也就造成了文件 I/O 速度上的差异。

经过粗略且不准确的测试，在相同硬件性能的情况下，同样的 TeX 代码，在 Ubuntu 18.04 虚拟机下的运行时间大概是 Windows 10 物理机的 40% ~ 70%。（@李阿玲 说如果采用 Linux 物理机性能提升会更加明显。由于手头没有配 Linux 的物理机，所以暂时无法验证。）

此外，一个值得注意的说法是，将机械硬盘换成固态硬盘效果更佳。然而我在测试当中，发现在 Windows 下，TeX 系统装在不同类型的硬盘中并没有明显的速度差别（甚至将 TeX 装到 RAMDisk 中也没有明显提升）。希望有大佬给出相关的测试数据，验证或否定我的测试结果（最好能否定），要是能说明原因就更好了。这也是我感到十分不解的一个地方。

除了存储设备，CPU 也有一定的影响，不过提升 CPU 性能获得的收益，并不如提升文件 I/O 速度。

当然，确实有人问过 LaTeX 编译性能最佳的硬件配置：

- [Tips for choosing hardware for best LaTeX compile performance](https://tex.stackexchange.com/questions/103565/tips-for-choosing-hardware-for-best-latex-compile-performance)

结论是：起决定性因素的是 CPU 的单线程计算能力。

这个贴子下的回答，也提到了和我上面的测试一致的结果：磁盘 I/O 速度对于 TeX 的文件 I/O 并没有太大影响。

所以我觉得这里所说的“文件 I/O 速度”，可能并不是单纯指将 .tex/.sty/.cfg/.def 这些文件导入到内存的速度，而是包括了 TeX 解析各种宏包再导入子文件时的速度，而不同操作系统下的差异就体现在这一步。

你问我能不能用 GPU 加速 LaTeX 编译？没错，也有人问过了：

- [Is it possible to use GPU acceleration on compiling large LaTeX documents?](https://tex.stackexchange.com/questions/409232/is-it-possible-to-use-gpu-acceleration-on-compiling-large-latex-documents)

结论是：几乎不可行。除非你能将 TeX 的 CPU 指令转换为 GPU 指令，并且让操作系统支持这些操作。


不同的引擎（pdfTeX、XeTeX、LuaTeX）的速度也会有些许差异。比如一般情况下 pdfTeX 速度要快于其他引擎，不过也有 [ptex-ng](https://github.com/clerkma/ptex-ng) 这种性能更高的引擎（是基于 C 语言的 TeX82 实现），我有幸尝试过一个私人版本，速度快得飞起。大家有兴趣可以邀请它的作者 @李阿玲 多科普科普这个引擎。

不同的编译模式也有细微的影响。经过测试，使用批处理模式（`batchmode`）速度要优于默认的模式（不加参数）和其他一些模式（比如 `nonstopmode` 和 `scrollmode`）， 这是因为批处理模式在编译和执行阶段是静默的，不输出任何信息，因此要快上一些。

---

### **性能提升方法**

上面扯了那么多瓶颈，那么下面谈一谈怎么改善这些瓶颈。

其实主要有三个办法：**换用 Linux 、使用批处理模式和预编译。**

TeX 在 Linux 下的表现确实是大大优于 Windows 的。不过这个方法对大多数人来说并不现实，毕竟大多数人习惯用的系统是 Windows。

使用批处理模式，就是编译时加上 `-interaction=batchmode` 参数，即 `pdflatex -interaction=batchmode hello.tex`。需要注意的是，批处理模式不会报错（虽然我用 Sublime Build System 时会提示返回 exit code 1）。因此如果需要检查代码的错误，那么不建议使用批处理模式。

预编译就是生成 .fmt 文件，把 .tex 文件序言区那些诸如 newcommand 和 usepackage 的东西打包起来。

大家都有经验，复制很多小文件花费的时间，要远大于复制单个大文件的时间。TeX 的预编译把各种小文件打包成一个大文件，那么之后的编译，只需要导入和解析这个大文件就可以，就不用挨个再索引和导入各种零碎的小文件了。它在 I/O 速度上的提升正源于此。

有一个 [`mylatexformat`](https://ctan.org/pkg/mylatexformat) 宏包，可以帮助用户预编译文件序言区。在 `mylatexformat` 之前其实有另外一个同样功能的宏包，叫 [`mylatex`](https://ctan.org/pkg/mylatex) 。不过我还是推荐使用 `mylatexformat`。

当然还有人会提到一些其他的技巧，比如：

1. 将 TikZ 绘图的代码提前编译好，直接 include 生成的 pdf 文件
2. 避免使用 `ctex` 和 `tikz` 这样的庞大而零碎的宏包
3. 对于 pdfTeX 引擎，可以加上 `-draftmode` 参数
4. 对于 XeTeX 引擎，可以加上 `-output-driver='xdvipdfmx -z0'` 参数调整压缩级别，用文件大小换取编译速度

这些技巧的改善作用其实并不大，而且也有明显的适用范围限制。大家可以酌情尝试和选用。

虽然上面提到不同的引擎（pdfTeX、XeTeX、LuaTeX）有速度差异，不过并不明显，所以不必纠结。

下面着重介绍如何预编译 `.tex` 文件。

---

### **预编译流程**
假设你有这样一个 `hello.tex` 文件：

```
\documentclass[border=5pt, tikz]{standalone}
\usepackage{tikz}
\usepackage[UTF8]{ctex}
\newcommand{\hello}{Hello 你好}

\begin{document}
\begin{tikzpicture}
\node [draw, thick, minimum width=10em, minimum height=10em] {English 中文 \hello};
\end{tikzpicture}
\end{document}
```

那么预编译只需要在命令行中运行这条指令：

`etex -initialize -jobname="hello" "&pdflatex" "mylatexformat.ltx" "hello.tex"`

就能在文件夹中看到 `hello.fmt` 文件，这个文件里包含了你在 `hello.tex` 序言区定义的宏和导入的宏包。

- `etex` 是原生 TeX 的一个扩展版本，源于 NTS （New Typesetting System）项目，是开发 LaTeX2e 时用的引擎，后续的引擎比如 pdfTeX 和 XeTeX 都以它为基础或者参照。

- `-initialize` 参数就是表明要将文件转储（dump）到一个中间文件，这里也就是生成 `.fmt` 文件
- `-jobname="hello"` 是指定生成的 `.fmt` 文件名为 `hello.fmt`
- `&pdflatex` 指定生成的 `.fmt` 文件对应的引擎是 pdfLaTeX
- `"mylatexformat.ltx"` 则是我们上面提到的宏包，用于对序言区进行处理，方便 `.fmt` 文件的转储
- `hello.tex` 自然就是源文件了，写在序言区的语句会被预编译（更高级地，可以用 `\endofdump` 这样的语句指定哪些部分要预编译，哪些不要预编译）


预编译时输出的信息是这样的：

```
This is pdfTeX, Version 3.14159265-2.6-1.40.19 (MiKTeX 2.9.6930 64-bit) (INITEX)
entering extended mode

% 各种导入的文件信息

(C:\Users\xxx\AppData\Roaming\MiKTeX\2.9\tex/latex/mylatexformat\mylatexforma
t.ltx
LaTeX2e <2018-12-01>
) (hello.tex
(C:\Users\xxx\AppData\Roaming\MiKTeX\2.9\tex/latex/standalone\standalone.cls
Document Class: standalone 2018/03/26 v1.3a Class to compile TeX sub-files stan
dalone
(D:\MiKTeX\tex/latex/tools\shellesc.sty)
(D:\MiKTeX\tex/generic/oberdiek\ifluatex.sty)
(D:\MiKTeX\tex/generic/oberdiek\ifpdf.sty)
(D:\MiKTeX\tex/generic/ifxetex\ifxetex.sty)
...
(C:\Users\xxx\AppData\Roaming\MiKTeX\2.9\tex/generic/ctex\zhwindowsfonts.tex{
C:/Users/xxx/AppData/Local/MiKTeX/2.9/pdftex/config/pdftex.map}{UGBK.sfd}{Uni
code.sfd}))))
(C:\Users\xxx\AppData\Roaming\MiKTeX\2.9\tex/latex/ctex/config\ctex.cfg) )


% 接下来就是将上面导入的子文件和字体 dump 到 hello.file

Beginning to dump on file hello.fmt
 (preloaded format=hello 2019.1.16)
30612 strings of total length 571285
464867 memory locations dumped; current usage is 329&459222
26854 multiletter control sequences

% 一些字体相关的配置

\font\nullfont=nullfont
\font\OMX/cmex/m/n/5=cmex10
\font\tenln=line10
\font\tenlnw=linew10
\font\tencirc=lcircle10
...
\font\OT1/cmr/bx/it/9.03374=cmbxti10 at 9.03374pt
\font\OT1/cmr/bx/it/7.52812=cmbxti10 at 7.52812pt
\font\OT1/cmr/bx/it/5.52061=cmbxti10 at 5.52061pt
537653 words of font info for 41 preloaded fonts

% 字符连接的信息

1141 hyphenation exceptions
Hyphenation trie of length 362741 has 8547 ops out of 35111
  143 for language 74
  377 for language 73
  110 for language 72
...
  97 for language 2
  137 for language 1
  181 for language 0

% 告诉你它完事了

0 words of pdfTeX memory
3 indirect objects
No pages of output.
Transcript written on hello.log.
```

然后编译原文件。在命令行运行：

`pdflatex -shell-escape "&hello" hello.tex`

或者：

`latex -shell-escape --output-format pdf "&hello" hello.tex`

- 此时我们加上 `&hello` 参数，也就是用上了 `hello.fmt` 文件
- 不要忘记 `-shell-escape` 参数

更多 `mylatexformat` 宏包使用相关的细节可以参考它的文档：[CTAN: Package mylatexformat](http://mirrors.ctan.org/macros/latex/contrib/mylatexformat/mylatexformat.pdf)。

这里有几点说明：

- 预编译对 pdfTeX 的支持是比较好的，也支持大多数宏包。
- 一旦涉及到某些字体相关的事情，预编译就会出现问题。这是因为 .fmt 格式本身就是上古时期的产物，没有兼顾到很多字体方面的事情。比如虽然文档中给出了 XeTeX 编译时的用法（使用 `xetex` 引擎和 `&xelatex` 参数），然而实际运行时总是会出现 `! Can't \dump a format with native fonts or font-mappings.` 的错误。所以不建议在预编译时使用 XeTeX 引擎。
- 虽然 `ctex` 这样处理 CJK 字符的宏包还能用，也可以使用 `\kaishu` 和 `\lishu` 这样的宏，但是相关的 CJK 字体并不是无级缩放的，也就是放大到一定程度之后会出现锯齿。此外，`\setCJKmainfont` 这类更加复杂的宏也是无法使用的。
- 如果需要频繁修改序言区，那么可以先不预编译，以节省时间（虽然预编译也没有多花多少时间）。等到序言区的内容基本固定，只需要一次预编译，之后就可以只运行 `pdflatex -shell-escape "&hello" hello.tex` 这一条编译命令了。
- 输出最后的成品时，还是建议直接使用 `pdflatex hello.tex` 或者 `xelatex hello.tex`，以消除预编译导致的一些格式和字体上的差异。

如果你用的编辑器是 Sublime，还可以自己写一个 Build System 的脚本，将预编译这个选项加进去，这样就不用每次都切到命令行界面运行了。

我自己用的配置如下，供有需要的人参考：

`mylatex.sublime-build`：

```
{
    "selector": "text.tex",
    "variants":
    [
        {   "name": "pdflatex - precompile + batchmode + .fmt",
            "shell_cmd": "etex -initialize -jobname=\"$file_base_name\" \"&pdflatex\" \"mylatexformat.ltx\" $file_base_name.tex & pdflatex -shell-escape -interaction=batchmode -aux-directory=latex-temp \"&$file_base_name\" $file_base_name.tex",
        },
        {   "name": "pdflatex - batch mode + .fmt",
            "shell_cmd": "pdflatex -shell-escape -interaction=batchmode -aux-directory=latex-temp \"&$file_base_name\" $file_base_name.tex",
        },
        {   "name": "pdflatex - precompile",
            "shell_cmd": "etex -initialize -jobname=\"$file_base_name\" \"&pdflatex\" \"mylatexformat.ltx\" $file_base_name.tex",
        },
        {   "name": "pdflatex - batch mode",
            "shell_cmd": "pdflatex -shell-escape -interaction=batchmode -aux-directory=latex-temp $file_base_name.tex",
        },
        {   "name": "pdflatex - normal mode + .fmt",
            "shell_cmd": "pdflatex -shell-escape -aux-directory=latex-temp \"&$file_base_name\" $file_base_name.tex",
        },
        {   "name": "pdflatex - normal mode",
            "shell_cmd": "pdflatex -shell-escape -aux-directory=latex-temp $file_base_name.tex",
        },
        {   "name": "xelatex - normal mode",
            "shell_cmd": "xelatex -aux-directory=latex-temp $file_base_name.tex",
        },
        {   "name": "xelatex - batch mode",
            "shell_cmd": "xelatex -aux-directory=latex-temp -interaction=batchmode $file_base_name.tex",
        },
        {   "name": "lualatex - normal mode",
            "shell_cmd": "lualatex -aux-directory=latex-temp $file_base_name.tex",
        },
        {   "name": "lualatex - batch mode",
            "shell_cmd": "lualatex -aux-directory=latex-temp -interaction=batchmode $file_base_name.tex",
        },
    ]
}
```

---
### **相关资料**

我在 TeX.SE 的 [这个问题](https://tex.stackexchange.com/questions/447486/is-it-possible-to-keep-tex-initial-files-sty-cfg-def-in-memory-in-order-t) 下已经罗列了大部分加速 TeX 编译的相关问题链接：

- [Speeding up LaTeX compilation](https://tex.stackexchange.com/questions/8791/speeding-up-latex-compilation)
- [How to speed up LaTeX compilation with several TikZ pictures?](https://tex.stackexchange.com/questions/45/how-to-speed-up-latex-compilation-with-several-tikz-pictures)
- [Ultrafast PDFLaTeX with precompiling](https://tex.stackexchange.com/questions/79493/ultrafast-pdflatex-with-precompiling)
- [Externalizing tikz with precompiled preamble](https://tex.stackexchange.com/questions/292624/externalizing-tikz-with-precompiled-preamble)
- [Precompile header with xelatex](https://tex.stackexchange.com/questions/49295/precompile-header-with-xelatex)
- [How to speed up pdflatex for a very large document on MacOS X?](https://tex.stackexchange.com/questions/15604/how-to-speed-up-pdflatex-for-a-very-large-document-on-macos-x)
- [Speeding up compilation using precompiled preamble with LuaTeX](https://tex.stackexchange.com/questions/114742/speeding-up-compilation-using-precompiled-preamble-with-luatex)

以及：

- [Precompiled Preamble for LaTeX](https://web.archive.org/web/20150326041620/http://magic.aladdin.cs.cmu.edu/2007/11/02/precompiled-preamble-for-latex/)
- [LaTeX: Speed up Latex compilation by precompiling the preamble part](http://7fttallrussian.blogspot.com/2010/02/speed-up-latex-compilation.html)
- [Precompileing parts of a document other than the header](https://groups.google.com/forum/#!topic/comp.text.tex/HM-YAGyoe98)
- [Example of Using a Pre-Compiled LateX Preamble](https://bitbucket.org/johannesjh/latex-precompiled-preamble-example)
- [LaTeXDaemon](http://william.famille-blum.org/software/latexdaemon/index.html)
- [How to create a new format file](https://www.mackichan.com/index.html?techtalk/how/fmtfile.html~mainFrame)
