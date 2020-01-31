## IOS Swift 入门大作业

> 前言：这个是作者闲来无事做的一个大作业，没有用到很高深的技术，虽然做 IOS 开发会接触到很多MVVM、RxSwift之类的优秀框架，但这个项目暂时不打算做那么高深，对于初学者来说也不会很友好。
> 
> 如果你想要一个小项目练练手、或者只是想要了解一下 IOS 开发、甚至是为了应付课堂作业，我相信这个项目都会给你带来很大的帮助。
> 
> 因为它是现成可运行的程序，不需要后台，即下即用。为了方便一些不是专门从事 IOS 开发的同学，我没有使用 CocoaPods 这个第三方库管理工具（类似于Maven、Gradle），因为...安装一次实在太麻烦了。所有的第三方库都已经下载到工程里，放心用。我自己都感觉很贴心了！！！
> 
> 如果你打算继续走 IOS 开发的路，请关注我之后的更新，很不幸，我的毕业设计也选择了 IOS 相关的课题，相信不久之后会有新的更高阶开源项目带给大家。
> 
> 语言版本：Swift 4.0及以上、IOS 12

### I 功能概要

有图有真相，我当然希望能为这个大作业添加所有流行App都具有的功能，无奈个人力量实在不足，所以我挑了一些比较典型的功能和UI设计进行实现，功能涵盖了最基本的用户登录注册，到比较核心的选购图书，次要的地址管理、搜索，以及比较偏门的主题切换等。
<p>
    <img src="img/演示图片1.gif" alt="Sample"  width="250" height="500"/>
</p>

### II 技术概要

前面就说了，技术并不会很高深，都是一些基础的实现，核心就是页面跳转（转场）、View布局，由于没有后台，数据处理/异步编程 也无从谈起。数据都是本地保存，甚至有部分数据是写死的，代码中注释很清晰。

下面介绍一下这个项目用到的一些 View 或者特效：

- 图片轮播器：APP的主页设置了一个图片轮播器，实时滚动播放一些图片。详细实现请查看代码。
- 特效输入框：在登录、注册页面的输入框采用了提示词上浮的特效，当用户点击输入框时，placeholder提示词会自动上浮，若用户结束输入时输入框内文本为空，提示词自动下降。详细实现请查看代码。
- 下拉框/下拉列表：Swift本身是不提供下拉框的，所以我基于TableView实现了一个。[这里](https://blog.csdn.net/Xu_JL1997/article/details/103951298)有对它的一些介绍。
- 瀑布流布局：在“圈子”一栏使用了瀑布流布局。详细实现请查看代码。
- 视频播放：在“圈子”一栏使用了视频播放器AVPlayer。详细实现请查看代码。
- HTML5：首页的图片轮播器点击后进入的页面是HTML编写的。详细实现请查看代码。
- SwiftTheme：这是现下使用最广泛的一个换肤框架，代码入侵低。详细实现请查看代码。
- 毛玻璃效果：在新增/编辑地址时，表单背景模糊处理。详细实现请查看代码。

### III 目录结构

主要说明一下 bookshop 文件夹下各个目录的划分。

- */src*：各个页面主要的代码都保存在这里，以页面名称命名
- */src/common*：一些公用的方法和类，比如User、Book这些实体类，以及以Util结尾的工具类。
- */src/home*：主页（底部第一栏）
- */src/circle*：圈子（第二栏）
- */src/shoppingcar*：购物车（第三栏）
- */src/user*：个人中心（第四栏）

### IV 其他

Config.swift 文件有一些作者信息，使用时注意修改。

项目中引入的其他项目代码均已注明出处，侵权请联系本人删除。

如果我的项目帮助到你，欢迎留下你的star，如果有疑惑或者改进，欢迎提issue或者邮件联系我。

###### Copyright © 2019 - 2020 许家乐
