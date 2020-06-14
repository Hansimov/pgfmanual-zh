# [LaTeX 绘图指南 - 001] TikZ 的简介、资源以及学习方法

我本来这个系列是想起名叫 [TeX 绘图指南] 的，不过考虑到很多人搜索的时候习惯用 "LaTeX" 而不是 "TeX"，所以我就像现在这样命名了。

## **TikZ 能干啥**

TikZ 是 LaTeX 下的一个（著名的）绘图宏包。那么 TikZ 能干啥呢？

废话少说，直接上图：

流程图：

![Diagram of Android activity life cycle](http://www.texample.net/media/tikz/examples/PNG/android.png)

脑图：

![A mindmap showing TeX projects supported by DANTE e.V.](http://www.texample.net/media/tikz/examples/PNG/servers.png)

类图：

![Class diagram](http://www.texample.net/media/tikz/examples/PNG/class-diagram.png)

函数图像：

![GNUPLOT basics](http://www.texample.net/media/tikz/examples/PNG/gnuplot-basics.png)

完全图：

![A complete graph](http://www.texample.net/media/tikz/examples/PNG/complete-graph.png)

**如果你以为这就是 TikZ 的极限了，那么请继续往下翻……**

分形：

![Lindenmayer systems](http://www.texample.net/media/tikz/examples/PNG/lindenmayer-systems.png)

晶体管电路：

![18W MOSFET amplifier with npn transistor](http://www.texample.net/media/tikz/examples/PNG/mosfet.png)

滤波器模型：

![Digital Signal Processing Library](http://www.texample.net/media/tikz/examples/PNG/fir-filter.png)

RNA 密码子表：

![RNA codons table](http://www.texample.net/media/tikz/examples/PNG/rna-codons-table.png)

化学元素周期表：

![Periodic Table of Chemical Elements](http://www.texample.net/media/tikz/examples/PNG/periodic-table-of-chemical-elements.png)

聚焦离子束系统原理图：

![Focused ion beam system](http://www.texample.net/media/tikz/examples/PNG/focused-ion-beam-system.png)


……

如果你觉得还没看过瘾的话，可以到 [TikZ and PGF examples](http://www.texample.net/tikz/examples/all/) 继续欣赏。

这么说吧，绝大多数**能够精确描述的矢量图**，理论上都可以用 TikZ 画出来。

（PS：我以前写过一篇（还没有写完的）文章，详细对比了不同作图工具的优劣，以及适用场景，见： [常见绘图工具的对比](https://github.com/Hansimov/tikzpy/blob/master/doc/comparisons%20of%20tools.md)）


## **TikZ 的名字由来**

TikZ 的德文原文是 TikZ ist kein Zeichenprogramm， 这是一个 "GNU's Not Unix!" 式的递归缩写。（是的，无聊的程序员们就是很喜欢这种文字游戏。）

翻译成英文就是 TikZ is not a drawing program，中文意思是“TikZ 不是一个绘图程序”。（程序员式冷幽默）

我在 [PGF/TikZ 中文手册](https://github.com/Hansimov/pgfmanual-zh) 里将其译作“**绘何物为**”，用了拼音的递归：Huì hé wù wéi。意即“‘绘’是什么呢”，当然也可以将“绘”直接作为动词，理解成“绘制什么呢”。这样中文含义就和原文含义形成一问一答，无论是形式上还是内容上，都有了合理的对应。

当然，这里夹杂了我的私货，正文中依旧使用 TikZ 来指代这一绘图系统。

---

## **Till Tantau 其人**

TikZ 宏包的作者叫 Till Tantau，1975 年出生，现年 43 岁，在德国吕贝克大学理论计算机科学学院当教授。

TikZ 又叫 PGF/TikZ 宏包，这是因为 TikZ 发端于 PGF（Portable Graphics Format，便携式/可移植图形格式）。是的，形式上借鉴了 PDF（Portable Document Format，便携式/可移植文档格式）。

实际上，TikZ 只是 PGF 的一个前端，任何人（闲得慌的话）都可以基于 PGF 写一套自己的前端。

那时候 Till Tantau 还很年轻，他想给自己的博士论文配点图，所以写了一些简单的宏。结果写着写着就收不住了，于是就变成了今天这样一个庞大的宏包，并且形成了一套系统的图形语言。这个宏包 2003 年上传到 CTAN 的时候，就叫 PGF。

你说我一个 LaTeX 的宏包，怎么就变成一套图形语言了？

除了 PGF/TikZ 之外，Till Tantau 还写了另一个宏包，叫 Beamer，相当于 LaTeX 界的 PPT。

Till Tantau 这人是个文档狂魔……

我第一次接触 Beamer 宏包的文档时，一看有 200 多页，人都傻了。毕竟我那时候没见过世面，一般宏包的文档大概也就几十页，看过的页数最多的是 ctex 宏包文档，也不过是 100 多页（然后只有前30多页是面向用户的，后面的100多页全是代码实现……）。

直到我后来看到 1000 多页的 TikZ 宏包文档……

所以我现在见到其他几十上百页的宏包文档，内心已经没有任何波动了。

---

## **PGF/TikZ 相关的学习资源**

PGF/TikZ 相关的学习资源很多，可以参考这个项目：[xiaohanyu/awesome-tikz](https://github.com/xiaohanyu/awesome-tikz)。

基本列出了常见的高质资源，语言大多为英文。

中文资源相对零碎，社区用户也不够活跃，资源比较集中的地方有：

* [Tikz&pgf - LaTeX 工作室](http://www.latexstudio.net/archives/category/tex-graphics/tikz-example)：这里有不少基础教程、学习笔记和实用样例，质量也不错

* [CTEX 社区 - tikz/pgf 等 TeX 绘图宏包](http://bbs.ctex.org/forum.php?mod=forumdisplay&fid=51&filter=typeid&typeid=26)：如今已是死气沉沉，在质量上也明显不如上一个

**如果你英文较好，或者对 PGF/TikZ 已经有了一定了解，建议还是参考英文资源，并且善用搜索引擎（Google Is Your Friend），选择合适的英文关键词。**

自然，我也在翻译 PGF/TikZ 的英文文档，项目地址在：[Hansimov/pgfmanual-zh](https://github.com/Hansimov/pgfmanual-zh)。目前还在早期阶段。


不过，如果你刚接触这个宏包，或者更愿意阅读中文教程，不用担心，这个系列专栏就是为你准备的。希望你能从中获得知识和乐趣。

TeX 社区是非常欢迎新人的。毕竟在 Word 一统江湖的情况下，TeX 党要团结一切可以团结的力量。

“总而言之，要团结一切可以团结的 TeX 用户，这样，我们就可以把 Word 派缩小到最少，只剩下 Markdown 主义和少数亲 Markdown 主义的分子，即同 Markdown 主义有密切联系的程序员和博客作者。对我们来说，朋友越多越好，Word 派越少越好。”（摘自 Hans《我们要坚持 TeX 主义一百年不动摇》）

---

## **怎么用好这些学习资源**

虽然 [xiaohanyu/awesome-tikz](https://github.com/xiaohanyu/awesome-tikz) 里面列出的链接非常详尽，不过我知道你们是懒得点进去看的。

资源在精不在多，所以我就提炼一下，选取比较重要的几个说一说：

* 英文文档：[pgfmanual](http://mirrors.ctan.org/graphics/pgf/base/doc/pgfmanual.pdf)
<!-- * 半小时入门：[A very minimal introduction to TikZ](http://cremeronline.com/LaTeX/minimaltikz.pdf) -->

* 命令大全：[VisualTikZ](http://mirrors.ctan.org/info/visualtikz/VisualTikZ.pdf)

* 各种样例：[TikZ and PGF examples](http://www.texample.net/tikz/examples/all/)

* TeX 社区：[Questions tagged [tikz-pgf]](https://tex.stackexchange.com/questions/tagged/tikz-pgf)

关于这些资源该怎么用，其实不同人需求不同，背景知识和学习能力也有差别，因此没有适用于所有人的方法。

**最重要的是兴趣。**比如我是手残党，画画写字都不行，所以非常依赖计算机帮我排版优美的文档和图表，因此在这方面的兴趣就非常浓厚，钻研得自然也就相对多一点。（我也想像那些大触一样，手绘各种好看的作品啊……）

**首先，如果能吃透近 1200 页的英文文档，我想你大概就神功大成（身败头秃）了。**Till Tantau 写的文档真的是深入浅出、巨细靡遗，我每次看都自叹弗如、望尘莫及。看文档当然不仅仅要看内容，还得看他是怎么组织的，而且有时候在文档的源代码里，也能学到各种眼前一亮的 LaTeX 技巧。当然，这个文档也可以当成字典来用，实用中碰到想不起来的，直接到文档的对应位置查阅即可。

除了 Till Tantau 写的文档之外，还有一个列在 CTAN 上的 PGF/TikZ 文档：[A very minimal introduction to TikZ](http://cremeronline.com/LaTeX/minimaltikz.pdf)，能让你了解一下基本的命令，大概半小时就能读完。不过个人感觉这个文档并不出色，初学者看完发现自己顶多画个圆，可是教练我想画的明明是上面你列举的那些牛逼闪闪的图啊。然而既然 CTAN 上把这个文档列出来了，我也只好提一下以示尊重。

**其次，[TeXample]((http://www.texample.net/tikz/examples/all/)) 上的各种样例值得反复观摩。**“凡操千曲而后晓声，观千剑而后识器；故圆照之象，务先博观”。一个是看 TikZ 能做到什么程度，二个是看那些大牛是怎么做到的。源码下载下来，先看看它画了啥，再跑一下看能不能跑通，然后再改一改，看看不同地方是做什么的，最后再试试能不能自己也画一个类似的。这跟书法和绘画中的临摹是一个道理。

**然后，是 [VisualTikZ](http://mirrors.ctan.org/info/visualtikz/VisualTikZ.pdf)。**它类似一个 cheatsheat，也就是命令清单，罗列了各种命令的各种用法和细节，比 Till Tantau 的文档更像一本字典。大概记得什么命令在文档的什么位置就好了。

**再者，是 TeX 社区上带有 tikz-pgf 标签的问题：[Questions tagged [tikz-pgf]](https://tex.stackexchange.com/questions/tagged/tikz-pgf)。**目前这个 tag 下已经累计超过 2 万个问题了，也就是说，作为初学者，你碰到的绝大多数问题一定有人已经碰到过、并且解决掉了。如果你谷歌自己的问题，发现第一个弹出来的是 TeX - LaTeX Stack Exchange 或者简称 TeX.SX 里的链接，那么你的问题有九成的概率可以解决了。

顺便一提，没事可以浏览一些 Votes （投票）比较高的提问，因为这些是最常见的问题，也就意味着你碰见它们的概率也最高。然后 TeX.SX 里有好多大佬喜欢在问题的评论区回答，而不是直接写成答案，所以这些评论也是有必要都过一遍的。

**另外，就是善用搜索引擎。**真的，利人利己。这已经是老生常谈了。

当然，如果你确实没有搜到某个问题的答案，那么有两种可能：一是你没有搜索合适的关键词（九成概率），二是确实没人问过这个问题（一成概率）。这时不用顾虑和害羞，直接在 TeX.SX 上提问。一般情况下已经有类似问题了，这时会有大佬告诉你，你这个已经 duplicated （重复）了，然后甩给你一个链接，这时只要乖乖地点到对应链接学习就好了。如果真的没人碰到过这个问题，而且半天也没人回答，那么反思一下，这个问题是否是真实或合理的需求，对于这种非常边缘和比较个人的问题，要么把它扔在一旁，要么尝试自己动手解决。

关于如何提问，这里有一篇 [提问的智慧](https://github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way/blob/master/README-zh_CN.md)，当然各种地方你都能搜到这篇贴子及其变种。

**最后，想要进阶的话，功夫就在 TikZ 之外了。**除了熟练使用各种绘图命令以外，还得清楚一些 TeX 的底层原理，要涉猎排版和设计领域的知识。这不但是个体力活，也是个技术活，更是个艺术活。我目前还没有修炼到这层境界，自然也就不敢给出建议，期待有大佬能够指点一二。

---

不知道多少人能看到这里，毕竟通篇都没有写这个宏包该怎么用。Talk is cheap, show me the code，教练，你整这么多虚的没用，最起码给个能跑的例子啊。

怎么说呢，“臣之所好者，道也，进乎技矣”。哈哈没有啦，我们下一篇就讲，别急。

我想，最终能用好并且喜欢上 TikZ 的人，应该也不会在乎这一两篇的工夫。
