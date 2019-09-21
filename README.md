# ALuaJ
该项目是<a href="http://www.occhao.cc/AndroLuaJ/">AndroLuaJ</a>的另一个简洁版，是通过<a href="http://www.occhao.cc/AndroLuaJ/">AndroLuaJ</a>自举构建出来的一个项目，它是移动端IDE，支持lua和java编译运行，支持打包生成apk文件直接在安卓端运行

### 简介
该应用是安卓端目前还算完善的IDE，同时支持多种语言编译与运行， 真正实现了多语言快速封装apk。应用集成了java环境、Lua环境，不管你会哪个都可以快速封装成安卓应用，如果Java和Lua都会那就更好了，java和lua混合开发是该应用的最大特色。其他：齐全的开发教程，详尽的开发文档，代码自动补全，代码高亮，可视化布局.....在手机端轻松设计出属于自己的APP，效果堪比PC端的eclipse，完美兼容eclipse的安卓项目

### 详细介绍

ALuaJ集成JAVA环境、Lua环境，支持java、lua、编译运行，它可以在手机端快速打包apk。

使用富有生命力的Lua语言和原生的java语言进行Android编程。 

--如果你会Lua语言，你可在手机上用极为简洁灵活的Lua语言调用AndroidApi与JavaApi编写出轻量的安卓程序。 

##### -[动态·热更新] 

Lua属于脚本语言无需编译，直接运行程序。也就意味着给安卓添加了动态性，热更新更便捷 

##### -[灵活·高效] 

简练自由的语法，你可自由的探索出最适合自己的写代码手法。 

##### -[扩展] 

它支持导入第三方类库，你甚至可以从宿主层面对它进行定制。 

--如果你会java语言，你可以在手机上用安卓原生支持的java进行打包安卓原生程序。 

##### -[多版本选择] 

支持java1.3，java1.4，java1.5，java1.6，java1.7

##### -[原生·干净·包小] 

因为使用了java，打包生成的apk轻,小,干净。空工程打包仅34KB。 

--如果Lua和Java你都会那就更好了，你照样可以同时使用Lua和JAVA打包安卓程序 

##### -[变态的编程方式] 

lua文件中允许插入java类，java方法，java接口... 

##### -[多种方式布局] 

支持xml布局和nirenr的aly布局 

内含libGDX游戏框架，喜欢开发游戏的也可以尝试一下 

##### -特色： 

可视化布局、代码自动补全、代码高亮、强大的LogCat过滤、自动导包、齐全的开发教程、详尽的开发文档...... 

AndroLuaJ手机端编程，想你所想，做你想做

AndroLuaJ官方交流群551480248

<a href="http://androluaj.mythoi.cn">AndroLuaJ官方论坛</a>

### 构建此项目
使用<a href="http://www.occhao.cc/AndroLuaJ/">AndroLuaJ</a>构建该项目，有开发经验的也可以用pc端的工具进行构建
* 克隆此项目到手机
* 手机端安装<a href="http://www.occhao.cc/AndroLuaJ/">AndroLuaJ</a>
* 在手机上使用<a href="http://www.occhao.cc/AndroLuaJ/">AndroLuaJ</a>进行构建此项目（ALuaJ）

### AndroLuaJ和ALuaJ的区别
* <a href="http://www.occhao.cc/AndroLuaJ/">AndroLuaJ官网</a>
* <a href="https://www.aluaj.tk/">ALuaJ官网</a>
* 这两个项目都是安卓端的IDE，可以在安卓手机上写代码，然后编译打包apk运行。ALuaj是AndroLuaJ(有着更多功能，同时也可能潜在着更多Bug)衍生出来的一个稳定版本，默认基于AndroLua+4.1.0(nirenr)。AndroLuaJ支持ndk开发，而ALuaJ不支持。目前AndroLuaJ没有开源
ALuaJ与AndroLuaJ混合工程的不同:
1.去除lua文件中插入java代码的功能
2.init.lua新增compiles={}，使用它来依赖第三方支持包
3.androlua默认环境为AndroLua+4.1.0
4.android.jar里包含androlua的编译环境
5.工程路径改为/storage/emulated/0/ALuaj/
6.环境路径改为/storage/emulated/0/.alj/
开发的动力来自于您的支持，如果您喜欢ALuaj，并希望它发展下去。您可以向您的好友分享该应用，或者捐赠我。
