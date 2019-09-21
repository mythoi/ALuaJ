require "import"
import"function.config"
updateTheme()
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.net.*"
import "android.content.*"
import "luahelper.help"

helpStr=[===[
@打印@
@print"Hello World！"
print("Hello World")@

@注释@
@单行注释  --
多行注释  --[[]]@

@字符串@
@a="String"
a=[[String]]@


@赋值@
@a="Hello World"

--lua支持多重赋值
a,b="String a","String b"

--交换值
a,b="String a","String b"
a,b=b,a@




@类型简介@
@Lua 存在的数据类型包括:
1.nil
此类型只有一个值 nil。用于表示“空”值。全局变量默认为 nil，删除一个已经赋值的全局变量只需要将其赋值为 nil（对比 JavaScript，赋值 null 并不能完全删除对象的属性，属性还存在，值为 null）

2.boolean
此类型有两个值 true 和 false。在 Lua 中，false 和 nil 都表示条件假，其他值都表示条件真（区别于 C/C++ 等语言的是，0 是真）


3.number
双精浮点数（IEEE 754 标准），Lua 没有整数类型

4.string
你可以保存任意的二进制数据到字符串中（包括 0）。字符串中的字符是不可以改变的（需要改变时，你只能创建一个新的字符串）。获取字符串的长度，可以使用 # 操作符（长度操作符）。例如：print(#”hello”)。字符串可以使用单引号，也可以使用双引号包裹，对于多行的字符串还可以使用 [[ 和 ]] 包裹。字符串中可以使用转义字符，例如 \n \r 等。使用 [[ 和 ]] 包裹的字符串中的转义字符不会被转义

5.userdata
用于保存任意的 C 数据。userdata 只能支持赋值操作和比较测试

6.function
函数是第一类值（first-class value），我们能够像使用其他变量一样的使用函数（函数能够保存在变量中，可以作为参数传递给函数）

7.thread
区别于我们常常说的系统级线程

8.table
被实现为关联数组（associative arrays），可以通过任何值来进行索引（nil 除外）。和全局变量一样，table 中未赋值的域为 nil，删除一个域只需要将其赋值为 nil（实际上，全局变量就是被放置在一个 table 中）



type 函数用于返回值的类型：
print(type("Hello World")) --> string
print(type(10.4*3))        --> number
print(type(print))         --> function
print(type(type(X)))       --> string@









@Table(数组)@
@table是lua唯一的数据结构。
table是lua中最重要的数据类型。 
table类似于 python 中的字典。
table只能通过构造式来创建。其他语言提供的其他数据结构如array、list等等，lua都是通过table来实现的。
table非常实用，可以用在不同的情景下。最常用的方式就是把table当成其他语言的数组。

实例1:
mytable = {}
for index = 1, 100 do
    mytable[index] = math.random(1,1000)
end

说明：
1.数组不必事先定义大小，可动态增长。
2.创建包含100个元素的table，每个元素随机赋1-1000之间的值。
3.可以通过mytable[x]访问任意元素，x表示索引。
4.索引从1开始。

实例2:
tab = { a = 10, b = 20, c = 30, d = 'www.jb51.net' }
print(tab["a"]) 

说明：
1.table 中的每项要求是 key = value 的形式。
2.key 只能是字符串， 这里的 a, b, c, d 都是字符串，但是不能加上引号。
3.通过 key 来访问 table 的值，这时候， a 必须加上引号。

实例3:
tab = { 10, s = 'abc', 11, 12, 13 } 
print(tab[1]) = 10
print(tab[2]) = 11
print(tab[3]) = 12
print(tab[4]) = 13
说明：
1.数标从1开始。
2.省略key，会自动以1开始编号，并跳过设置过的key。@



@比较操作符@
@--Lua 支持下列比较操作符：

==: 等于
~=: 不等于
<: 小于
>: 大于
<=: 小于等于
>=: 大于等于
这些操作的结果不是 false就是 true。@




@For循环@
@--给定条件进行循环

--输出从1到10
for i=1,10 do
print(i)
end


--输出从10到1
for i=10,1,-1 do
print(i)
end

--打印数组a中所有的值
a={"a","b","c","d"}
for index,content in pairs(a) do
print(content)
end@


@While循环@
@--只要条件为真便会一直循环下去

--输出1到10
a=0
while a~=10 do
a=a+1
print(a)
end

--输出10到1
a=11
while a~=1 do
a=a-1
print(a)
end

--打印数组a中的所有值
shuzu={"a","b","c","d"}
a=0
while a~=#shuzu do
a=a+1
print(shuzu[a])
end@



@if(判断语句)@
@--判断值是否为真
a=true
if a then
print("真")
else
print("假")
end

--比较值是否相同
a=true
b=false
if a==b then
print("真")
else
print("假")
end@


@function(函数)@
@函数有两个用途
1.完成指定功能，函数作为调用语句使用
2.计算并返回值，函数作为赋值语句的表达式使用


实例1:
function 读取文件(路径)
文件内容=io.open(路径):read("*a")
return 文件内容--return用来返回值
end



实例2:
require "import"
import "android.widget.EditText"
import "android.widget.LinearLayout"
function 编辑框()
return EditText(activity)
end
layout={
  LinearLayout;
  id="父布局",
  {编辑框,
    id="edit",
    text="文本",
   },
};
activity.setContentView(loadlayout(layout))
--把这段代码放到调试里面去测试@


@基础代码@
@activity.setTitle('Title')--设置窗口标题
activity.setContentView(loadlayout(layout))--设置窗口视图
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)--设置主题
activity.getWidth()--获取屏幕宽
activity.getHeight()--获取屏幕高
activity.newActivity("main")--跳转页面
activity.finish()--关闭当前页面
activity.recreate()--重构activity
os.exit()--结束程序
tostring()--转换字符串
tonumber()--转换数字
tointeger()--转换整数
--线程
--thread
thread(function()print"线程"end)
--task
task(function()print"线程"end)@


文件相关代码

@创建新文件@
@--使用File类
import "java.io.File"--导入File类
File(文件路径).createNewFile()

--使用io库
io.open("/sdcard/aaaa", 'w')@

@创建新文件夹@
@--使用File类
import "java.io.File"--导入File类
File(文件夹路径).mkdir()

--创建多级文件夹
File(文件夹路径).mkdirs()

--shell
os.execute('mkdir '..文件夹路径)@

@重命名与移动文件@
@--Shell
os.execute("mv "..oldname.." "..newname)

--os
os.rename (oldname, newname)

--File
import "java.io.File"--导入File类
File(旧).renameTo(File(新))@


@追加更新文件@
@io.open(文件路径,"a+"):write("更新的内容"):close()@



@更新文件@
@io.open(文件路径,"w+"):write("更新的内容"):close()@

@写入文件@
@io.open(文件路径,"w"):write("内容"):close()@

@写入文件(自动创建父文件夹)@
@function 写入文件(路径,内容)
  import "java.io.File"
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end@



@读取文件@
@io.open(文件路径):read("*a")@



@按行读取文件@
@for c in io.lines(文件路径) do
print(c)
end@



@删除文件或文件夹@
@--使用File类
import "java.io.File"--导入File类
File(文件路径).delete()
--使用os方法
os.remove (filename)@


@复制文件@
@LuaUtil.copyDir(from,to)@




@递归删除文件夹或文件@
@--使用LuaUtil辅助库
LuaUtil.rmDir(路径)

--使用Shell
os.execute("rm -r "..路径)@


@替换文件内字符串@
@function 替换文件字符串(路径,要替换的字符串,替换成的字符串)
if 路径 then
  路径=tostring(路径)
  内容=io.open(路径):read("*a")
  io.open(路径,"w+"):write(tostring(内容:gsub(要替换的字符串,替换成的字符串))):close()
else
return false
end
end@
@获取文件列表@
@import("java.io.File")
luajava.astable(File(文件夹路径).listFiles())@


@获取文件名称@
@import "java.io.File"--导入File类
File(路径).getName()@

@获取文件大小@
@function GetFileSize(path)
  import "java.io.File"
  import "android.text.format.Formatter"
  size=File(tostring(path)).length()
  Sizes=Formatter.formatFileSize(activity, size)
  return Sizes
end@


@获取文件或文件夹最后修改时间@
@function GetFilelastTime(path)
  f = File(path); 
  cal = Calendar.getInstance();
  time = f.lastModified()
  cal.setTimeInMillis(time); 
  return cal.getTime().toLocaleString()
end@


@获取文件字节@
@import "java.io.File"--导入File类
File(路径).length()@


@获取文件父文件夹路径@
@import "java.io.File"--导入File类
File(path).getParentFile()@

@获取文件Mime类型@
@function GetFileMime(name)
import "android.webkit.MimeTypeMap"
ExtensionName=tostring(name):match("%.(.+)")
Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
return tostring(Mime)
end
print(GetFileMime("/sdcard/a.png"))@


@判断路径是不是文件夹@
@import "java.io.File"--导入File类
File(路径).isDirectory()
--也可用来判断文件夹存不存在@



@判断路径是不是文件@
@import "java.io.File"--导入File类
File(路径).isFile()
--也可用来判断文件存不存在@


@判断文件或文件夹存不存在@
@import "java.io.File"--导入File类
File(路径).exists()

--使用io
function file_exists(path)
local f=io.open(path,'r')
if f~=nil then io.close(f) return true else return false end
end@



@判断是不是系统隐藏文件@
@import "java.io.File"--导入File类
File(路径).isHidden()@


intent类相关代码

@Intent类介绍@
@Intent（意图）主要是解决Android应用的各项组件之间的通讯。
Intent负责对应用中一次操作的动作、动作涉及数据、附加数据进行描述.
Android则根据此Intent的描述，负责找到对应的组件，将 Intent传递给调用的组件，并完成组件的调用。

因此，Intent在这里起着一个媒体中介的作用
专门提供组件互相调用的相关信息
实现调用者与被调用者之间的解耦。

例如，在一个联系人维护的应用中，当我们在一个联系人列表屏幕(假设对应的Activity为listActivity)上
点击某个联系人后，希望能够跳出此联系人的详细信息屏幕(假设对应的Activity为detailActivity)
为了实现这个目的，listActivity需要构造一个 Intent
这个Intent用于告诉系统，我们要做“查看”动作，此动作对应的查看对象是“某联系人”
然后调用startActivity (Intent intent)，将构造的Intent传入

系统会根据此Intent中的描述到ManiFest中找到满足此Intent要求的Activity，系统会调用找到的 Activity，即为detailActivity，最终传入Intent，detailActivity则会根据此Intent中的描述，执行相应的操作。@


@调用浏览器搜索关键字@
@import "android.content.Intent"
import "android.app.SearchManager"
intent =  Intent()
intent.setAction(Intent.ACTION_WEB_SEARCH)
intent.putExtra(SearchManager.QUERY,"Alua开发手册")    
activity.startActivity(intent)@


@调用浏览器打开网页@
@import "android.content.Intent"
import "android.net.Uri"
url="http://www.androlua.cn"
viewIntent =  Intent("android.intent.action.VIEW",Uri.parse(url))
activity.startActivity(viewIntent)@




@打开其它程序@
@packageName=程序包名
import "android.content.Intent"
import "android.content.pm.PackageManager"
manager = activity.getPackageManager()
open = manager.getLaunchIntentForPackage(packageName)
this.startActivity(open)@


@安装其它程序@
@import "android.content.Intent"
import "android.net.Uri"
intent = Intent(Intent.ACTION_VIEW)
安装包路径="/sdcard/a.apk"
intent.setDataAndType(Uri.parse("file://"..安装包路径), "application/vnd.android.package-archive") 
intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
activity.startActivity(intent)@


@卸载其它程序@
@import "android.net.Uri"
import "android.content.Intent"
包名="com.huluxia.gametools"
uri = Uri.parse("package:"..包名)
intent =  Intent(Intent.ACTION_DELETE,uri)
activity.startActivity(intent)@

@播放Mp4@
@import "android.content.Intent"
import "android.net.Uri"
intent =  Intent(Intent.ACTION_VIEW)
uri = Uri.parse("file:///sdcard/a.mp4") 
intent.setDataAndType(uri, "video/mp4")
activity.startActivity(intent)@

@播放Mp3@
@import "android.content.Intent"
import "android.net.Uri"
intent =  Intent(Intent.ACTION_VIEW)
uri = Uri.parse("file:///sdcard/song.mp3")
intent.setDataAndType(uri, "audio/mp3")
this.startActivity(intent)@

@搜索应用@
@import "android.content.Intent"
import "android.net.Uri"
intent = Intent("android.intent.action.VIEW")
intent .setData(Uri.parse( "market://details?id="..activity.getPackageName()))
this.startActivity(intent)@


@调用系统设置@
@import "android.content.Intent"
import "android.provider.Settings"
intent = Intent(android.provider.Settings.ACTION_SETTINGS)
this.startActivity(intent)

字段列表:
ACTION_SETTINGS	系统设置
CTION_APN_SETTINGS APN设置
ACTION_LOCATION_SOURCE_SETTINGS 位置和访问信息
ACTION_WIRELESS_SETTINGS 网络设置
ACTION_AIRPLANE_MODE_SETTINGS 无线和网络热点设置
ACTION_SECURITY_SETTINGS 位置和安全设置
ACTION_WIFI_SETTINGS 无线网WIFI设置
ACTION_WIFI_IP_SETTINGS 无线网IP设置
ACTION_BLUETOOTH_SETTINGS 蓝牙设置
ACTION_DATE_SETTINGS 时间和日期设置
ACTION_SOUND_SETTINGS 声音设置
ACTION_DISPLAY_SETTINGS 显示设置——字体大小等
ACTION_LOCALE_SETTINGS 语言设置
ACTION_INPUT_METHOD_SETTINGS 输入法设置
ACTION_USER_DICTIONARY_SETTINGS 用户词典
ACTION_APPLICATION_SETTINGS 应用程序设置
ACTION_APPLICATION_DEVELOPMENT_SETTINGS 应用程序设置
ACTION_QUICK_LAUNCH_SETTINGS 快速启动设置
ACTION_MANAGE_APPLICATIONS_SETTINGS 已下载（安装）软件列表
ACTION_SYNC_SETTINGS 应用程序数据同步设置
ACTION_NETWORK_OPERATOR_SETTINGS 可用网络搜索
ACTION_DATA_ROAMING_SETTINGS 移动网络设置
ACTION_INTERNAL_STORAGE_SETTINGS 手机存储设置
@


@调用系统打开文件@
@function OpenFile(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  if Mime then 
    intent = Intent()
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    intent.setAction(Intent.ACTION_VIEW); 
    intent.setDataAndType(Uri.fromFile(File(path)), Mime); 
    activity.startActivity(intent)
return true
  else
    return false
  end
end
OpenFile(文件路径)@


@调用图库选择图片@
@import "android.content.Intent"
  local intent= Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent, 1)
-------

--回调
function onActivityResult(requestCode,resultCode,intent)
  if intent then
    local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
    cursor.moveToFirst()
import "android.provider.MediaStore"
    local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
    fileSrc = cursor.getString(idx)
    bit=nil
    --fileSrc回调路径路径
import "android.graphics.BitmapFactory"
    bit =BitmapFactory.decodeFile(fileSrc)
  --  iv.setImageBitmap(bit)
  end
end--nirenr@

@调用文件管理器选择文件@
@function ChooseFile()
import "android.content.Intent"
import "android.net.Uri"
import "java.net.URLDecoder"
import "java.io.File"
intent = Intent(Intent.ACTION_GET_CONTENT)
intent.setType("*/");
intent.addCategory(Intent.CATEGORY_OPENABLE)
activity.startActivityForResult(intent,1);
function onActivityResult(requestCode,resultCode,data)
  if resultCode == Activity.RESULT_OK then
  local str = data.getData().toString()
  local decodeStr = URLDecoder.decode(str,"UTF-8")
  print(decodeStr)
  end
end
end

ChooseFile()@


@分享文件@
@function Sharing(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  intent = Intent()
  intent.setAction(Intent.ACTION_SEND)
  intent.setType(Mime)
  file = File(path)
  uri = Uri.fromFile(file)
  intent.putExtra(Intent.EXTRA_STREAM,uri)
  intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(Intent.createChooser(intent, "分享到:"))
end

Sharing(文件路径)@



@发送短信@
@import "android.net.Uri"
import "android.content.Intent"
uri = Uri.parse("smsto:10010")
intent = Intent(Intent.ACTION_SENDTO, uri)
intent.putExtra("sms_body","cxll") 
intent.setAction("android.intent.action.VIEW")
activity.startActivity(intent)@

@发送彩信@
@import "android.net.Uri"
import "android.content.Intent"
uri=Uri.parse("file:///sdcard/a.png") --图片路径
intent= Intent();
intent.setAction(Intent.ACTION_SEND);
intent.putExtra("address",mobile) --邮件地址
intent.putExtra("sms_body",content) --邮件内容
intent.putExtra(Intent.EXTRA_STREAM,uri)
intent.setType("image/png") --设置类型
this.startActivity(intent)@

@拨打电话@
@import "android.net.Uri"
import "android.content.Intent"
uri = Uri.parse("tel:10010")
intent = Intent(Intent.ACTION_CALL, uri)
intent.setAction("android.intent.action.VIEW")
activity.startActivity(intent)@


网络操作相关代码

@自带Http模块@
@获取内容 get函数
Http.get(url,cookie,charset,header,callback)
url 网络请求的链接网址
cookie 使用的cookie，也就是服务器的身份识别信息
charset 内容编码
header 请求头
callback 请求完成后执行的函数

除了url和callback其他参数都不是必须的

回调函数接受四个参数值分别是
code 响应代码，2xx表示成功，4xx表示请求错误，5xx表示服务器错误，-1表示出错
content 内容，如果code是-1，则为出错信息
cookie 服务器返回的用户身份识别信息
header 服务器返回的头信息

向服务器发送数据 post函数
Http.post(url,data,cookie,charset,header,callback)
除了增加了一个data外，其他参数和get完全相同
data 向服务器发送的数据

下载文件 download函数
Http.download(url,path,cookie,header,callback)
参数中没有编码参数，其他同get，
path 文件保存路径

需要特别注意一点，只支持同时有127个网络请求，否则会出错


Http其实是对Http.HttpTask的封装，Http.HttpTask使用的更加通用和灵活的形式
参数格式如下
Http.HttpTask( url, String method, cookie, charset, header,  callback) 
所有参数都是必选，没有则传入nil

url 请求的网址
method 请求方法可以是get，post，put，delete等
cookie 身份验证信息
charset 内容编码
header 请求头
callback 回调函数

该函数返回的是一个HttpTask对象，
需要调用execute方法才可以执行，
t=Http.HttpTask(xxx)
t.execute{data}

注意调用的括号是花括号，内容可以是字符串或者byte数组，
使用这个形式可以自己封装异步上传函数@

@TrafficStats类@
@import "android.net.TrafficStats"
getMobileRxBytes()  --获取通过Mobile连接收到的字节总数，不包含WiFi  
getMobileRxPackets()  --获取Mobile连接收到的数据包总数  
getMobileTxBytes()  --Mobile发送的总字节数  
getMobileTxPackets()  --Mobile发送的总数据包数  
getTotalRxBytes()  --获取总的接受字节数，包含Mobile和WiFi等  
getTotalRxPackets()  --总的接受数据包数，包含Mobile和WiFi等  
getTotalTxBytes()  --总的发送字节数，包含Mobile和WiFi等  
getTotalTxPackets()  --发送的总数据包数，包含Mobile和WiFi等   
getUidRxBytes(int uid)  --获取某个网络UID的接受字节数  
getUidTxBytes(int uid) --获取某个网络UID的发送字节数   
--例:TrafficStats.getTotalRxBytes()@

@开启关闭WiFi@
@import "android.content.Context"
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
wifi.setWifiEnabled(true)--关闭则false@

@断开网络@
@import "android.content.Context"
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
wifi.disconnect()@



@WiFi是否打开@
@import "android.content.Context"
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
wi = wifi.isWifiEnabled()@

@WiFi是否连接@
@connManager = activity.getSystemService(Context.CONNECTIVITY_SERVICE)
    mWifi = connManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
    if tostring(mWifi):find("none)")  then
    --未连接
    else
    --连接
    end@

@数据网络是否连接@
@manager = activity.getSystemService(Context.CONNECTIVITY_SERVICE);  
gprs = manager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE).getState();  
if tostring(gprs)== "CONNECTED" then
print"当前数据网络"
end@


@获取WiFi信息@
@import "android.content.Context"
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
 wifi.getConfiguredNetworks()@



@获取WiFi状态@
@import "android.content.Context"
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
print(wifi.getWifiState())@




@IP地址@
@--查看某网站IP地址
address=InetAddress.getByName("www.10010.com");

--查看本机IP地址
address=InetAddress.getLocalHost();

--查看IP地址
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE).getDhcpInfo()
string.match(tostring(wifi),"ipaddr(.-)gate")@


@获取Dns@
@import "android.content.Context"

--获取Dns1
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE).getDhcpInfo()
 print(string.match(tostring(wifi),"dns1 (.-) dns2"))

--获取Dns2
wifi = activity.Context.getSystemService(Context.WIFI_SERVICE).getDhcpInfo()
 dns2 = string.match(tostring(wifi),"dns2 (.-) D")@




@获取网络名称@
@wifiManager=activity.Context.getSystemService(Context.WIFI_SERVICE);
wifiInfo=wifiManager.getConnectionInfo();
print(wifiInfo.getSSID())@


@获取WiFi加密类型@
@wifi = activity.Context.getSystemService(Context.WIFI_SERVICE).getConfiguredNetworks()
print(string.match(tostring(wifi),[[KeyMgmt: (.-) P]]))@


@获取网络信号强度@
@wifiManager=activity.Context.getSystemService(Context.WIFI_SERVICE);
wifiInfo=wifiManager.getConnectionInfo();
print(wifiInfo.getRssi())@

@获取SSID是否被隐藏@
@wifiManager=activity.Context.getSystemService(Context.WIFI_SERVICE);
wifiInfo=wifiManager.getConnectionInfo();
print(wifiInfo.getHiddenSSID())@


@获取Mac地址@
@wifiManager=activity.Context.getSystemService(Context.WIFI_SERVICE);
wifiInfo=wifiManager.getConnectionInfo();
print( wifiInfo.getMacAddress())@


笔记

﻿@打印@
@print(打印内容)@
@控件被单击@
@function 控件ID.onClick()
--事件
end

控件ID.onClick=function()
--事件
end@
@控件被长按@
@控件ID.onLongClick=function()
--事件
end

function 控件ID.onLongClick()
--事件
end@
@控件可视，不可视或隐藏@
@--控件可视
控件ID.setVisibility(View.VISIBLE)
--控件不可视
控件ID.setVisibility(View.INVISIBLE)
--控件隐藏
控件ID.setVisibility(View.GONE)@
@提示框@
@import "android.content.DialogInterface"
local dl=AlertDialog.Builder(activity)
.setTitle("提示框标题")
.setMessage("提示框内容")
.setPositiveButton("按钮标题",DialogInterface
.OnClickListener{
onClick=function(v)
--事件
end
})
.setNegativeButton("按钮标题",nil)
.create()
dl.show()@
@读写文件@
@--读文件
local file=io.input("地址")
local str=io.read("*a")
io.close()
print(str)
--写文件
local file=io.output("地址")
io.write(写入内容)
io.flush()
io.close()@
@加载框示例@
@local dl=ProgressDialog.show(activity,nil,'登录中')
dl.show()
local a=0
local tt=Ticker()
tt.start()
tt.onTick=function() 
a=a+1
if a==3 then
dl.dismiss()
tt.stop() 
end
end@
@标题栏菜单按钮@
@tittle={"分享","帮助","皮肤","退出"}
function onCreateOptionsMenu(menu) 
for k,v in ipairs(tittle) do 
if tittle[v] then 
local m=menu.addSubMenu(v) 
for k,v in ipairs(tittle[v]) do 
m.add(v) 
end 
else 
local m=menu.add(v) 
m.setShowAsActionFlags(1) 
end 
end 
end 
function onMenuItemSelected(id,tittle) 
if y[tittle.getTitle()] then 
y[tittle.getTitle()]() 
end 
end 

y={}
y["帮助"]=function() 
--事件
end

--菜单
function onCreateOptionsMenu(menu)
menu.add("打开").onMenuItemClick=function(a)

end
menu.add("新建").onMenuItemClick=function(a)

end
end@
@关闭对话框@
@--将dl.show赋值
dialog=dl.show()
--在某按钮点击后关闭这个对话框
function zc.onClick()
dialog.dismiss()
end@
@判断是否有网络@
@local wl=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo(); 
if wl== nil then
print("无法连接到服务器")
end@
@沉浸状态栏@
@--这个需要系统SDK21以上才能用
if Build.VERSION.SDK_INT >= 21 then
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff4285f4);
end
--这个需要系统SDK19以上才能用
if Build.VERSION.SDK_INT >= 19 then
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
end@
@复制文本到剪贴板@
@--先导入包
import "android.content.*" 
activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(文本)@
@安卓跳转动画@
@android.R.anim.accelerate_decelerate_interpolator
android.R.anim.accelerate_interpolator
android.R.anim.anticipate_interpolator
android.R.anim.anticipate_overshoot_interpolator
android.R.anim.bounce_interpolator
android.R.anim.cycle_interpolator
android.R.anim.decelerate_interpolatoandroid.R.anim.r
android.R.anim.fade_in
android.R.anim.fade_out
android.R.anim.linear_interpolator
android.R.anim.overshoot_interpolator
android.R.anim.slide_in_left
android.R.anim.slide_out_right@
@TextView文本可选择复制@
@--代码中设置
t.TextIsSelectable=true
--布局表中设置
textIsSelectable=true@
@取随机数@
@math.random(最小值,最大值)@
@延迟@
@--这个会卡进程，配合线程使用
Thread.sleep(延迟时间)
--这个不会卡进程
--500指延迟500毫秒
task(500‚function()
--延迟之后执行的事件
end)@
@定时器@
@--timer定时器
t=timer(function() 
--事件
end,延迟,间隔,初始化)
--暂停timer定时器
t.Enable=false
--启动timer定时器
t.Enable=true

--Ticker定时器
ti=Ticker()
ti.Period=间隔
ti.onTick=function() 
--事件
end
--启动Ticker定时器
ti.start()
--停止Ticker定时器
ti.stop()@
@获取本地时间@
@--格式的时间
os.date("%Y-%m-%d %H:%M:%S")
--本地时间总和
os.clock()
@EditText文本被改变事件
控件ID.addTextChangedListener{
onTextChanged=function(s)
--事件
end
}@
@字符串操作@
@--字符串转大写
string.upper(字符串)
--字符串转小写
string.lower(字符串)
--字符串替换
string.gsub(字符串,被替换的字符,替换的字符,替换次数)@
@设置控件大小@
@--设置宽度
linearParams = 控件ID.getLayoutParams()
linearParams.width =宽度
控件ID.setLayoutParams(linearParams)
--同理设置高度
linearParams = 控件ID.getLayoutParams()
linearParams.height =高度
控件ID.setLayoutParams(linearParams)@
@载入窗口传参@
@activity.newActivity("窗口名",{参数})

--渐变动画效果的，中间是安卓跳转动画代码
activity.newActivity("窗口名",android.R.anim.fade_in,android.R.anim.fade_out,{参数})@
@EditText只能输数字@
@import "android.text.InputType"
import "android.text.method.DigitsKeyListener"
控件ID.setInputType(InputType.TYPE_CLASS_NUMBER)
控件ID.setKeyListener(DigitsKeyListener.getInstance("0123456789"))@
@窗口全屏@
@activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)@
@关闭当前窗口@
@activity.finish()@
@按两次返回键退出@
@参数=0
function onKeyDown(code,event) 
if string.find(tostring(event),"KEYCODE_BACK") ~= nil then 
if 参数+2 > tonumber(os.time()) then 
activity.finish()
else
 Toast.makeText(activity,"再按一次返回键退出" , Toast.LENGTH_SHORT )
.show()
参数=tonumber(os.time()) 
end
return true 
end
end@
@取字符串中间@
@string.match("左测试测试右","左(.-)右")@
@判断文件是否存在@
@--先导入io包
import "java.io.*"
file,err=io.open("路径")
print(err)
if err==nil then
print("存在")
else
print("不存在")
end@
@判断文件夹是否存在@
@--先导入io包
import "java.io.*"
if File(文件夹路径).isDirectory()then
print("存在")
else
print("不存在")
end@
@窗口回调事件@
@function onActivityResult()
--事件
end@
@隐藏标题栏@
@activity.ActionBar.hide()@
@自定义布局对话框@
@local dl=AlertDialog.Builder(activity)
.setTitle("自定义布局对话框")
.setView(loadlayout(layout))
dl.show()@
@列表下滑到最底事件@
@list.setOnScrollListener{
onScrollStateChanged=function(l,s)
if list.getLastVisiblePosition()==list.getCount()-1 then
--事件
end
end}@
@标题栏返回按钮@
@activity.getActionBar().setDisplayHomeAsUpEnabled(true) @
@列表长按事件@
@ID.setOnItemLongClickListener(AdapterView.OnItemLongClickListener{
onItemLongClick=function(parent, v, pos,id)
--事件
end
})@
@列表点击事件@
@ID.setOnItemClickListener(AdapterView.OnItemClickListener{
onItemClick=function(parent, v, pos,id)
--事件
end
})@
@关于V4的圆形下拉刷新@
@--设置下拉刷新监听事件
swipeRefreshLayout.setOnRefreshListener(this);
--设置进度条的颜色
swipeRefreshLayout.setColorSchemeColors(Color.RED, Color.BLUE, Color.GREEN);
--设置圆形进度条大小
swipeRefreshLayout.setSize(SwipeRefreshLayout.LARGE);
--设置进度条背景颜色
swipeRefreshLayout.setProgressBackgroundColorSchemeColor(Color.DKGRAY);
--设置下拉多少距离之后开始刷新数据
swipeRefreshLayout.setDistanceToTriggerSync(50);@
@活动中的回调@
@function main(...)
--...是newActivity传递过来的参数。
print("入口函数",...)
end

function onCreate()
print("窗口创建")
end

function onStart()
print("活动开始")
end

function onResume()
print("返回程序")
end

function onPause()
print("活动暂停")
end

function onStop()
print("活动停止")
end

function onDestroy()
print("程序已退出")
end

function onResult(name,...)
--name：返回的活动名称
--...：返回的参数
print("返回活动",name,...)
end

function onCreateOptionsMenu(menu)
--menu：选项菜单。
menu.add("菜单")
end

function onOptionsItemSelected(item)
--item：选中的菜单项
print(item.Title)
end

function onConfigurationChanged(config)
--config：配置信息
print("屏幕方向关闭")
end

function onKeyDown(keycode,event)
--keycode：键值
--event：事件
print("按键按下",keycode)
end

function onKeyUp(keycode,event)
--keycode：键值
--event：事件
print("按键抬起",keycode)
end

function onKeyLongPress(keycode,event)
--keycode：键值
--event：事件
print("按键长按",keycode)
end

function onTouchEvent(event)
--event：事件
print("触摸事件",event)
end@
@对话框Dialog@
@--简单对话框
AlertDialog.Builder(this).setTitle("标题")
.setMessage("简单消息框")
.setPositiveButton("确定",nil)
.show();

--带有三个按钮的对话框
AlertDialog.Builder(this) 
.setTitle("确认")
.setMessage("确定吗？")
.setPositiveButton("是",nil)
.setNegativeButton("否",nil)
.setNeutralButton("不知道",nil)
.show();

--带输入框的
AlertDialog.Builder(this)
.setTitle("请输入")
.setIcon(android.R.drawable.ic_dialog_info)
.setView(EditText(this))
.setPositiveButton("确定", nil)
.setNegativeButton("取消", nil)
.show();

--单选的
AlertDialog.Builder(this)
.setTitle("请选择")
.setIcon(android.R.drawable.ic_dialog_info)
.setSingleChoiceItems({"选项1","选项2","选项3","选项4"}, 0, 
DialogInterface.OnClickListener() {
 onClick(dialog,which) {
dialog.dismiss();
 }
}
)
.setNegativeButton("取消", null)
.show();

--多选的
AlertDialog.Builder(this)
.setTitle("多选框")
.setMultiChoiceItems({"选项1","选项2","选项3","选项4"}, null, null)
.setPositiveButton("确定", null)
.setNegativeButton("取消", null)
.show();

--列表的
AlertDialog.Builder(this)
.setTitle("列表框")
.setItems({"列表项1","列表项2","列表项3"},nil)
.setNegativeButton("确定",nil)
.show();

--图片的
img = ImageView(this);
img.setImageResource(R.drawable.icon);
AlertDialog.Builder(this)
.setTitle("图片框")
.setView(img)
.setPositiveButton("确定",nil)
.show();@
@删除ListView中某项@
@adp.remove(pos)@
@打开某APP@
@--导入包
import "android.content.*"

intent = Intent();
componentName = ComponentName("com.androlua","com.androlua.Welcome"); 
intent.setComponent(componentName); 
activity.startActivity(intent);@
@设置横屏竖屏@
@--横屏
activity.setRequestedOrientation(0); 
--竖屏
activity.setRequestedOrientation(1); @
@设置控件图片@
@--设置的图片也可以输入路径
ID.setImageBitmap(loadbitmap("图片.png"))@
@禁用编辑框@
@--代码中设置
editText.setFocusable(false);
--布局表中设置
Focusable=false;@
@隐藏滑条@
@--横向
horizontalScrollBarEnabled=false;
--竖向
VerticalScrollBarEnabled=false;@
@图片着色@
@--代码中设置
ID.setColorFilter(0xffff0000)
--布局表中设置
ColorFilter="#ffff0000"；@
@获取IMEI号@
@import "android.content.*" 
--导入包 

imei=activity.getSystemService(Context.TELEPHONY_SERVICE).getDeviceId(); 
print(imei) 

--别忘了添加权限"READ_PHONE_STATE" @
@分享文字@
@import "android.content.*" 

text="分享的内容" 
intent=Intent(Intent.ACTION_SEND); 
intent.setType("text/plain"); 
intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
intent.putExtra(Intent.EXTRA_TEXT, text); 
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
activity.startActivity(Intent.createChooser(intent,"分享到:")); @
@发送短信@
@--导入包
import "android.content.*" 
import "android.net.*" 

uri = Uri.parse("smsto:15800001234"); 
intent = Intent(Intent.ACTION_SENDTO, uri); 
intent.putExtra("sms_body","你好") 
intent.setAction("android.intent.action.VIEW"); 
activity.startActivity(intent); @
@拔号@
@import "android.content.*" 
import "android.net.*" 
--导入包 
uri = Uri.parse("tel:15800001234"); 
intent = Intent(Intent.ACTION_CALL, uri); 
intent.setAction("android.intent.action.VIEW"); 
activity.startActivity(intent); 
--记得添加打电话权限 @
@安装APK@
@import "android.content.*" 
import "android.net.*" 

intent = Intent(Intent.ACTION_VIEW); 
intent.setDataAndType(Uri.parse("file:///sdcard/jc.apk"), "application/vnd.android.package-archive"); 
intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
activity.startActivity(intent); @
@振动@
@import "android.content.Context" 
--导入包 
vibrator = activity.getSystemService(Context.VIBRATOR_SERVICE) 
vibrator.vibrate( long{100,800} ,-1) 
--{等待时间,振动时间,等待时间,振动时间,•••,•••,•••,•••••} 
--{0,1000,500,1000,500,1000} 
--别忘了申明权限@
@获取剪贴板内容@
@import"android.content.*"
--导入包
a=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()@
@压缩成ZIP@
@ZipUtil.zip("文件或文件夹路径","压缩到的路径")@
@ZIP解压@
@ZipUtil.unzip("ZIP路径","解压到的路径")

--另一种Java方法
import "java.io.FileOutputStream"
import "java.util.zip.ZipFile"
import "java.io.File"

zipfile = "/sdcard/压缩包.zip"--压缩文件路径和文件名
sdpath = "/sdcard/文件.lua"--解压后路径和文件名
zipfilepath = "内容.lua"--需要解压的文件名

function unzip(zippath , outfilepath , filename)

local time=os.clock()
  task(function(zippath,outfilepath,filename)
require "import"
import "java.util.zip.*"
import "java.io.*"
local file = File(zippath)
local outFile = File(outfilepath)
local zipFile = ZipFile(file)
local entry = zipFile.getEntry(filename)
local input = zipFile.getInputStream(entry)
local output = FileOutputStream(outFile)
local byte=byte[entry.getSize()]
local temp=input.read(byte)
while temp ~= -1 do
output.write(byte)
temp=input.read(byte)
end
input.close()
output.close()
end,zippath,outfilepath,filename,
function()
print("解压完成，耗时 "..os.clock()-time.." s")
end)

end

unzip(zipfile,sdpath,zipfilepath)@
@删除文件夹@
@--shell命令的方法
os.execute("rm-r 路径")@
@重命名文件夹@
@--shell命令的方法
os.execute("mv 路径新路径")@
@创建文件夹@
@--shell命令的方法
os.execute("mkdir 路径")@
@删除文件@
@os.remove("路径")@
@设置标题栏标题@
@--标题
activity.setTitle('标题')
--小标题
activity.getActionBar().setSubtitle('小标题')@
@获取Lua文件的执行路径@
@activity.getLuaDir()@
@获取本应用包名@
@activity.getPackageName()@
@布局设置点击效果@
@--5.0或以上可以实现点击水波纹效果
--在布局加入：

style="?android:attr/buttonBarButtonStyle";@
@判断某APP是否安装@
@if pcall(function() activity.getPackageManager().getPackageInfo("包名",0) end) then
print("安装了")
else
print("没安装")
end@
@调用系统下载@
@--导入包
import "android.content.Context"
import "android.net.Uri"

downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
url=Uri.parse("绝对下载链接");
request=DownloadManager.Request(url);
request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
request.setDestinationInExternalPublicDir("目录名，可以是Download","下载的文件名");
request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
downloadManager.enqueue(request);@
@动画结束回调@
@--导入包
import "android.view.animation.*"
import "android.view.animation.Animation$AnimationListener"
--控件动画
控件.startAnimation(AlphaAnimation(1,0).setDuration(400).setFillAfter(true).setAnimationListener(AnimationListener{
onAnimationEnd=function()
print"动画结束")
end}))@
@关于侧滑@
@--侧滑布局是 DrawerLayout;
--关闭侧滑
ID.closeDrawer(3)
--打开侧滑
ID.openDrawer(3)@
@关于输入法影响布局的问题@
@--使弹出的输入法不影响布局
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
--使弹出的输入法影响布局
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);@
@TextView设置字体样式@
@--首先要导入包
import "android.graphics.*"
--设置中划线
控件id.getPaint().setFlags(Paint. STRIKE_THRU_TEXT_FLAG)
--下划线
控件id.getPaint().setFlags(Paint. UNDERLINE_TEXT_FLAG )
--加粗
控件id.getPaint().setFakeBoldText(true)
--斜体
控件id.getPaint().setTextSkewX(0.2)

--设置TypeFace
import "android.graphics.Typeface"
id.getPaint().setTypeface(字体)
--字体可以为以下
Typeface.DEFAULT --默认字体
Typeface.DEFAULT_BOLD --加粗字体
Typeface.MONOSPACE --monospace字体
Typeface.SANS_SERIF --sans字体
Typeface.SERIF --serif字体@
@强制结束自身并清除自身数据@
@ os.execute("pm clear "..activity.getPackageName())@
@递归搜索文件实例@
@require "import"

function find(catalog,name)
local n=0
local t=os.clock()
local ret={}
require "import"
import "java.io.File" 
import "java.lang.String"
function FindFile(catalog,name)
local name=tostring(name)
local ls=catalog.listFiles() or File{}
for 次数=0,#ls-1 do
--local 目录=tostring(ls[次数])
local f=ls[次数]
if f.isDirectory() then--如果是文件夹则继续匹配
FindFile(f,name)
else--如果是文件则
n=n+1
if n%1000==0 then
--print(n,os.clock()-t)
end
local nm=f.Name
if string.find(nm,name) then
--thread(insert,目录)
table.insert(ret,nm)
print(nm)
end
end
luajava.clear(f)
end
end
FindFile(catalog,name)
print("ok",n,#ret)
end

import "java.io.File"

catalog=File("sdcard/")
name=".j?pn?g"
--task(find,catalog,name,print)
thread(find,catalog,name)@
@获取ListView垂直坐标@
@function getScrollY()
c = ls.getChildAt(0);
local firstVisiblePosition = ls.getFirstVisiblePosition();
local top = c.getTop();
return -top + firstVisiblePosition * c.getHeight() ;
end@
@申请root权限@
@--shell命令的方法
os.execute("su")@
@传感器@
@传感器 = activity.getSystemService(Context.SENSOR_SERVICE)

local 加速度传感器 = 传感器.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
x轴 = event.values[0]
y轴 = event.values[1]
z轴 = event.values[2]
end,nil}), 加速度传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 光线传感器 = 传感器.getDefaultSensor(Sensor.TYPE_LIGHT)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
光线 = event.values[0]
end,nil}), 光线传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 距离传感器 = 传感器.getDefaultSensor(Sensor.TYPE_PROXIMITY)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
距离 = event.values[0]
end,nil}), 距离传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 磁场传感器 = 传感器.getDefaultSensor(Sensor.TYPE_ORIENTATION)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
磁场 = event.values[0]
end,nil}), 磁场传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 温度传感器 = 传感器.getDefaultSensor(Sensor.TYPE_TEMPERATURE)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
温度 = event.values[0]
end,nil}), 温度传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 陀螺仪传感器 = 传感器.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
陀螺仪 = event.values[0]
end,nil}), 陀螺仪传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 重力传感器 = 传感器.getDefaultSensor(Sensor.TYPE_GRAVITY)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
重力 = event.values[0]
end,nil}), 重力传感器, SensorManager.SENSOR_DELAY_NORMAL)

local 压力传感器 = 传感器.getDefaultSensor(Sensor.TYPE_PRESSURE)
传感器.registerListener(SensorEventListener({ 
onSensorChanged=function(event) 
压力 = event.values[0]
end,nil}), 压力传感器, SensorManager.SENSOR_DELAY_NORMAL)@
@获取控件宽高@
@--导入包
import "android.content.Context"

function getwh(view)
view.measure(View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED),View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED));
height =view.getMeasuredHeight();
width =view.getMeasuredWidth();
return width,height
end

print(getwh(控件ID))@
@播放音频@
@--导入包
import "android.media.MediaPlayer"

local 音频播放器=MediaPlayer()
function 播放音频(路径)
音频播放器.reset()
.setDataSource(路径)
.prepare()
.start()
.setOnCompletionListener({
onCompletion=function()
print("播放完毕")
end})
end@
@控件旋转@
@--Z轴上的旋转角度
View.getRotation()

--X轴上的旋转角度
View.getRotationX()

--Y轴上的旋转角度
View.getRotationY()

--设置Z轴上的旋转角度
View.setRotation(r)

--设置X轴上的旋转角度
View.setRotationX(r)

--设置Y轴上的旋转角度
View.setRotationY(r)

--设置旋转中心点的X坐标
View.setPivotX(p)

--设置旋转中心点的Y坐标
View.setPivotX(p)

--设置摄像机的与旋转目标在Z轴上距离
View.setCameraDistance(d)@

实用代码

@获取设备标识码@
@import "android.provider.Settings$Secure"
android_id = Secure.getString(activity.getContentResolver(), Secure.ANDROID_ID)@

@获取IMEI@
@import "android.content.Context" 
imei=activity.getSystemService(Context.TELEPHONY_SERVICE).getDeviceId()@

@控件背景渐变动画@
@view=控件id
color1 = 0xffFF8080;
color2 = 0xff8080FF;
color3 = 0xff80ffff;
color4 = 0xff80ff80;
import "android.animation.ObjectAnimator"
import "android.animation.ArgbEvaluator"
import "android.animation.ValueAnimator"
import "android.graphics.Color"
colorAnim = ObjectAnimator.ofInt(view,"backgroundColor",{color1, color2, color3,color4})
colorAnim.setDuration(3000)
colorAnim.setEvaluator(ArgbEvaluator())
colorAnim.setRepeatCount(ValueAnimator.INFINITE)
colorAnim.setRepeatMode(ValueAnimator.REVERSE)
colorAnim.start()@


@精准获取屏幕尺寸@
@function getScreenPhysicalSize(ctx) 
  import "android.util.DisplayMetrics"
  dm = DisplayMetrics();
  ctx.getWindowManager().getDefaultDisplay().getMetrics(dm);
  diagonalPixels = Math.sqrt(Math.pow(dm.widthPixels, 2) + Math.pow(dm.heightPixels, 2));
  return diagonalPixels / (160 * dm.density);
end
print(getScreenPhysicalSize(activity))@



@发送邮件@
@import "android.content.Intent"
i = Intent(Intent.ACTION_SEND)
i.setType("message/rfc822") 
i.putExtra(Intent.EXTRA_EMAIL, {"2113075983@.com"})
i.putExtra(Intent.EXTRA_SUBJECT,"Feedback")
i.putExtra(Intent.EXTRA_TEXT,"Content")
activity.startActivity(Intent.createChooser(i, "Choice"))@

@自定义默认弹窗标题,消息,按钮的颜色@
@dialog=AlertDialog.Builder(this)
.setTitle("标题")
.setMessage("消息")
.setPositiveButton("积极",{onClick=function(v) print"点击了积极按钮"end})
.setNeutralButton("中立",nil)
.setNegativeButton("否认",nil)
.show()
dialog.create()


--更改消息颜色
message=dialog.findViewById(android.R.id.message)
message.setTextColor(0xff1DA6DD)

--更改Button颜色
import "android.graphics.Color"
dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff1DA6DD)
dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff1DA6DD)
dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff1DA6DD)

--更改Title颜色
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
sp = SpannableString("标题")
sp.setSpan(ForegroundColorSpan(0xff1DA6DD),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
dialog.setTitle(sp)@


@获取手机存储空间@
@--获取手机内置剩余存储空间
 function GetSurplusSpace()
 fs =  StatFs(Environment.getDataDirectory().getPath())
 return Formatter.formatFileSize(activity, (fs.getAvailableBytes()))
 end

 --获取手机内置存储总空间
 function GetTotalSpace()
 path = Environment.getExternalStorageDirectory()
 stat = StatFs(path.getPath())
 blockSize = stat.getBlockSize()
 totalBlocks = stat.getBlockCount()
 return Formatter.formatFileSize(activity, blockSize * totalBlocks)
 end@


@获取视频第一帧@
@function GetVideoFrame(path)
  import "android.media.MediaMetadataRetriever"
  media = MediaMetadataRetriever()
  media.setDataSource(tostring(path))
  return media.getFrameAtTime()
end@

@选择文件模块@
@import "android.widget.ArrayAdapter"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "java.io.File"
import "android.widget.ListView"
import "android.app.AlertDialog"
function ChoiceFile(StartPath,callback)
  --创建ListView作为文件列表
  lv=ListView(activity).setFastScrollEnabled(true)
  --创建路径标签
  cp=TextView(activity)
  lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
  ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
  .setTitle("选择文件")
  .setView(lay)
  .show()
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" then--不是根目录则加上../
      adp.add("../")
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
    else
      ls={}
    end
    for index,c in ipairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add(c.Name.."/")
      else--如果是文件则
        adp.add(c.Name)
      end
    end
  end
  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)=="/" then
      路径=ls[p+1]
    else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      callback(tostring(路径))
      ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end

--ChoiceFile(StartPath,callback)
--第一个参数为初始化路径,第二个为回调函数
--原创@

@选择路径模块@
@require "import"
import "android.widget.ArrayAdapter"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "java.io.File"
import "android.widget.ListView"
import "android.app.AlertDialog"
function ChoicePath(StartPath,callback)
  --创建ListView作为文件列表
  lv=ListView(activity).setFastScrollEnabled(true)
  --创建路径标签
  cp=TextView(activity)
  lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
  ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
  .setTitle("选择路径")
  .setPositiveButton("OK",{
  onClick=function()
  callback(tostring(cp.Text))
  end})
.setNegativeButton("Canel",nil)
  .setView(lay)
  .show()
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" then--不是根目录则加上../
      adp.add("../")
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
    else
      ls={}
    end
    for index,c in ipairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add(c.Name.."/")
      end
    end
  end
  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)=="/" then
      路径=ls[p+1]
    else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      callback(tostring(路径))
      ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end


import "android.os.*"
ChoicePath(Environment.getExternalStorageDirectory().toString(),
function(path)
print(path)
end)

--第一个参数为初始化路径,第二个为回调函数
--原创@



@获取视图中的所有文本@
@function GetAllText(view)
textTable={}
function GetText(Parent)
local number=Parent.getChildCount()
for i=0,number do
local view=Parent.getChildAt(i)
if pcall(function()view.addView(TextView(activity))end) then
GetText(view)
elseif pcall(function()view.getText()end) then
table.insert(textTable,tostring(view.Text))
end
end
end
GetText(view)
return textTable
end

print(table.unpack(GetAllText(Parent)))@








@控件圆角@
@function CircleButton(view,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable() 
  drawable.setShape(GradientDrawable.RECTANGLE) 
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end
角度=50
控件id=ed
控件颜色=0xFF09639C
CircleButton(控件id,控件颜色,角度)@

@匹配汉字@
@function filter_spec_chars(s)
	local ss = {}
	for k = 1, #s do
		local c = string.byte(s,k)
		if not c then break end
		if (c>=48 and c<=57) or (c>= 65 and c<=90) or (c>=97 and c<=122) then
			if not string.char(c):find("%w") then
   table.insert(ss, string.char(c))
	end
 	elseif c>=228 and c<=233 then
			local c1 = string.byte(s,k+1)
			local c2 = string.byte(s,k+2)
			if c1 and c2 then
				local a1,a2,a3,a4 = 128,191,128,191
				if c == 228 then a1 = 184
				elseif c == 233 then a2,a4 = 190,c1 ~= 190 and 191 or 165
				end
				if c1>=a1 and c1<=a2 and c2>=a3 and c2<=a4 then
					k = k + 2
					table.insert(ss, string.char(c,c1,c2))
				end
			end
		end
	end
	return table.concat(ss)
end
print(filter_spec_chars("A1B2汉C3D4字E5F6,,,"))
--来源网络,加了个if过滤掉英文与数字,使其只捕获中文@



@播放音乐与视频@
@import "android.media.MediaPlayer"
mediaPlayer =  MediaPlayer()

--初始化参数
mediaPlayer.reset()

--设置播放资源
mediaPlayer.setDataSource("storage/sdcard0/a.mp3")

--开始缓冲资源
mediaPlayer.prepare()

--是否循环播放该资源
mediaPlayer.setLooping(true)

--缓冲完成的监听
mediaPlayer.setOnPreparedListener(MediaPlayer.OnPreparedListener() {
    onPrepared=function(mediaPlayer
        mediaPlayer.start()
   end});

--是否在播放
mediaPlayer.isPlaying()

--暂停播放
mediaPlayer.pause()

--从30位置开始播放
mediaPlayer.seekTo(30)

--停止播放
mediaPlayer.stop()






--播放视频
--视频的播放与音乐播放过程一样：

--先创建一个媒体对象
import "android.media.MediaPlayer"
mediaPlayer =  MediaPlayer()
--初始化参数
mediaPlayer.reset()

--设置播放资源
mediaPlayer.setDataSource("storage/sdcard0/a.mp4")

--拿到显示的SurfaceView
sh = surfaceView.getHolder()
sh.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS)

--设置显示SurfaceView
mediaPlayer.setDisplay(sh)

--设置音频流格式
mediaPlayer.setAudioStreamType(AudioManager.Stream_Music)

--开始缓冲资源
mediaPlayer.prepare()

--缓冲完成的监听
mediaPlayer.setOnPreparedListener(MediaPlayer.OnPreparedListener{
   onPrepared=function(mediaPlayer)
		--开始播放
        mediaPlayer.start()
   end
});

--释放播放器
mediaPlayer.release()


--非原创@



@获取系统SDK，Android版本及设备型号@
@device_model = Build.MODEL --设备型号 

version_sdk = Build.VERSION.SDK --设备SDK版本 

version_release = Build.VERSION.RELEASE --设备的系统版本@



@控件颜色修改@
@import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"

--修改按钮颜色
button.getBackground().setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))

--修改编辑框颜色
edittext.getBackground().setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP));

--修改Switch颜色
switch.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP));
switch.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))

--修改ProgressBar颜色
progressbar.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))

--修改SeekBar滑条颜色
seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))
--修改SeekBar滑块颜色
seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.SRC_ATOP))@





@修改对话框按钮颜色@
@function DialogButtonFilter(dialog,button,WidgetColor)
if Build.VERSION.SDK_INT >= 21 then
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
if button==1 then
dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColor)
elseif button==2 then
dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
elseif button==3 then
dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
end
end
end
--第一个参数为对话框的变量
--第二个参数为1时，则修改POSITIVE按钮颜色,为二则修改NEGATIVE按钮颜色,为三则修改NEUTRAL按钮颜色
--第三个参数为要修改成的颜色@







@查询本地所有视频@
@function QueryAllVideo()
import "android.provider.MediaStore"
cursor = activity.ContentResolver
mImageUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
mCursor = cursor.query(mImageUri,nil,nil,nil,MediaStore.Video.Media.DATE_TAKEN)
mCursor.moveToLast()
VideoTable={}
while mCursor.moveToPrevious() do
   path = mCursor.getString(mCursor.getColumnIndex(MediaStore.Video.Media.DATA))
   table.insert(VideoTable,tostring(path))
end
mCursor.close()
return VideoTable
end
--返回一个表@




@查询本地所有图片@
@function QueryAllImage()
import "android.provider.MediaStore"
cursor = activity.ContentResolver
mImageUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
mCursor = cursor.query(mImageUri,nil,nil,nil,MediaStore.Images.Media.DATE_TAKEN)
mCursor.moveToLast()
imageTable={}
while mCursor.moveToPrevious() do
   path = mCursor.getString(mCursor.getColumnIndex(MediaStore.Images.Media.DATA))
   table.insert(imageTable,tostring(path))
end
mCursor.close()
return imageTable
end
--返回一个表@




@递归查找文件@
@function outPath(ret) 
for i,p in pairs(luajava.astable(ret)) do
print(p)
end
end
function find(catalog,name)
 local n=0
 local t=os.clock()
 local ret={}
 require "import"
 import "java.io.File" 
 import "java.lang.String"
 function FindFile(catalog,name)
   local name=tostring(name)
   local ls=catalog.listFiles() or File{}
   for 次数=0,#ls-1 do
     --local 目录=tostring(ls[次数])
     local f=ls[次数]
     if f.isDirectory() then--如果是文件夹则继续匹配
       FindFile(f,name)
     else--如果是文件则
       n=n+1
       if n%1000==0 then
         print(n,os.clock()-t)
       end
      local nm=f.Name
       if string.find(nm,name) then
         --thread(insert,目录)
         table.insert(ret,tostring(f))
       end
     end
   luajava.clear(f)
   end
 end
 FindFile(catalog,name)
 call("outPath",ret)
end

import "java.io.File"

catalog=File("/sdcard/AndroLua")
name=".j?pn?g"
thread(find,catalog,name)@

@获取手机内置存储路径@
@Environment.getExternalStorageDirectory().toString()@




@获取已安装程序的包名、版本号、最后更新时间、图标、应用名称@
@function GetAppInfo(包名)
  import "android.content.pm.PackageManager"
  local pm = activity.getPackageManager();
  local 图标 = pm.getApplicationInfo(tostring(包名),0)
  local 图标 = 图标.loadIcon(pm);
  local pkg = activity.getPackageManager().getPackageInfo(包名, 0); 
  local 应用名称 = pkg.applicationInfo.loadLabel(activity.getPackageManager())
  local 版本号 = activity.getPackageManager().getPackageInfo(包名, 0).versionName
  local 最后更新时间 = activity.getPackageManager().getPackageInfo(包名, 0).lastUpdateTime
  local cal = Calendar.getInstance();
  cal.setTimeInMillis(最后更新时间); 
  local 最后更新时间 = cal.getTime().toLocaleString()
  return 包名,版本号,最后更新时间,图标,应用名称
end@

@获取指定安装包的包名,图标,应用名@
@import "android.content.pm.PackageManager"
import "android.content.pm.ApplicationInfo"
function GetApkInfo(archiveFilePath)
pm = activity.getPackageManager()
info = pm.getPackageArchiveInfo(archiveFilePath, PackageManager.GET_ACTIVITIES); 
if info ~= nil then
  appInfo = info.applicationInfo;
 appName = tostring(pm.getApplicationLabel(appInfo))
  packageName = appInfo.packageName; --安装包名称 
  version=info.versionName; --版本信息 
   icon = pm.getApplicationIcon(appInfo);--图标
end
return packageName,version,icon
end@

@获取某程序是否安装@
@if pcall(function() activity.getPackageManager().getPackageInfo("包名",0) end) then
  print("安装了")
else
  print("没安装")
end@

@设置TextView字体风格@
@import "android.graphics.Paint"
--设置中划线
id.getPaint().setFlags(Paint. STRIKE_THRU_TEXT_FLAG)
--设置下划线
id.getPaint().setFlags(Paint. UNDERLINE_TEXT_FLAG )
--设置加粗
id.getPaint().setFakeBoldText(true)
--设置斜体
id.getPaint().setTextSkewX(0.2)

--设置TypeFace
import "android.graphics.Typeface"
id.getPaint().setTypeface()
--参数列表
Typeface.DEFAULT 默认字体
Typeface.DEFAULT_BOLD 加粗字体
Typeface.MONOSPACE monospace字体
Typeface.SANS_SERIF sans字体
Typeface.SERIF serif字体@



@缩放图片@
@function rotateToFit(bm,degrees)
    import "android.graphics.Matrix"
    import "android.graphics.Bitmap"
    width = bm.getWidth()
    height = bm.getHeight()
    matrix =  Matrix()
    matrix.postRotate(degrees)
    bmResult = Bitmap.createBitmap(bm, 0, 0, width, height, matrix, true)
    return bmResult
  end
bm=loadbitmap(图片路径)
缩放级别=2
rotateToFit(bm,degrees)
--非原创@

@获取运营商名称@
@import "android.content.Context" 
运营商名称 = this.getSystemService(Context.TELEPHONY_SERVICE).getNetworkOperatorName()
print(运营商名称)
--添加权限   READ_PHONE_STATE@


@Drawable着色@
@function ToColor(path,color)
 local  aa=BitmapDrawable(loadbitmap(tostring(path)))
   aa.setColorFilter(PorterDuffColorFilter(color,PorterDuff.Mode.SRC_ATOP))
return aa
end@




@保存图片到本地@
@function SavePicture(name,bm)
if  bm then
import "java.io.FileOutputStream"
import "java.io.File"
import "android.graphics.Bitmap"
name=tostring(name)
f = File(name)
out = FileOutputStream(f)
bm.compress(Bitmap.CompressFormat.PNG,90, out)
out.flush()
out.close()
return true
else
return false
end
end@




@调用应用商店搜索应用@
@import "android.content.Intent"
import "android.net.Uri"
intent = Intent("android.intent.action.VIEW")
intent .setData(Uri.parse( "market://details?id="..activity.getPackageName()))
this.startActivity(intent)@



@分享@
@--分享文件
function Sharing(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  intent = Intent();
  intent.setAction(Intent.ACTION_SEND);
  intent.setType(Mime);
  file = File(path);
  uri = Uri.fromFile(file);
  intent.putExtra(Intent.EXTRA_STREAM,uri);
  intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
  activity.startActivity(Intent.createChooser(intent, "分享到:"));
  end

--分享文字
text="分享的内容" 
intent=Intent(Intent.ACTION_SEND); 
intent.setType("text/plain"); 
intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
intent.putExtra(Intent.EXTRA_TEXT, text); 
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
activity.startActivity(Intent.createChooser(intent,"分享到:")); @


@调用其它程序打开文件@
@function OpenFile(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  if Mime then 
    intent = Intent(); 
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
    intent.setAction(Intent.ACTION_VIEW); 
    intent.setDataAndType(Uri.fromFile(File(path)), Mime); 
    activity.startActivity(intent);
  else
    Toastc("找不到可以用来打开此文件的程序")
  end
end@


@图片圆角@
@function GetRoundedCornerBitmap(bitmap,roundPx) 
  import "android.graphics.PorterDuffXfermode"
  import "android.graphics.Paint"
  import "android.graphics.RectF"
  import "android.graphics.Bitmap"
  import "android.graphics.PorterDuff$Mode"
  import "android.graphics.Rect"
  import "android.graphics.Canvas"
  import "android.util.Config"
  width = bitmap.getWidth()
  output = Bitmap.createBitmap(width, width,Bitmap.Config.ARGB_8888)
  canvas = Canvas(output); 
  color = 0xff424242; 
  paint = Paint()
  rect = Rect(0, 0, bitmap.getWidth(), bitmap.getHeight()); 
  rectF = RectF(rect); 
  paint.setAntiAlias(true);
  canvas.drawARGB(0, 0, 0, 0); 
  paint.setColor(color); 
  canvas.drawRoundRect(rectF, roundPx, roundPx, paint); 
  paint.setXfermode(PorterDuffXfermode(Mode.SRC_IN)); 
  canvas.drawBitmap(bitmap, rect, rect, paint); 
  return output; 
end
import "android.graphics.drawable.BitmapDrawable"
圆角弧度=50
bitmap=loadbitmap(picturePath)
RoundPic=GetRoundedCornerBitmap(bitmap)@



@一键加群与QQ聊天@
@import "android.net.Uri"
import "android.content.Intent"
--加群
url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin=383792635&card_type=group&source=qrcode"
activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))

--QQ聊天
url="mqqwpa://im/chat?chat_type=wpa&uin=2113075983"
activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))@






@发送短信@
@--后台发送短信
 require "import"
 import "android.telephony.*"
 SmsManager.getDefault().sendTextMessage(tostring(号码), nil, tostring(内容), nil, nil)

--调用系统发送短信
import "android.content.Intent"
import "android.net.Uri"
uri = Uri.parse("smsto:"..号码)
intent = Intent(Intent.ACTION_SENDTO, uri)
intent.putExtra("sms_body",内容)
intent.setAction("android.intent.action.VIEW")
activity.startActivity(intent)@


@判断数组中是否存在某个值@
@function Table_exists(tables,value)
for index,content in pairs(tables) do
if content:find(value) then
return true
end
end
end@


@字符串操作@
@strings="左中右"

--取字符串左边
左=strings:match("(.+)中")


--取字符串中间
中=strings:match("左(.-)右")


--取字符串右边
右=strings:match("(.+)右")

--替换
string.gsub(原字符串,替换的字符串,替换成的字符串)

--匹配子串位置
起始位置,结束位置=string.find(字符串,子串)


--按位置捕获字符串
string.sub(字符串,子串起始位置,子串结束位置)@


@剪切板操作@
@import "android.content.Context" 
--导入类

a=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText() 
--获取剪贴板 

activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(edit.Text) 
--写入剪贴板@

@各种事件@
@function main(...)
  --...是newActivity传递过来的参数。
  print("入口函数",...)
end

function onCreate()
  print("窗口创建")
end

function onStart()
  print("活动开始")
end

function onResume()
  print("返回程序")
end

function onPause()
  print("活动暂停")
end

function onStop()
  print("活动停止")
end

function onDestroy()
  print("程序已退出")
end

function onResult(name,...)
  --name：返回的活动名称
  --...：返回的参数
  print("返回活动",name,...)
end

function onCreateOptionsMenu(menu)
  --menu：选项菜单。
  menu.add("菜单")
end

function onOptionsItemSelected(item)
  --item：选中的菜单项
  print(item.Title)
end

function onConfigurationChanged(config)
  --config：配置信息
  print("屏幕方向关闭")
end

function onKeyDown(keycode,event)
  --keycode：键值
  --event：事件
  print("按键按下",keycode)
end

function onKeyUp(keycode,event)
  --keycode：键值
  --event：事件
  print("按键抬起",keycode)
end

function onKeyLongPress(keycode,event)
  --keycode：键值
  --event：事件
  print("按键长按",keycode)
end

function onTouchEvent(event)
  --event：事件
  print("触摸事件",event)
end

function onKeyDown(c,e)
  if c==4 then
--返回键事件
end
end


id.onClick=function()
--控件被单击
end

id.onLongClick=function()
--控件被长按
end


id.onItemClick=function(p,v,i,s)
--列表项目被单击
项目=v.Text
return true
end

id.onItemLongClick=function(p,v,i,s)
--列表项目被长按
项目=v.Text
return true
end


id.onItemLongClick=function(p,v,i,s)
--列表项目被长按
项目=v.Text
return true
end

--Spinner的项目单击事件
id.onItemSelected=function(l,v,p,i) 
项目=v.Text
end

--ExpandableListView的父项目与子项目单击事件
id.onGroupClick=function(l,v,p,s)
  print(v.Text..":GroupClick")
end

id.onChildClick=function(l,v,g,c)
  print(v.Text..":ChildClick")
end@


@Shell执行@
@function exec(cmd)
local p=io.popen(string.format('%s',cmd))
local s=p:read("*a")
p:close()
return s
end

print(exec("echo  ...."))

部分常用命令:
--删除文件或文件夹
rm -r /路径

--复制文件或文件夹
cp -r inpath outpath

--移动文件或文件夹
mv -r inpath outpath

--挂载系统目录
mount -o remount,rw path

--修改系统文件权限
chmod 755 /system/build.prop

--重启
reboot  

--关机
reboot -p

--重启至recovery
reboot recovery@

界面相关代码

@标题栏(ActionBar)@
@--部分常用API
show:显示
hide:隐藏
Elevation:设置阴影
BgroundDrawable:设置背景
DisplayHomeAsUpEnabled(boolean):设置是否显示返回图标



--设置标题
activity.ActionBar.setTitle('大标题')
activity.ActionBar.setSubTitle("小标题")

--设置ActionBar背景颜色
import "android.graphics.drawable.ColorDrawable"
activity.ActionBar.setBackgroundDrawable(ColorDrawable(Color))

--自定义ActionBar标题颜色
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
sp = SpannableString("标题")
sp.setSpan(ForegroundColorSpan(0xff1DA6DD),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.ActionBar.setTitle(sp)

--自定义ActionBar布局
DisplayShowCustomEnabled(true)
CustomView(loadlayout(layout))


--ActionBar返回按钮
activity.ActionBar.setDisplayHomeAsUpEnabled(true)
--自定义返回按钮图标
activity.ActionBar.setHomeAsUpIndicator(drawable)


--菜单
function onCreateOptionsMenu(menu)
  menu.add("菜单1")
  menu.add("菜单2")
  menu.add("菜单3")
end
function onOptionsItemSelected(item)
  print("你选择了:"..item.Title)
end





--Tab导航使用
import "android.app.ActionBar$TabListener"
actionBar=activity.ActionBar
actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
tab = actionBar.newTab().setText("Tab1").setTabListener(TabListener({
  onTabSelected=function()
    print"Tab1"
  end}))
tab2=actionBar.newTab().setText("Tab2").setTabListener(TabListener({
  onTabSelected=function()
    print"Tab2"
  end}))
actionBar.addTab(tab)
actionBar.addTab(tab2)@

@五大布局@
@--Android中常用的5大布局方式有以下几种：
--线性布局（LinearLayout）：按照垂直或者水平方向布局的组件。
--帧布局（FrameLayout）：组件从屏幕左上方布局组件。
--表格布局（TableLayout）：按照行列方式布局组件。
--相对布局（RelativeLayout）：相对其它组件的布局方式。
--绝对布局（AbsoluteLayout）：按照绝对坐标来布局组件。


1.线性布局(LinearLayout)
线性布局是Android开发中最常见的一种布局方式，它是按照垂直或者水平方向来布局，通过orientation属性可以设置线性布局的方向。属性值有垂直（vertical）和水平（horizontal）两种。
常用的属性：
orientation：可以设置布局的方向
gravity:用来控制组件的对齐方式
layout_weight控制各个控件在布局中的相对大小,layout_weight的属性是一个非负整数值。  
线性布局会根据该控件layout_weight值与其所处布局中所有控件layout_weight值之和的比值为该控件分配占用的区域
--[[例如，在水平布局的LinearLayout中有两个Button，这两个Button的layout_weight属性值都为1,那么这两个按钮都会被拉伸到整个屏幕宽度的一半。如果layout_weight指为0，控件会按原大小显示，不会被拉伸.
对于其余layout_weight属性值大于0的控件，系统将会减去layout_weight属性值为0的控件的宽度或者高度,再用剩余的宽度或高度按相应的比例来分配每一个控件显示的宽度或高度]]


2.帧布局(FrameLayout)
帧布局是从屏幕的左上角（0,0）坐标开始布局，多个组件层叠排列，第一个添加的组件放到最底层，最后添加到框架中的视图显示在最上面。上一层的会覆盖下一层的控件。


3.表格布局（TableLayout）
表格布局是一个ViewGroup以表格显示它的子视图（view）元素，即行和列标识一个视图的位置。
表格布局常用的属性如下：
collapseColumns：隐藏指定的列
shrinkColumns：收缩指定的列以适合屏幕，不会挤出屏幕
stretchColumns：尽量把指定的列填充空白部分
layout_column:控件放在指定的列
layout_span:该控件所跨越的列数


4.相对布局（RelativeLayout）
相对布局是按照组件之间的相对位置来布局，比如在某个组件的左边，右边，上面和下面等。


5.绝对布局(AbsoluteLayout)
采用坐标轴的方式定位组件，左上角是（0，0）点，往右x轴递增，往下Y轴递增,组件定位属性为layout_x 和layout_y来确定坐标。@


@Widget(普通控件)@
@--Button(按钮控件)、TextView(文本控件)、EditText(编辑框控件)

常用API:
id.setText("文本")--设置控件文本
id.getText()--获取控件文本
id.setWidth(300)--设置控件宽度
id.setHeight(300)--设置控件高度


--点击事件
id.onClick=function()
print"你触发了点击事件"
end

--长按事件
id.onLongClick=function()
print"你触发了长按事件"
end



--图片控件(ImageView与ImageButton)
--设置图片
--布局表中用src属性就可以，如:src=图片路径,

--动态设置
id.setImageBitmap(loadbitmap(图片路径))
--设置Drawable对象
import "android.graphics.drawable.BitmapDrawable"
id.setImageDrawable(BitmapDrawable(loadbitmap(图片路径)))

--缩放，scaleType
--字段
CENTER    --按原来size居中显示，长/宽超过View的长/宽，截取图片的居中部分显示 
CENTER_CROP    --按比例扩大图片的size居中显示，使图片长(宽)等于或大于View的长(宽) 
CENTER_INSIDE  --完整居中显示，按比例缩小使图片长/宽等于或小于View的长/宽 
FIT_CENTER     --按比例扩大/缩小到View的宽度，居中显示 
FIT_END        --按比例扩大/缩小到View的宽度，显示在View的下部分位置 
FIT_START      --按比例扩大/缩小到View的宽度，显示在View的上部分位置 
FIT_XY         --不按比例扩大/缩小到View的大小显示 
MATRIX         --用矩阵来绘制，动态缩小放大图片来显示。 


--点击与长按事件同上@


@Check View(检查控件)@
@--CheckBox(复选框),Switch(开关控件),ToggleButton(切换按钮)
--直接判断是否选中然后执行相应事件即可
--判断API
check.isSelected()--返回布尔值


--RadioButton(单选按钮)与RadioGroup
--将RadioButton的父布局设定为RadioGroup然后绑定下面的监听即可
rp.setOnCheckedChangeListener{
  onCheckedChanged=function(g,c)
  l=g.findViewById(c)
  print(l.Text)
  end}@


@SeekBar(拖动条)@
@--绑定监听
seekbar.setOnSeekBarChangeListener{
onStartTrackingTouch=function()
--开始拖动
end,
onStopTrackingTouch=function()
--停止拖动
end,
onProgressChanged=function()
--状态改变
end}

--部分API
Progress--当前进度
Max--最大进度@

@ProgressBar(进度条)@
@--超大号圆形风格
style="?android:attr/progressBarStyleLarge"
--小号风格
style="?android:attr/progressBarStyleSmall"
--标题型风格
style="?android:attr/progressBarStyleSmallTitle"
--长形进度条
style="?android:attr/progressBarStyleHorizontal"

--部分API
max --最大进度值
progress --设置进度值
secondaryProgress="70" --初始化的底层第二个进度值

id.incrementProgressBy(5)
--ProgressBar进度值增加5
id.incrementProgressBy(-5)
--ProgressBar进度值减少5
id.incrementSecondaryProgressBy(5)
--ProgressBar背后的第二个进度条 进度值增加5
id.incrementSecondaryProgressBy(-5)
--ProgressBar背后的第二个进度条 进度值减少5 @



@Adapter View(适配器控件)@
@--适配器控件主要包括(ListView,GridView,Spinner,ExpandableList等)

--想要动态为此类控件添加项目就必须得要依靠适配器！
--适配器使用
--AarrayAdapter(简单适配器)
--创建项目数组
数据={}
--添加项目数组
for i=1,100 do
table.insert(数据,tostring(i))
end
--创建适配器
array_adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1,String(数据))
--设置适配器
lv.setAdapter(array_adp)


--LuaAdapter(Lua适配器)
--创建自定义项目视图
item={
  LinearLayout,
  orientation="vertical",
    layout_width="fill",
   {
    TextView,
    id="text",
    layout_margin="15dp",
    layout_width="fill"
  },
}
--创建项目数组
data={}
--创建适配器
adp=LuaAdapter(activity,data,item)
--添加数据
for n=1,100 do
  table.insert(data,{
    text={
      Text=tostring(n),          
    },    
  })
end
--设置适配器
lv.Adapter=adp


--以上的适配器ListView、Spinner与GridView等控件通用

--那么ExpandableListView(折叠列表)怎么办呢？
--别怕，安卓系统还提供了一个ArrayExpandableListAdapter来给我们使用，可以简单的适配ExpandableListView，下面给出实例

ns={
  "Widget","Check view","Adapter view","Advanced Widget","Layout","Advanced Layout",
}

wds={
  {"Button","EditText","TextView",
    "ImageButton","ImageView"},
  {"CheckBox","RadioButton","ToggleButton","Switch"},
  {"ListView","ExpandableListView","Spinner"},
  {"SeekBar","ProgressBar","RatingBar",
    "DatePicker","TimePicker","NumberPicker"},
  {"LinearLayout","AbsoluteLayout","FrameLayout"},
  {"RadioGroup","GridLayout",
    "ScrollView","HorizontalScrollView"},
}


mAdapter=ArrayExpandableListAdapter(activity)
for k,v in ipairs(ns) do
  mAdapter.add(v,wds[k])
end
el.setAdapter(mAdapter)
--这样就实现ExpandableListView项目的适配了




--当然AdapterView的事件响应也是与普通控件不同的。

--ListView与GridView的单击与长按事件
--项目被单击
id.onItemClick=function(l,v,p,i)
print(v.Text)
return true
end
--项目被长按
id.onItemLongClick=function(l,v,p,i)
print(v.Text)
return true
end


--Spinner的项目单击事件
id.onItemSelected=function(l,v,p,i) 
print(v.Text)
end

--ExpandableListView的父项目与子项目单击事件
id.onGroupClick=function(l,v,p,s)
print(v.Text..":GroupClick")
end

id.onChildClick=function(l,v,g,c)
print(v.Text..":ChildClick")
end@


@LuaWebView(浏览器控件)@
@--常用API
id.loadUrl("http://www.androlua.cn")--加载网页
id.loadUrl("file:///storage/sdcard0/index.html")--加载本地文件
id.getTitle()--获取网页标题
id.getUrl()--获取当前Url
id.requestFocusFromTouch()--设置支持获取手势焦点
id.getSettings().setJavaScriptEnabled(true)--设置支持JS
id.setPluginsEnabled(true)--支持插件
id.setUseWideViewPort(false)--调整图片自适应
id.getSettings().setSupportZoom(true)--支持缩放
id.getSettings().setLayoutAlgorithm(LayoutAlgorithm.SINGLE_COLUMN)--支持重新布局
id.supportMultipleWindows()--设置多窗口
id.stopLoading()--停止加载网页


--状态监听
id.setWebViewClient{
shouldOverrideUrlLoading=function(view,url)
--Url即将跳转
 end,
onPageStarted=function(view,url,favicon)
--网页加载
end,
onPageFinished=function(view,url)
--网页加载完成
end}@


@AutoCompleteTextView(自动补全文本框)@
@--适配数据
arr={"Rain","Rain1","Rain2"};
arrayAdapter=LuaArrayAdapter(activity,{TextView,padding="10dp",textSize="18sp",layout_width="fill",textColor="#ff000000"}, String(arr))
actw.setAdapter(arrayAdapter)

Threshold=1--设置输入几个字符后才能出现提示@


@TimePicker(时间选择器)@
@--时间改变监听器
import "android.widget.TimePicker$OnTimeChangedListener"
id.setOnTimeChangedListener{
  onTimeChanged=function(view,时,分)
    print(时,分)
  end}

--部分API
时=id.getCurrentHour()--获取小时
分=id.getCurrentMinute()--获取分钟
id.setIs24HourView(Boolean(true))--设置24小时制@

@DatePicker(日期选择器)@
@id=dp
日=id.getDayOfMonth()--获取选择的天数
月=id.getMonth ()--获取选择的月份
年=id.getYear()--获取选择的年份
id.updateDate(2016,1,1)--更新日期
print(年,月,日)@


@NemberPicker(数值选择器)@
@setMinValue(0)--设置最小值
setMaxValue(100)--设置最大值
setValue(50)--设置当前值
getValue()--获取选择的值
OnValueChangedListener--数值改变监听器@





@AlertDialog(对话框)@
@--常用API
.setTitle("标题")--设置标题
.setMessage("设置消息")--设置消息
.setView(loadlayout(layout))--设置自定义视图
.setPositiveButton("积极",{onClick=function() end})--设置积极按钮
.setNeutralButton("中立",nil)--设置中立按钮
.setNegativeButton("否认",nil)--设置否认按钮




--普通对话框
AlertDialog.Builder(this)
.setTitle("标题")
.setMessage("消息")
.setPositiveButton("积极",{onClick=function(v) print"点击了积极按钮"end})
.setNeutralButton("中立",nil)
.setNegativeButton("否认",nil)
.show()




--输入对话框
InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    TextView;
    id="Prompt",
    textSize="15sp",
    layout_marginTop="10dp";
    layout_marginLeft="3dp",
    layout_width="80%w";
    layout_gravity="center",
    text="输入:";
  };
  {
    EditText;
    hint="输入";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
};

AlertDialog.Builder(this)
.setTitle("标题")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定",{onClick=function(v) print(edit.Text)end})
.setNegativeButton("取消",nil)
.show()
import "android.view.View$OnFocusChangeListener"
edit.setOnFocusChangeListener(OnFocusChangeListener{ 
 onFocusChange=function(v,hasFocus)
if hasFocus then
Prompt.setTextColor(0xFD009688)
end
end})



--下载文件对话框
Download_layout={
  LinearLayout;
  orientation="vertical";
  id="Download_father_layout",
  {
    TextView;
    id="linkhint",
    layout_marginTop="10dp";
    text="下载链接",
    layout_width="80%w";
    textColor=WidgetColors,
    layout_gravity="center";
  };
  {
    EditText;
    id="linkedit",
    layout_width="80%w";
    layout_gravity="center";   
  };
  {
    TextView;
    id="pathhint",
    text="下载路径",
    layout_width="80%w";
    textColor=WidgetColors,
    layout_marginTop="10dp";
    layout_gravity="center";
  };
  {
    EditText;
    id="pathedit",
    layout_width="80%w";
    layout_gravity="center";
  };
};

AlertDialog.Builder(this)
.setTitle("下载文件")
.setView(loadlayout(Download_layout))
.setPositiveButton("下载",{onClick=function(v)
  end})
.setNegativeButton("取消",nil)
.show()







--列表对话框
items={}
for i=1,5 do
table.insert(items,"项目"..tostring(i))
end
AlertDialog.Builder(this)
.setTitle("列表对话框")
.setItems(items,{onClick=function(l,v) print(items[v+1])end})
.show()


--单选对话框
单选列表={}
for i=1,5 do
table.insert(单选列表,"单选项目"..tostring(i))
end
local 单选对话框=AlertDialog.Builder(this)
.setTitle("列表对话框")
.setSingleChoiceItems(单选列表,-1,{onClick=function(v,p)print(单选列表[p+1])end})
单选对话框.show();



--多选对话框
items={}
for i=1,5 do
table.insert(items,"多选项目"..tostring(i))
end
多选对话框=AlertDialog.Builder(this)
.setTitle("多选框")
.setMultiChoiceItems(items, nil,{ onClick=function(v,p)print(items[p+1])end})
多选对话框.show();@


@ProgressDialog(进度对话框)@
@--ProgressDialog__进度条对话框

dialog = ProgressDialog.show(this, "提示", "正在登陆中").hide()
--最简单便捷的方式

dialog2 = ProgressDialog.show(this, "提示", "正在登陆中", false).hide()
--最后一个boolean设置是否是不明确的状态

dialog3 = ProgressDialog.show(this, "提示", "正在登陆中",false, true).hide()
--最后一个boolean设置可以不可以点击取消

dialog4 = ProgressDialog.show(this, "提示", "正在登陆中",false, true, DialogInterface.OnCancelListener{
  onCancel=function()
    print("对话框取消")
  end
}).hide() 

--最后一个参数监听对话框取消，并执行事件





--圆形旋转样式
dialog5= ProgressDialog(this)
dialog5.setProgressStyle(ProgressDialog.STYLE_SPINNER)
dialog5.setTitle("Loading...")
--设置进度条的形式为圆形转动的进度条
dialog5.setMessage("ProgressDialog")
dialog5.setCancelable(true)--设置是否可以通过点击Back键取消
dialog5.setCanceledOnTouchOutside(false)--设置在点击Dialog外是否取消Dialog进度条
dialog5.setOnCancelListener{
  onCancel=function(l)
    print("取消Dialog5")
  end}
--取消对话框监听事件
dialog5.show().hide()





--水平样式
dialog6= ProgressDialog(this)
dialog6.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
--设置进度条的形式为水平进度条
dialog6.setTitle("ProgressDialog_HORIZONTAL")
dialog6.setCancelable(true)--设置是否可以通过点击Back键取消
dialog6.setCanceledOnTouchOutside(false)--设置在点击Dialog外是否取消Dialog进度条
dialog6.setOnCancelListener{
  onCancel=function(l)
    print("取消Dialog6")
  end}
--取消对话框监听事件
dialog6.setMax(100)
--设置最大进度值
dialog6.show().hide()

function 增加(i)
  dialog6.incrementProgressBy(10)
  dialog6.incrementSecondaryProgressBy(10)
  if i=="10" then
    dialog6.dismiss()
    print("加载完成")
  end
  --当进度走完时销毁对话框
end
function 加载()
  require "import"
  for i=1,10 do
    Thread.sleep(300)
    call("增加",tostring(i))
  end
end
--thread(加载)@




@InputMethodManager(输入法管理器)@
@在Android的开发中，有时候会遇到软键盘弹出时挡住输入框的情况。
这时候可以设置下软键盘的模式就可以了。
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
有时候需要软键盘不要把我们的布局整体推上去，这时候可以这样：
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN)

模式常量：

软输入区域是否可见。
SOFT_INPUT_MASK_STATE = 0x0f

未指定状态。
SOFT_INPUT_STATE_UNSPECIFIED = 0

不要修改软输入法区域的状态
SOFT_INPUT_STATE_UNCHANGED = 1

隐藏输入法区域（当用户进入窗口时
SOFT_INPUT_STATE_HIDDEN = 2

当窗口获得焦点时，隐藏输入法区域
SOFT_INPUT_STATE_ALWAYS_HIDDEN = 3

显示输入法区域（当用户进入窗口时）
SOFT_INPUT_STATE_VISIBLE = 4

当窗口获得焦点时，显示输入法区域
SOFT_INPUT_STATE_ALWAYS_VISIBLE = 5

窗口应当主动调整，以适应软输入窗口。
SOFT_INPUT_MASK_ADJUST = 0

窗口应当主动调整，以适应软输入窗口。
SOFT_INPUT_MASK_ADJUST = 0xf0

未指定状态，系统将根据窗口内容尝试选择一个输入法样式。
SOFT_INPUT_ADJUST_UNSPECIFIED = 0x00

当输入法显示时，允许窗口重新计算尺寸，使内容不被输入法所覆盖。
不可与SOFT_INPUT_ADJUSP_PAN混合使用；如果两个都没有设置，系统将根据窗口内容自动设置一个选项。
SOFT_INPUT_ADJUST_RESIZE = 0x10

输入法显示时平移窗口。它不需要处理尺寸变化，框架能够移动窗口以确保输入焦点可见。
不可与SOFT_INPUT_ADJUST_RESIZE混合使用；如果两个都没有设置，系统将根据窗口内容自动设置一个选项。
SOFT_INPUT_ADJUST_PAN = 0x20

当用户转至此窗口时，由系统自动设置，所以你不要设置它。
当窗口显示之后该标志自动清除。
SOFT_INPUT_IS_FORWARD_NAVIGATION = 0x100


其它Api参考:
import "android.view.inputmethod.InputMethodManager"
 

调用显示系统默认的输入法
imm =  activity.getSystemService(Context.INPUT_METHOD_SERVICE)
imm.showSoftInput(m_receiverView(接受软键盘输入的视图(View)),InputMethodManager.SHOW_FORCED(提供当前操作的标记，SHOW_FORCED表示强制显示))



如果输入法关闭则打开，如果输入法打开则关闭
imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
imm.toggleSoftInput(0,InputMethodManager.HIDE_NOT_ALWAYS)
  

获取软键盘是否打开
imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
isOpen=imm.isActive()
--返回一个布尔值


隐藏软键盘
activity.getSystemService(INPUT_METHOD_SERVICE)).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)

显示软键盘
activity.getSystemService(INPUT_METHOD_SERVICE)).showSoftInput(控件ID, 0)@





@PopMenu(弹出式菜单)@
@pop=PopupMenu(activity,view)
menu=pop.Menu
menu.add("项目1").onMenuItemClick=function(a)

end
menu.add("项目2").onMenuItemClick=function(a)

end
pop.show()--显示@

@PopWindow(弹出式窗口)@
@pop=PopWindow(activity)--创建PopWindow
pop.setContentView(loadlayout(布局))--设置布局
pop.setWidth(activity.Width*0.3)--设置宽度
pop.setHeight(activity.Width*0.3)--设置高度
pop.setFocusable(true)--设置可获得焦点
window.setTouchable(true)--设置可触摸
--设置点击外部区域是否可以消失
pop.setOutsideTouchable(false)
--显示
pop.showAtLocation(view,0,0,0)@


@Toast(提示)@
@--默认Toast
Toast.makeText(activity, "Toast",Toast.LENGTH_SHORT).show()

--自定义位置Toast
Toast.makeText(activity,"自定义位置Toast", Toast.LENGTH_LONG).setGravity(Gravity.CENTER, 0, 0).show()

--带图片Toast
图片=loadbitmap("/sdcard/a.png")
toast = Toast.makeText(activity,"带图片的Toast", Toast.LENGTH_LONG)
toastView = toast.getView()
imageCodeProject = ImageView(activity)
imageCodeProject.setImageBitmap(图片)
toastView.addView(imageCodeProject, 0)
toast.show()

--自定义布局Toast
布局=loadlayout(layout)
local toast=Toast.makeText(activity,"提示",Toast.LENGTH_SHORT).setView(布局).show()@


@控件常用属性@
@--EditText(输入框)
singleLine=true--设置单行输入
Error="错误的输入"--设置用户输入了错误的信息时的提醒
MaxLines=5--设置最大输入行数
MaxEms=5--设置每行最大宽度为五个字符的宽度
InputType="number"--设置只可输入数字
Hint="请输入"--设置编辑框为空时的提示文字


--ImageView(图片视图)
src="a.png"--设置控件图片资源
scaleType="fitXY"--设置图片缩放显示
ColorFilter=Color.BLUE--设置图片着色



--ListView(列表视图)
Items={"item1","item2","item3"}--设置列表项目,但只能在布局表设置,动态添加项目请看Adapter View详解。
DividerHeight=0--设置无隔断线
fastScrollEnabled=true--设置是否显示快速滑块



layout_marginBottom--离某元素底边缘的距离
layout_marginLeft--离某元素左边缘的距离
layout_marginRight--离某元素右边缘的距离
layout_marginTop--离某元素上边缘的距离
gravity--属性是对该view 内容的限定．比如一个button 上面的text. 你可以设置该text 在view的靠左，靠右等位置．以button为例，gravity="right"则button上面的文字靠右
layout_gravity--是用来设置该view相对与起父view 的位置．比如一个button 在linearlayout里，你想把该button放在靠左、靠右等位置就可以通过该属性设置．以button为例，layout_gravity="right"则button靠右
scaleType
--[[是控制图片如何resized/moved来匹对ImageView的size。ImageView.ScaleType / scaleType值的意义区别：
CENTER /center 按图片的原来size居中显示，当图片长/宽超过View的长/宽，则截取图片的居中部分显示
CENTER_CROP / centerCrop 按比例扩大图片的size居中显示，使得图片长(宽)等于或大于View的长(宽)
CENTER_INSIDE / centerInside 将图片的内容完整居中显示，通过按比例缩小或原来的size使得图片长/宽等于或小于View的长/宽
FIT_CENTER / fitCenter 把图片按比例扩大/缩小到View的宽度，居中显示
FIT_END / fitEnd 把图片按比例扩大/缩小到View的宽度，显示在View的下部分位置
FIT_START / fitStart 把图片按比例扩大/缩小到View的宽度，显示在View的上部分位置
FIT_XY / fitXY 把图片不按比例扩大/缩小到View的大小显示
MATRIX / matrix 用矩阵来绘制，动态缩小放大图片来显示。
]]
id--为控件指定相应的ID
text--指定控件当中显示的文字
textSize--指定控件当中字体的大小
background--指定该控件所使用的背景色
width--指定控件的宽度
height--指定控件的高度
layout_width--指定Container组件的宽度
layout_height--指定Container组件的高度
layout_weight--View中很重要的属性，按比例划分空间
padding--指定控件的内边距，也就是说控件当中的内容
sigleLine--如果设置为真的话，则控件的内容在同一行中进行显示@



@Animation(动画)@
@--动画主要包括以下几种
Alpha:渐变透明度动画效果
Scale:渐变尺寸伸缩动画效果
Translate:画面转换位置移动动画效果
Rotate:画面转换位置移动动画效果

--共有的属性有
Duration --属性为动画持续时间 时间以毫秒为单位
fillAfter --当设置为true,该动画转化在动画结束后被应用
fillBefore --当设置为true,该动画转化在动画开始前被应用
repeatCount--动画的重复次数 
repeatMode --定义重复的行为 
startOffset --动画之间的时间间隔，从上次动画停多少时间开始执行下个动画
id.startAnimation(Animation)--设置控件开始应用这个动画



--动画状态监听
import "android.view.animation.Animation$AnimationListener"
动画.setAnimationListener(AnimationListener{
  onAnimationStart=function()
    print"动画开始"
  end,
onAnimationEnd=function()
  print"动画结束"
  end,
onAnimationRepeat=function()
  print"动画重复"
  end})


--实例
--控件向右旋转180度
Rotate_right=RotateAnimation(180, 0,
Animation.RELATIVE_TO_SELF, 0.5, 
Animation.RELATIVE_TO_SELF, 0.5)
Rotate_right.setDuration(440)
Rotate_right.setFillAfter(true)

--控件向左旋转180度
Rotate_left=RotateAnimation(0, 180,
Animation.RELATIVE_TO_SELF, 0.5, 
Animation.RELATIVE_TO_SELF, 0.5)
Rotate_left.setDuration(440)
Rotate_left.setFillAfter(true)



--动画设置___从上往下平移动画
Translate_up_down=TranslateAnimation(0, 0, 55, 0)
Translate_up_down.setDuration(800)
Translate_up_down.setFillAfter(true)



--动画设置___透明动画
Alpha=AlphaAnimation(0,1)
Alpha.setDuration(800)


--动画参数值
--AlphaAnimation(透明动画)
AlphaAnimation(float fromStart,float fromEnd)
float fromStart 动画起始透明值
float fromEnd 动画结束透明值

--ScaleAnimation(缩放动画)
ScaleAnimation(float fromX, float toX, float fromY, float toY,int pivotXType, float pivotXValue, int pivotYType, float pivotYValue) 
float fromX 动画起始时 X坐标上的伸缩尺寸 
float toX 动画结束时 X坐标上的伸缩尺寸 
float fromY 动画起始时Y坐标上的伸缩尺寸 
float toY 动画结束时Y坐标上的伸缩尺寸 
int pivotXType 动画在X轴相对于物件位置类型 
float pivotXValue 动画相对于物件的X坐标的开始位置 
int pivotYType 动画在Y轴相对于物件位置类型 
float pivotYValue 动画相对于物件的Y坐标的开始位置 


--TranslateAnimation(位移动画)
TranslateAnimation(float fromXDelta, float toXDelta, float fromYDelta, float toYDelta)
float fromXDelta 动画开始的点离当前View X坐标上的差值 
float toXDelta 动画结束的点离当前View X坐标上的差值 
float fromYDelta 动画开始的点离当前View Y坐标上的差值 
float toYDelta 动画结束的点离当前View Y坐标上的差值 

--RotateAnimation(旋转动画)
RotateAnimation(float fromDegrees, float toDegrees, int pivotXType, float pivotXValue, int pivotYType, float pivotYValue) 
float fromDegrees：旋转的开始角度.
float toDegrees：旋转的结束角度.
int pivotXType：X轴的伸缩模式，可以取值为ABSOLUTE、RELATIVE_TO_SELF、RELATIVE_TO_PARENT.
float pivotXValue：X坐标的伸缩值
int pivotYType：Y轴的伸缩模式，可以取值为ABSOLUTE、RELATIVE_TO_SELF、RELATIVE_TO_PARENT.
float pivotYValue：Y坐标的伸缩值.@



@LayoutAnimationController(布局动画控制器)@
@--LayoutAnimationController可以控制一组控件按照规定显示 

--导入类
import "android.view.animation.AnimationUtils"
import "android.view.animation.LayoutAnimationController"


--创建一个Animation对象
animation = AnimationUtils.loadAnimation(activity,android.R.anim.slide_in_left)

--得到对象
lac = LayoutAnimationController(animation)

--设置控件显示的顺序
lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
--LayoutAnimationController.ORDER_NORMAL   顺序显示
--LayoutAnimationController.ORDER_REVERSE 反显示
--LayoutAnimationController.ORDER_RANDOM 随机显示

--设置控件显示间隔时间
lac.setDelay(time)

--设置组件应用
view.setLayoutAnimation(lac)@

@ObjectAnimator(属性动画)@
@ObjectAnimator(对象动画)
--属性动画概念：
所谓属性动画：
改变一切能改变的对象的属性值，不同于补间动画
只能改变 alpha，scale，rotate，translate
听着有点抽象，举例子说明。


补间动画能实现的:
1.alpha(透明)
--第一个参数为 view对象,第二个参数为 动画改变的类型,第三,第四个参数依次是开始透明度和结束透明度。
alpha = ObjectAnimator.ofFloat(text, "alpha", 0, 1)
alpha.setDuration(2000)--设置动画时间
alpha.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
alpha.setRepeatCount(-1)--设置动画重复次数，这里-1代表无限
alpha.setRepeatMode(Animation.REVERSE)--设置动画循环模式。
alpha.start()--启动动画。

2.scale(缩放)
animatorSet =  AnimatorSet()--组合动画
scaleX = ObjectAnimator.ofFloat(text, "scaleX", 1, 0)
scaleY = ObjectAnimator.ofFloat(text, "scaleY", 1, 0)
animatorSet.setDuration(2000)
animatorSet.setInterpolator(DecelerateInterpolator());
animatorSet.play(scaleX).with(scaleY)--两个动画同时开始
animatorSet.start();

3.translate(平移)
translationUp = ObjectAnimator.ofFloat(button, "Y",button.getY(), 0)
translationUp.setInterpolator(DecelerateInterpolator())
translationUp.setDuration(1500)
translationUp.start()

4. rotate(旋转)
set =  AnimatorSet()
anim = ObjectAnimator .ofFloat(phone, "rotationX", 0, 180)
anim.setDuration(2000)
anim2 = ObjectAnimator .ofFloat(phone, "rotationX", 180, 0)
anim2.setDuration(2000)
anim3 = ObjectAnimator .ofFloat(phone, "rotationY", 0, 180)
anim3.setDuration(2000)
anim4 = ObjectAnimator .ofFloat(phone, "rotationY", 180, 0)
anim4.setDuration(2000)
set.play(anim).before(anim2)--先执行anim动画之后在执行anim2
set.play(anim3).before(anim4)
set.start()


补间动画不能实现的:
5.android 改变背景颜色的动画实现如下
translationUp = ObjectAnimator.ofInt(button,"backgroundColor",{Color.RED, Color.BLUE, Color.GRAY,Color.GREEN})
translationUp.setInterpolator(DecelerateInterpolator())
translationUp.setDuration(1500)
translationUp.setRepeatCount(-1)
translationUp.setRepeatMode(Animation.REVERSE)
translationUp.setEvaluator(ArgbEvaluator())
translationUp.start()
--[[
ArgbEvaluator：这种评估者可以用来执行类型之间的插值整数值代表ARGB颜色。
FloatEvaluator：这种评估者可以用来执行浮点值之间的插值。
IntEvaluator：这种评估者可以用来执行类型int值之间的插值。
RectEvaluator：这种评估者可以用来执行类型之间的插值矩形值。

由于本例是改变View的backgroundColor属性的背景颜色所以此处使用ArgbEvaluator
]]@


@overridePendingTransition(设置窗口动画)@
@activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)@




@配色参考@
@--靛蓝配粉色
靛蓝色=0xFF3F51B5
粉色=0xFFE91E63

--蓝色配青绿色
蓝色=0xFF2196F3
青绿色=0xFF009688

--其它:
暗橙色=0xFFFF5722
酸橙色=0xFFCDDC39
深紫色=0xFF673AB7
青色=0xFF0097A7
红色=0xFFF44336
亮蓝=0xFF03A9F4@

]===]

activity.setContentView(loadlayout(help))
mtoolBar.title="AndroLua常用代码"

list={}
for t,c in helpStr:gmatch("(%b@@)\n*(%b@@)") do
    --print(t)
    t=t:sub(2,-2)
    c=c:sub(2,-2)
    list[t]=c
    list[#list+1]=t
    end

function show(v)
    local s=v.getText()
    local c=list[s]
    if c then
        mtoolBar.setTitle(s)
        help_tv.setText(c)
        help_dlg.show()
        --  local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String({c}))
        -- listview.setAdapter(adapter)
        end
    end



--listview=ListView(activity)
listview.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
        show(v)
        end
    })
local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(list))
listview.setAdapter(adapter)

if app_theme.colorPrimary=="#222222" then
  help_dlg=Dialog(activity,R.style.AppTheme2)
else
  help_dlg=Dialog(activity,R.style.AppTheme)
end

help_dlg.getWindow().setStatusBarColor(Color.parseColor(app_theme.colorPrimary));

dlg_view={
  LinearLayout,
  layout_width="fill",
  orientation="vertical",
  {
    Toolbar;
    title="AndroLuaJ教程";
    titleTextColor=0xffffffff;
    subtitleTextColor=0x55ffffff;
    id="mtoolBar";
    layout_width="fill";
    background=app_theme.colorPrimary;
  };
  {
    ScrollView;
    layout_width="fill";
    layout_height="fill";
    id="help_sv";
    {
      TextView,
      id="help_tv",
      textSize="18sp";
      textIsSelectable=true,
      layout_width="fill";
    },
  };
}

help_dlg.setContentView(loadlayout(dlg_view))

--[[func={}
func["捐赠"]=function()
    intent = Intent();
    intent.setAction("android.intent.action.VIEW");
    content_url = Uri.parse("https://qr.alipay.com/apt7ujjb4jngmu3z9a");
    intent.setData(content_url);
    activity.startActivity(intent);
    end
func["返回"]=function()
    activity.finish()
    end

items={"捐赠","返回"}
function onCreateOptionsMenu(menu)
    for k,v in ipairs(items) do
        m=menu.add(v)
        m.setShowAsActionFlags(1)
        end
    end

function onMenuItemSelected(id,item)
    func[item.getTitle()]()
    end

]]
