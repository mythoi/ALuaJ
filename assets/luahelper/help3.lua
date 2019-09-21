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

@关于@
@ALuaj是以AndroLua+Java模式开发APP，
它允许在AndroLua+工程的基础下插入.java文件，
默认把类合并到AndroLua+的.dex文件中

使用前您需要知道:
1.标题栏的第一个图标是"最近"打开的文件(可以容纳10个最近打开的文件)

2.标题栏的三角图标表示运行，在免安装运行时，如果src目录下没有java文件和没有引用第三方jar,aar，点击它会直接运行。否则将先编译java，打包jar,aar加载后，再运行的。若是安装运行，该安装包会包含调试用的一些代码，所以正式打包，请使用菜单的打包按钮。

3.工程属性引用第三方，在设置里配置好m2repository，就可以直接使用了

4.自带android.jar有点特殊，它包含androlua的编译环境。所以请勿使用其他android.jar

5.去除AndroLuaJ的lua文件中插入Java功能

6.其他的用法和AndroLuaJ的混合工程一样
@

@使用java文件@
@
比如有一个java文件com.test.temp.Test.java
在Lua使用时
import "com.test.temp.Test"
后就可以像Lua一样使用了
test=Test()
@

@使用xml资源(layout，id，color，style......)@
@
import "mixtureJava"
使用xml布局
activity.setContentView(R_layout.activity_main)

得到view对象
activity.findViewById(R_id.textView)
...........

或

import "包名.R"
使用xml布局
activity.setContentView(R.layout.activity_main)

得到view对象
activity.findViewById(R.id.textView)
...........

@


@混合布局@
@
在aly布局
{
include;
layout="layout/main"; --引用layout目录下的main.aly
或layout="R.layout.main"; --引用xml布局中的main.xml
}
{include; layout=""}的功能类似xml布局的 <include  layout=""/>标签
@

@Java中使用LuaActivity的方法@
@
Java中获取LuaActivity对象：LuaActivity luaActivity  =  Java.getLuaActivity(lua的路径);   
拿到LuaActivity后，我们就可以使用LuaActivity已经封装好的所有方法，如：

java跳转到lua：
在Java中使用luaActivity.newActivity(路径[,参数..])

java调用lua函数：
在Java中使用luaActivity.runFunc(函数名[,参数...])

java运行lua代码：
在Java中使用luaActivity.doString(lua代码)

java运行lua文件
在Java中使用luaActivity.doFile(lua文件路径)
.....

总之java中的luaActivity就是lua中的activity


例如：该文件是src/activity/main.lua
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "layout"
import "mixtureJava"
import "com.test.Listener "
activity.setTheme(android.R.style.Theme_Material_Light)
activity.setContentView(loadlayout(layout))

btn.setOnClickListener(Listener())

function run(a)
  print("来着Java的问候:"..a)
  end


该文件是src/com/test/Listener.java
public class Listener implements View.OnClickListener{
  
  //androlua的编译环境已包含在android.jar中，所以不用引用第三方jar，就可以直接使用androlua里面的类
 
  LuaActivity luaActivity=Java.getLuaActivity("activity/main"); 
  
  public void onClick(View v){  
    luaActivity.runFunc("run","hello");//调用lua函数
    luaActivity.doString("print'你好'");//运行lua代码
    luaActivity.doFile("main2.lua");   //运行lua文件
    }
  }

@

@ALuaj工程目录介绍@
@
assets目录:这个目录相当于androlua的工程目录，可以存放任何文件，此目录下源代码不会被编译

res目录:资源目录

src目录:也可以当作androlua的工程目录，可以和androlua工程目录一样使用，不过一般存放源代码(java，lua，aly)，此目录下所有源代码会被编译

libs目录:里面又分jar，aar，so，dex子目录。libs/jar目录存放jar包、libs/aar目录存放aar包、libs/so目录存放so文件(注意区分平台，如libs/so/x86/libtest.so)、libs/dex存放dex文件，默认把所有dex合并到classes.dex。

gen目录:存放R.java文件，无须修改，打包时自动生成

bin目录:打包时生成的二进制文件，包括.apk .class .dex
@

]===]

activity.setContentView(loadlayout(help))

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
