require "import" 
import "android.widget.*" 
import "android.view.*"
import "android.content.Intent"
import "android.net.Uri"

function showAboutDialog()
  aboutDlg=LuaDialog(activity)
  aboutDlg.setTitle("关于ALuaj-1.0.2(2019-1-21)")
  aboutDlg.setIcon(R.drawable.ic_launcher)
  aboutDlg.setMessage([[
ALuaj(以下简称"该应用")是AndroLuaJ(有着更多功能，同时也可能潜在着更多Bug)衍生出来的一个稳定版本，默认基于AndroLua+4.1.0(nirenr)。同时支持Lua和Java的编译运行。AndroLuaJ大概持续了一年多的更新。经过一年的经验沉淀，重构了一个稳定的、正式的版本,去除一切无关的元素，并引入一些新的特性，只为混合编程更纯粹。如果你会Java和Lua，并希望打包成apk，使用它是一个很不错的选择，它既继承了AndroLua+简洁的特性，又有Java语言的支持。Lua的简洁可以大大提高您的开发效率，Java的支持更给开发带来了强大的支撑。在使用前您有必要了解一下什么是AndroLua+。请阅读教程

用户协议：

1.未经开发者(mythoi)允许，禁止把该应用作为商业性交易。

2.禁止使用该应用编写病毒、木马、恶意程序等损害他人。

3.开发者(mythoi)不对使用该应用者直接或间接造成自己或他人的损失负责

若您继续使用该应用默认您已知晓并同意以上协议。

与AndroLuaJ混合工程的不同:

1.去除lua文件中插入java代码的功能

2.init.lua新增compiles={}，使用它来依赖第三方支持包

3.androlua默认环境为AndroLua+4.1.0

4.android.jar里包含androlua的编译环境

5.工程路径改为/storage/emulated/0/ALuaj/

6.环境路径改为/storage/emulated/0/.alj/

开发的动力来自于您的支持，如果您喜欢ALuaj，并希望它发展下去。您可以向您的好友分享该应用，或者捐赠我。
]])

  aboutDlg.setPositiveButton("捐赠",DialogInterface.OnClickListener{
    onClick=function(v) 
      activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("alipayqr://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https%3A%2F%2Fqr.alipay.com%2FFKX011243FFHRIALICYN2D%3F_s%3Dweb-other")))
    end
  })
  aboutDlg.setNeutralButton("加入交流群",DialogInterface.OnClickListener{
    onClick=function(v)
      url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin=551480248&card_type=group&source=qrcode"
      activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
    end
  })
  aboutDlg.setNegativeButton("关于AndroLuaJ",DialogInterface.OnClickListener{
    onClick=function(v)
      url="http://www.occhao.cc/AndroLuaJ/"
      viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
      activity.startActivity(viewIntent)
    end
  }) 
  aboutDlg.show()
end