require "import"
import "mixtureJava"
import "com.mythoi.androluaj.editor.LuaEditorX"
import "com.mythoi.androluaj.util.APIConfig"
import "com.mythoi.androluaj.util.Utils"
import"function.config"
updateTheme()
import "function.Util"
import "function.UIUtil"
import "function.build"
import"view.psBar"
import"cjson"
import "android.graphics.Paint"
import "android.graphics.Path"
import "android.graphics.Canvas"
import "android.graphics.Bitmap"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.Typeface"
import "layout"
import"init.ProjectListViewInit"
import "android.graphics.LightingColorFilter"
import "android.content.*"
import "android.graphics.drawable.*"
import "androidx.pluginmgr.PluginManager"
import "android.graphics.Rect"
import "android.graphics.Color"
import "com.mythoi.androluaj.service.HideService"
import "android.content.Intent"
import "util"
if not checkApkSign(activity,-66280375) then
  activity.finish()
  os.exit(0)
end
--90436acb45
luaconf = luajava.luadir .. "/lua.conf"
--activity.setTheme(R.style.AppTheme)
--activity.getWindow().setStatusBarColor(Color.parseColor(app_theme.colorPrimary)); 
activity.getWindow().setSoftInputMode(0x10)
activity.setContentView(loadlayout(layout))

当前工程路径=nil
当前路径=nil
最近打开={}
当前打开=nil
pcall(dofile,luaconf)
光标表=HashMap()
if 光标表tmp~=nil then
  光标表.putAll(光标表tmp)
end

if 当前工程路径~=nil then
  if 当前路径==nil then
    当前路径=当前工程路径
  end
else
  当前路径=config.projectPath
end

plugMgr=nil
plug=nil
PluginManager.init(activity);
thread(function()
  require"import"
  import"java.io.File"
  import "androidx.pluginmgr.PluginManager"
  import"function.config"
  plugMgr = PluginManager.getSingleton();
  plug = plugMgr.loadPlugin(File(activity.getFilesDir().path.. "/layout1.1")).iterator().next();
  PluginManager.getSingleton().dump();
  set("plugMgr",plugMgr)
  set("plug",plug)
  local apk里的so路径=activity.ApplicationInfo.nativeLibraryDir.."/"
  if not File(config.Android依赖).exists() or not File(config.ALuaDex依赖).exists() then
    LuaUtil.assetsToSD(activity,"alj.zip",config.rootPath.."/alj.zip")
    LuaUtil.unZip(config.rootPath.."/alj.zip",config.环境根路径,"")
    LuaUtil.copyDir(apk里的so路径.."libluajava.so",config.环境根路径.."/AndroLua/lib/libluajava.so") 
    LuaUtil.rmDir(File(config.rootPath.."/alj.zip")) 
  end

  if #File(config.pluginPath).list()==0 then
    LuaUtil.unZip(activity.getFilesDir().path.."/plugins.zip",config.pluginPath) 
  end
  --初始化apt
  local chmod = String{"chmod", "744",activity.getFilesDir().path.."/apt"}
  Runtime.getRuntime().exec(chmod);

end) 


if app_theme.colorPrimary~="#222222" then

  if not pcall(function() Color.parseColor(config.edit字体颜色) end) then 
    editor.textColor=0xff000000;
  else
    editor.textColor=Color.parseColor(config.edit字体颜色);
  end 

  if not pcall(function() Color.parseColor(config.edit背景颜色) end) then 
    editor.backgroundColor=0xffffffff;
  else
    editor.backgroundColor=Color.parseColor(config.edit背景颜色);
  end 

end


menuFunc={}--函数表
menuFunc.API = function()
  activity.newActivityXS("javaapi/main",{},false)
end


menuFunc.check = function(b,filePath)

  if filePath==nil then
    return false
  end

  if not (filePath:find("%.lua$") or filePath:find("%.aly$")) then
    return false
  end

  local src = editor.getText()
  src = src.toString()
  if filePath:find("%.aly$") then
    src = "return " .. src
  end
  local _, data = loadstring(src)

  if data then
    local _, _, line, data = data:find(".(%d+).(.+)")
    editor.gotoLine(tonumber(line))
    Toast.makeText(activity, line .. ":" .. data, Toast.LENGTH_SHORT ).show()
    return true
  elseif b then
  else
    Toast.makeText(activity, "没有语法错误", Toast.LENGTH_SHORT ).show()
  end
end


menuFunc.最近 = function()
  local 最近打开temp={}
  for i=1,#最近打开-1 do
    table.insert(最近打开temp,File(最近打开[i]).name)
  end
  local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1,最近打开temp) 
  local mPopupMenu=ListPopupWindow(activity);
  mPopupMenu.setAnchorView(mainBar);
  mPopupMenu.setAdapter(adapter);
  mPopupMenu.setWidth(activity.width*2/3);
  mPopupMenu.setHeight(LinearLayout.LayoutParams.WRAP_CONTENT);

  mPopupMenu.setOnItemClickListener{

    onItemClick=function(p1,p2,p3,p4) 
      local 文件=最近打开[p3+1] 

      editor.visibility=View.VISIBLE
      无打开文件.visibility=View.GONE
      ps_bar.visibility=View.VISIBLE
      menuFunc.打开文件(文件)

      mPopupMenu.dismiss();
    end
  }
  mPopupMenu.show()
end

menuFunc.撤销 = function()
  editor.undo()
end

menuFunc.重做 = function()
  editor.redo()
end

menuFunc.布局 = function()

  local 当前打开tmp
  if 当前打开 then
    当前打开tmp=当前打开
    menuFunc.保存()
  else
    当前打开tmp="" 
  end

  if String(当前打开tmp).endsWith(".aly") then
    activity.newActivityXS("layouthelper/main",{当前工程路径.."/src/",当前打开tmp},false)
  else
    File(config.cachePath).mkdirs()
    if String(当前打开tmp).contains("res/layout/") and String(当前打开tmp).endsWith(".xml") then 
      setUIDesignerShareData(当前打开tmp)
      io.open(config.cachePath.."/.curproj","w"):write(当前打开tmp):close()
    else
      --setUIDesignerShareData(当前工程路径.."/res/layout/1")
      io.open(config.cachePath.."/.curproj","w"):write(当前工程路径.."/res/layout/1"):close()
    end 
    if plugMgr==nil or plug==nil then
      PluginManager.init(activity);
      thread(function()
        require"import"
        import"java.io.File"
        import "androidx.pluginmgr.PluginManager"
        plugMgr = PluginManager.getSingleton();
        plug = plugMgr.loadPlugin(File(activity.getFilesDir().path.. "/layout1.1")).iterator().next();
        PluginManager.getSingleton().dump();
        set("plugMgr",plugMgr)
        set("plug",plug)
        plugMgr.startMainActivity(activity,plug);
      end) 
    else
      plugMgr.startMainActivity(activity,plug);
    end
  end
end

menuFunc.运行 = function()

  File(config.luaLib依赖).mkdirs()
  File(当前工程路径.."/libs/jar").mkdirs()
  File(当前工程路径.."/libs/aar").mkdirs()
  File(当前工程路径.."/libs/dex").mkdirs()
  File(当前工程路径.."/libs/so").mkdirs()
  File(当前工程路径.."/bin/classes").mkdirs()
  File(当前工程路径.."/bin/libs").mkdirs()
  File(当前工程路径.."/gen").mkdirs()
  File(当前工程路径.."/assets").mkdirs()

  menuFunc.保存()

  if menuFunc.check(true,当前打开) then
    return
  end 

  compiles=nil

  local e, s = pcall(loadfile(当前工程路径 .. "/src/init.lua"))

  if not e then
    -- Toast.makeText(activity, "工程配置文件init.lua错误." .. s, Toast.LENGTH_SHORT).show()
    --  return
  end

  --dofile(当前工程路径.."/src/init.lua")

  local compiless=compiles or {}

  if not config.是否免安装运行 or #File(当前工程路径.."/libs/jar").list()>0 or #File(当前工程路径.."/libs/aar").list()>0 or 文件内是否包含(当前工程路径.."/src",".java") or #compiless>0 then
    build(File(当前工程路径),true)
  else
    LuaUtil.copyDir(config.luaLib依赖,当前工程路径.."/_src")
    LuaUtil.copyDir(当前工程路径.."/assets",当前工程路径.."/_src")
    LuaUtil.copyDir(当前工程路径.."/src",当前工程路径.."/_src") 
    LuaUtil.copyDir(当前工程路径.."/libs/dex",当前工程路径.."/_src/libs") 
    activity.newActivity(当前工程路径.."/_src/main.lua")
  end 
  compiles=nil

end


menuFunc.新建 = function()

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
      text="名称:";
    };
    {
      EditText;
      text="demo";
      layout_marginTop="5dp";
      layout_width="80%w";
      layout_gravity="center",
      id="edit1";
    };
    {
      TextView;
      id="Prompt",
      textSize="15sp",
      layout_marginTop="10dp";
      layout_marginLeft="3dp",
      layout_width="80%w";
      layout_gravity="center",
      text="包名:";
    };
    {
      EditText;
      text="com.aluaj.demo";
      layout_marginTop="5dp";
      layout_width="80%w";
      layout_gravity="center",
      id="edit2";
    };
  };

  AlertDialog.Builder(this)
  .setTitle("新建工程")
  .setView(loadlayout(InputLayout))
  .setPositiveButton("新建",{onClick=function(v)
      if not edit1.text:match("^[%w_%-%z\194-\244\128-\191]+$") then
        Toast.makeText(activity,"文件名不规范，仅支持中文字母数字下划线",0).show() 
        return
      end

      if File(config.projectPath.."/"..edit1.text).exists() then
        Toast.makeText(activity,"工程已存在",0).show()
        return
      end
      LuaUtil.unZip(luajava.luadir.."/androluaj.res",config.projectPath.."/"..edit1.text) 
      mainBar.title=edit1.text
      drawerBar.title=edit1.text
      menuFunc.打开工程()
      替换文件字符串(当前工程路径.."/src/init.lua","&AppName",edit1.text)
      替换文件字符串(当前工程路径.."/res/values/strings.xml","&AppName",edit1.text)
      替换文件字符串(当前工程路径.."/src/init.lua","&PackageName",edit2.text)
      替换文件字符串(当前工程路径.."/AndroidManifest.xml","&PackageName",edit2.text)
      initProjectListView(当前工程路径)
    end})
  .setNegativeButton("取消",nil)
  .show()
end

menuFunc.新建文件 = function()
  if drawerBar.subtitle==config.projectPath then
    Toast.makeText(activity,"该目录下不能新建文件",0).show() 
    return
  end
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
      text="文件名:";
    };
    {
      EditText;
      text="";
      layout_marginTop="5dp";
      layout_width="80%w";
      layout_gravity="center",
      id="edit1";
    };
  };

  AlertDialog.Builder(this)
  .setTitle("新建文件")
  .setView(loadlayout(InputLayout))
  .setPositiveButton("新建文件",{onClick=function(v) 

      if not edit1.text:match("^[%w_%-%.]+$") then
        Toast.makeText(activity,"文件名不规范，仅支持字母数字下划线",0).show() 
        return
      end

      local 文件路径=drawerBar.subtitle.."/"..edit1.text
      if drawerBar.subtitle==config.ProjectPath then
        Toast.makeText(activity,"该目录不能新建文件",0).show()
        return
      end
      if File(文件路径).exists() then
        Toast.makeText(activity,"文件已存在",0).show()
        return
      end
      local 写入文件内容=""
      local 文件名=edit1.text
      if 文件路径:match("%.lua$") then
        写入文件内容=[[require "import" 
import "android.widget.*" 
import "android.view.*"
]]
      elseif 文件路径:match("%.aly") then
        写入文件内容=[[{ 
  LinearLayout, 
  orientation="vertical", 
  layout_width="fill", 
  layout_height="fill", 
  { 
    TextView, 
    text="hello AndroLua+", 
    layout_width="fill", 
  } 
}]]
      elseif 文件路径:match("%.java") then
        if String(文件路径).startsWith(当前工程路径.."/src") then
          local 包名=String(drawerBar.subtitle).replace(当前工程路径.."/src/","")
          if 包名==drawerBar.subtitle then

            写入文件内容=[[

public class ]]..文件名:match("(.+)%.")..[[
{
  
}]]

          else
            包名=String(包名).replace("/",".")
            写入文件内容="package "..包名..";"..[[

        
public class ]]..文件名:match("(.+)%.")..[[
{
  
}]]
          end
        else
          写入文件内容=""
        end
      elseif 文件路径:match("%.xml") then
        写入文件内容=[[<?xml version="1.0" encoding="utf-8"?>]]
      end
      写入文件(文件路径,写入文件内容)
      if String(文件路径).endsWith(".lua") or String(文件路径).endsWith(".aly") or String(文件路径).endsWith(".java") or String(文件路径).endsWith(".xml") or String(文件路径).endsWith(".txt") or String(文件路径).endsWith(".gitignore") or String(文件路径).endsWith(".log") then
        menuFunc.打开文件(文件路径) 
      end
      initProjectListView(drawerBar.subtitle)
    end})
  .setNegativeButton("新建文件夹",{onClick=function(v) 

      if not edit1.text:match("^[%w_%-/%.]+$") then
        Toast.makeText(activity,"文件名不规范，仅支持字母数字下划线",0).show() 
        return
      end

      local 文件路径=drawerBar.subtitle.."/"..String(edit1.text).replace(".","/")
      if drawerBar.subtitle==config.ProjectPath then
        Toast.makeText(activity,"该目录不能新建文件夹",0).show()
        return
      end

      if File(文件路径).exists() then
        Toast.makeText(activity,"文件夹已存在",0).show()
        return
      end

      File(文件路径).mkdirs()
      initProjectListView(drawerBar.subtitle) 
    end})
  .show()
end


menuFunc.工程 = function()
  drawerLayout.openDrawer(3)
end

menuFunc.打包 = function()
  File(config.luaLib依赖).mkdirs()
  if menuFunc.check(true,当前打开) then
    return
  end
  menuFunc.保存() 
  build(File(当前工程路径),false)
end

menuFunc.查找 = function()
  SearchModeBar.visibility=View.VISIBLE
  SearchModeBar.addView(editor.search(editor.selectedText),1)
end

menuFunc.跳转 = function()
  GotoLineModeBar.visibility=View.VISIBLE
  GotoLineModeBar.addView(editor.gotoLine(),1)
end

menuFunc.替换 = function()
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
      text="原字符串:";
    };
    {
      EditText;
      text=editor.selectedText;
      layout_marginTop="5dp";
      layout_width="80%w";
      layout_gravity="center",
      id="edit1";
    };
    {
      TextView;
      id="Prompt",
      textSize="15sp",
      layout_marginTop="10dp";
      layout_marginLeft="3dp",
      layout_width="80%w";
      layout_gravity="center",
      text="替换为:";
    };
    {
      EditText;
      layout_marginTop="5dp";
      layout_width="80%w";
      layout_gravity="center",
      id="edit2";
    };
  };

  AlertDialog.Builder(this)
  .setTitle("替换字符串")
  .setView(loadlayout(InputLayout))
  .setPositiveButton("替换",{onClick=function(v)
      local 被替换=editor.text
      替换=edit1.text
      替换为=edit2.text
      editor.text=String(被替换).replace(替换,替换为)
    end})
  .setNegativeButton("取消",nil)
  .show()
end


--创建对话框
function create_navi_dlg()
  if navi_dlg then
    return
  end
  navi_dlg = LuaDialog(activity)
  navi_dlg.setTitle("导航")
  navi_list = ListView(activity)
  navi_list.onItemClick = function(parent, v, pos, id)
    editor.setSelection(indexs[pos + 1])
    navi_dlg.hide()
  end
  navi_dlg.setView(navi_list)
end
menuFunc.导航 = function()
  create_navi_dlg()
  local str = editor.getText().toString()
  local fs = {}
  indexs = {}
  for s, i in str:gmatch("([%w%._]* *=? *function *[%w%._]*%b())()") do
    i = utf8.len(str, 1, i) - 1
    s = s:gsub("^ +", "")
    table.insert(fs, s)
    table.insert(indexs, i)
    fs[s] = i
  end
  local adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, String(fs))
  navi_list.setAdapter(adapter)
  navi_dlg.show()
end





menuFunc.对齐 = function()
  editor.format()
end

menuFunc.代码分析 = function()

end

menuFunc.导包 = function()
  import "java.util.HashSet"
  local items={}
  local list=editor.classes
  local h=HashSet(list);
  list.clear();
  list.addAll(h);
  APIConfig.RevoltHashMap.remove("R")
  local editCurText=String(editor.text)
  for i=0,#list-1 do
    packageName=APIConfig.RevoltHashMap.get(list.get(i))
    if packageName~=nil and not editCurText.contains(packageName) then
      table.insert(items,packageName)
    end
  end

  local listView=ListView(activity)
  listView.ChoiceMode=ListView.CHOICE_MODE_MULTIPLE;
  local adp=ArrayListAdapter(activity,android.R.layout.simple_list_item_multiple_choice,items)
  listView.Adapter=adp
  local 导入包对话框=AlertDialog.Builder(this)
  .setTitle("你可能需要导入")
  .setView(listView)
  .setPositiveButton("复制已选",{onClick=function(v)
      cm=activity.getSystemService(Context.CLIPBOARD_SERVICE)
      local buf={}
      local cs=listView.getCheckedItemPositions()
      for n=0,#items-1 do
        if cs.get(n) then
          if String(当前打开).endsWith(".java") then
            table.insert(buf,string.format("import %s;",items[n+1]))
          else
            table.insert(buf,string.format("import \"%s\"",items[n+1]))
          end
        end
      end
      local str=table.concat(buf,"\n")
      local cd = ClipData.newPlainText("label", str)
      cm.setPrimaryClip(cd)
      Toast.makeText(activity,"已复制的剪切板",1000).show()
    end})
  .setNegativeButton("复制全部",{onClick=function(v)
      cm=activity.getSystemService(Context.CLIPBOARD_SERVICE)
      local buf={}
      for n=1,#items do
        if String(当前打开).endsWith(".java") then
          table.insert(buf,string.format("import %s;",items[n]))
        else
          table.insert(buf,string.format("import \"%s\"",items[n]))
        end
      end
      local str=table.concat(buf,"\n")
      local cd = ClipData.newPlainText("label", str)
      cm.setPrimaryClip(cd)
      Toast.makeText(activity,"已复制的剪切板",1000).show()
    end})
  .setNeutralButton("取消",nil)
  导入包对话框.show(); 
  --  activity.newActivity("javaapi/fiximport", {"/storage/emulated/0/MythoiProj/Project/Androlj/src/" , "/storage/emulated/0/MythoiProj/Project/Androlj/src/main.lua" })
end

menuFunc.LogCatJava = function()
  activity.newActivityXS("logcat/JavaLog",{},false)
end

menuFunc.LogCatLua = function()
  activity.newActivityXS("logcat/LuaLog",{},false)
end



menuFunc.Lua文档 = function()
  activity.newActivityXS("luadoc",{},false)
end

menuFunc.插件 = function()
  activity.newActivityXS("plugsManager",{当前工程路径.."/",File(当前工程路径).name,当前打开},false)
  是否点击插件=true
end



menuFunc.打开工程=function()
  menuFunc.保存()
  最近打开={}
  光标表=HashMap()
  editor.visibility=View.VISIBLE
  无打开工程.visibility=View.GONE
  ps_bar.visibility=View.VISIBLE

  if 当前路径==nil then
    editor.visibility=View.GONE
    无打开文件.visibility=View.VISIBLE
    无打开工程.visibility=View.GONE
    ps_bar.visibility=View.GONE
  end

  local 菜单= mainBar.Menu
  for i=0,菜单.size()-1 do
    菜单.getItem(i).enabled=true
  end

  local 菜单= drawerBar.Menu
  for i=0,菜单.size()-1 do
    菜单.getItem(i).enabled=true
  end
  当前工程路径=config.projectPath.."/"..drawerBar.title
  Toast.makeText(activity,"打开工程："..File(当前工程路径).name,0).show()
  --  当前打开=nil
  --  initData()  
  menuFunc.打开文件(当前工程路径.."/src/main.lua",function() menuFunc.保存() end)
  setUIDesignerShareData(当前工程路径.."/res/layout/1") 
end



menuFunc.刷新依赖 = function()

  local progress=ProgressDialog(activity)
  progress.setMessage("正在刷新依赖...")
  progress.show()

  function update_class(addClasses) 
    progress.dismiss()
    editor.clearNames()
    editor.addNames(初始全局names)
    editor.addNames(addClasses) 
  end

  menuFunc.保存() 

  thread(function(file)

    if not pcall(function()
      require"import"
      import "java.io.File"
      import "function.config"
      import "java.util.ArrayList"
      import "com.mythoi.androluaj.util.Utils"
      import "com.mythoi.androluaj.util.APIConfig" 
      import "xml"
      import "java.util.ArrayList"
      if File(file.path.."/src/init.lua").exists() then
        dofile(file.path.."/src/init.lua")
      elseif File(file.path.."/assets/init.lua").exists() then
        dofile(file.path.."/assets/init.lua")
      end



      local function aarDeal()

        local function start(aarFile)
          LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk/libs","classes.jar")
          LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk","libs")
          os.rename(config.rootPath.."/buildapk/libs/classes.jar",config.rootPath.."/buildapk/libs/"..string.gsub(aarFile.name,"%.aar$",".jar"))
        end

        local aarList=File(file.path.."/libs/aar").listFiles()
        aarList=aarList or {}
        aarTable=luajava.astable(aarList) 
        for k,v in pairs(aarTable) do
          start(v)
        end

        if compiles and #compiles>0 then

          local aarArrList=ArrayList()
          for k,v in pairs(compiles) do
            s=string.gsub(v," ","")
            local ss=String(s).split(":")
            local s1=string.gsub(ss[0],"%.","/").."/"
            local s2=ss[1]
            local s3=ss[2] 
            local a=File(File(config.Maven依赖).path.."/"..s1..s2.."/").list()
            if s3=="+" and #a>3 then
              s3=a[int((#a-3)/2)]
            end



            function dealPom(依赖路径头)

              if String(依赖路径头).endsWith(".jar") then
                LuaUtil.copyDir(依赖路径头,config.rootPath.."/buildapk/libs/"..File(依赖路径头).name) 
                return
              end

              xfile=xml.load(依赖路径头..".pom") 

              if aarArrList.contains(依赖路径头..".aar") then
                return
              else
                start(File(依赖路径头..".aar")) 
                aarArrList.add(依赖路径头..".aar")
              end

              if not xfile:find("dependencies") then
                return 
              end

              for k,v in pairs(xfile:find("dependencies")) do
                if v:find("dependency") then 
                  local 引用包=(v:find("dependency")):str()
                  local groupId=引用包:match("<groupId>(.-)</groupId>")
                  local artifactId=引用包:match("<artifactId>(.-)</artifactId>")
                  local version=引用包:match("<version>(.-)</version>")
                  local type=引用包:match("<type>(.-)</type>")
                  --  start(File(p))   
                  --print(依赖路径头..".aar")       
                  local 依赖路径头2=File(config.Maven依赖).path.."/"..String(groupId).replace(".","/").."/".. artifactId.."/".. version.."/" ..artifactId.."-"..version
                  if type=="aar" then
                    dealPom(依赖路径头2)
                  else
                    dealPom(依赖路径头2..".jar")
                  end
                end 
              end
            end 
            local p=File(config.Maven依赖).path.."/"..s1..s2.."/"..s3.."/"..s2.."-"..s3 
            dealPom(p)



            --[[            local p=File(config.Maven依赖).path.."/"..s1..s2.."/"..s3.."/"..s2.."-"..s3..".aar" 
            start(File(p))]]
          end

        end

      end
      addClasses=ArrayList()
      pcall(aarDeal) 
      local jars=File(config.rootPath.."/buildapk/libs").listFiles() 
      jars=jars or File{}
      for i=0,#jars-1 do
        args = String{
          activity.getFilesDir().path.. "/apt",
          "l",jars[i].path
        };
        local classes=String(Utils.runshell(args)).split("\n")
        for i=0,#classes-1 do 
          local s=classes[i] 
          if String(s).endsWith(".class") then
            local fClass=File(s) 
            if not addClasses.contains(String(fClass.getName()).replace(".class", "")) then
              addClasses.add(String(fClass.getName()).replace(".class", ""));
            end
            APIConfig.RevoltHashMap.put(String(fClass.getName()).replace(".class", ""), String(String(s).replace('/', '.')).replace(".class", "")) 
          end
        end
      end

      local jars=File(file.path.."/libs/jar").listFiles()
      jars=jars or File{}

      for i=0,#jars-1 do
        args = String{
          activity.getFilesDir().path.. "/apt",
          "l",jars[i].path
        };
        local classes=String(Utils.runshell(args)).split("\n")
        for i=0,#classes-1 do 
          local s=classes[i] 
          if String(s).endsWith(".class") then
            local fClass=File(classes[i])
            if not addClasses.contains(String(fClass.getName()).replace(".class", "")) then
              addClasses.add(String(fClass.getName()).replace(".class", ""));
            end
            APIConfig.RevoltHashMap.put(String(fClass.getName()).replace(".class", ""), String(String(s).replace('/', '.')).replace(".class", "")) 
          end
        end
      end
      LuaUtil.rmDir(File(config.rootPath.."/buildapk")) 
      addClasses=addClasses.toArray(String[addClasses.size()])
      call("update_class",addClasses)
    end) then
      call("update_class",String{})
    end
  end,File(当前工程路径))
end


menuFunc.当前工程 = function()
  initProjectListView(当前工程路径)

end


menuFunc.当前打开 = function()
  initProjectListView(File(当前打开).parent)
end

menuFunc.导出工程=function()
  import "java.util.Date"
  import "java.text.SimpleDateFormat"
  local d = Date();
  local sdf =SimpleDateFormat("_yyyyMMddHHmm");
  local curTime=sdf.format(d);
  LuaUtil.zip(当前工程路径,config.rootPath.."/ExportProject",File(当前工程路径).name..curTime..".alj")
  Toast.makeText(activity,"导出成功",0).show()
end

menuFunc.工程属性=function()
  menuFunc.保存() 

  local e, s = pcall(loadfile(当前工程路径 .. "/src/init.lua"))
  if not e then
    Toast.makeText(activity, "工程配置文件init.lua错误." .. s, Toast.LENGTH_SHORT).show()
    return
  end

  activity.newActivityXS("projectinfo/main.lua",{当前工程路径},false)
  是否点击工程属性=true
end

menuFunc.切换主题=function()
  import "view.ThemeDialog" 
  ThemeDialog(function(color)
    activity.setSharedData("themeColor",nil) 
    activity.setSharedData("themeColor",color) 
    menuFunc.保存()
    activity.recreate()
  end,function()
    activity.setSharedData("themeColor",nil) 
    activity.setSharedData("themeColor","#222222") 
    menuFunc.保存()
    activity.recreate()
  end,
  function()
    activity.setSharedData("themeColor",nil) 
    activity.setSharedData("themeColor","#3F51B5") 
    menuFunc.保存()
    activity.recreate()
  end
  )
  -- activity.newActivityXS("main.lua",android.R.anim.fade_in,android.R.anim.fade_out,{},false)
  --  activity.finish()
end

menuFunc.运行代码=function()
  local selectText=editor.getSelectedText()
  if selectText=="" then
    Toast.makeText(activity,"未选中代码",0).show()
    return
  end
  local 内容=[[require "import"
]]..selectText
  写入文件(当前打开..".tmp",内容)
  activity.newActivity(当前打开..".tmp")
end




menuFunc.添加try块=function()

  start_=editor.getSelectionStart();
  end_=editor.getSelectionEnd() + 5;
  editor.insert(start_, "try{\n");
  editor.insert(end_, "\n}catch(Exception e){}\n");
  editor.format();

end

menuFunc.Lua注释=function()

  start_=editor.getSelectionStart();
  end_=editor.getSelectionEnd() + 4;

  if String(editor.selectedText).contains("\n") then
    if String(editor.selectedText).endsWith("\n") then
      end_=end_-1;
    end
    editor.insert(start_, "--[[");
    editor.insert(end_, "]]");
  else
    editor.insert(start_, "--");
  end

end

menuFunc.Java注释=function()

  start_=editor.getSelectionStart();
  end_=editor.getSelectionEnd() + 6;
  if String(editor.selectedText).contains("\n") then
    if String(editor.selectedText).endsWith("\n") then
      end_=end_-1;
    end
    editor.insert(start_, "/*--[[");
    editor.insert(end_, "]]*/");
  else
    editor.insert(start_, "//--");
  end

end



menuFunc.AndroLua教程=function()
  activity.newActivityXS("luahelper/help1",{},false)
end

menuFunc.AndroLua常用代码=function()
  activity.newActivityXS("luahelper/help2",{},false)
end

menuFunc.ALuaj教程=function()
  activity.newActivityXS("luahelper/help3",{},false)
end


menuFunc.设置=function()
  import "com.mythoi.androluaj.activity.SettingActivity"
  import "android.content.Intent"
  activity.startActivity(Intent(activity,SettingActivity().getClass()))
  是否点击设置=true
end

menuFunc.关于=function()
  showAboutDialog()
end



menuFunc.保存=function()

  if 当前工程路径==nil then
    return 
  end
  当前路径=drawerBar.subtitle
  pcall(function() 光标表[replaceStr(当前打开)]=editor.getSelectionEnd() end)
  local f = io.open(luaconf, "wb") 
  f:write(string.format("当前打开=%q\n当前工程路径=%q\n光标表tmp=%s\n当前路径=%q\n最近打开=%s",当前打开,当前工程路径,dump(光标表),当前路径,dump(最近打开)))
  f:close() 
  if 当前打开==nil or not File(当前打开).exists() or editor.text=="加载中..." then
    return 
  end
  editor.save(当前打开)

end


menuFunc.打开文件=function(fileName,func) 


  local 是否打开相同=false
  if not File(fileName).exists() then
    initProjectListView(当前路径)
    Toast.makeText(activity,"文件不存在",0).show()
    当前打开=nil
    table.removeItem(最近打开,fileName)
    initData()
    menuFunc.保存()
    return 
  end


  local f = io.open(fileName, "r")
  local str = f:read("*all")
  f:close()
  if string.byte(str) == 0x1b then
    Toast.makeText(activity, "不能打开已编译文件" , Toast.LENGTH_LONG ).show()
    return
  end


  if fileName~=当前打开 then
    menuFunc.保存()
    是否打开相同=false
  else
    是否打开相同=true
  end


  if 最近打开~=nil and fileName~=当前打开 then

    if table.contains(fileName,最近打开) then
      table.removeItem(最近打开,fileName)
      table.insert(最近打开,fileName)
    else
      if #最近打开>=11 then 
        table.remove(最近打开,1)
      end
      table.insert(最近打开,fileName)
    end

  end


  当前打开=fileName
  fileNameTab.text=string.gsub(当前打开,当前工程路径.."/","")
  editor.open(fileName,LuaEditorX.OpenFinishListener{
    openFinish=function() 
      if func then
        func() 
      end
      if 光标表[replaceStr(fileName)] then
        if fileName:match("%.aly$") then
          editor.format()
        end
        editor.setSelection(光标表[replaceStr(fileName)]) 
      end 

      if not 是否打开相同 then
        drawerLayout.closeDrawer(3)
      end 
      editor.visibility=View.VISIBLE
      无打开文件.visibility=View.GONE
      ps_bar.visibility=View.VISIBLE
      local 菜单= mainBar.Menu
      for i=0,菜单.size()-1 do
        if 菜单.getItem(i).title=="代码" then
          菜单.getItem(i).enabled=true
        end
      end
    end
  }) 

end

function onStop() 
  if 当前打开~=nil then
    LuaUtil.rmDir(File(当前打开..".tmp"))
  end
  menuFunc.保存()
end


function onStart()
  thread(function()
    require"import"
    import "java.lang.Thread"
    import "com.mythoi.androluaj.service.HideService"
    import "android.content.Intent"

    Thread.sleep(600)--原来是250
    local intent=Intent(activity,HideService().class);
    activity.stopService(intent); 

    Thread.sleep(200)
    local intent=Intent(activity,HideService().getClass())
    activity.startService(intent) 
  end)

  if 当前工程路径~=nil then
    LuaUtil.rmDir(File(当前工程路径.."/_src"))
  end

  LuaUtil.rmDir(File(config.cachePath))

  if 是否点击设置 then
    local editTextColor=config.edit字体颜色
    local editBgColor=config.edit背景颜色
    updateConfig()

    if editTextColor~=config.edit字体颜色 and app_theme.colorPrimary~="#222222" then

      if not pcall(function() Color.parseColor(config.edit字体颜色)end) then
        editor.textColor=0xff000000
      else
        editor.textColor=Color.parseColor(config.edit字体颜色)
      end

    end

    if editBgColor~=config.edit背景颜色 and app_theme.colorPrimary~="#222222" then


      if not pcall(function() Color.parseColor(config.edit背景颜色) end) then
        editor.backgroundColor=0xffffffff
      else
        editor.backgroundColor=Color.parseColor(config.edit背景颜色)
      end

    end

    是否点击设置=false
  end


  if 当前路径~=nil then 
    initProjectListView(当前路径) 
  end

  if 当前打开==nil then
    return
  end


  if not File(当前工程路径).exists() then
    initProjectListView(config.projectPath)
    Toast.makeText(activity,"无打开工程",0).show()
    当前打开=nil
    当前路径=config.projectPath
    当前工程路径=nil
    initData() 
    return
  end


  if not File(当前打开).exists() then
    initProjectListView(当前路径)
    Toast.makeText(activity,"文件不存在",0).show()
    当前打开=nil 
    initData() 
    return
  end

  if 是否点击插件 or (是否点击工程属性 and (当前打开==当前工程路径.."/src/init.lua" or 当前打开==当前工程路径.."/src/classes.lua" or 当前打开==当前工程路径.."/AndroidManifest.xml" or 当前打开==当前工程路径.."/res/values/strings.xml"))then
    menuFunc.打开文件(当前打开)
    是否点击插件=false
    是否点击工程属性=false
  end

  if 当前打开:match("%.aly$") or 当前打开:match("res/layout/(.+)%.xml$") then 
    menuFunc.打开文件(当前打开)
  end

end

参数=0
function onKeyDown(code,event) 
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then 
    if mPopupMenu~=nil and mPopupMenu.isShowing() then
      mPopupMenu.dismiss(); 
    end

    if drawerLayout.isDrawerOpen(Gravity.START) then
      drawerLayout.closeDrawer(3) 
    else

      if 参数+2 > tonumber(os.time()) then 
        backHome = Intent(Intent.ACTION_MAIN);
        backHome.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        backHome.addCategory(Intent.CATEGORY_HOME);
        activity.startActivity(backHome); 
      else
        Toast.makeText(activity,"再按一次返回桌面" , Toast.LENGTH_SHORT )
        .show()
        参数=tonumber(os.time()) 
      end

    end
    return true
  end 
end



--========设置剪切板监听开始================
editor.setOnSelectionChangedListener{
  onSelectionChanged=function(active,start,ends) 
    if active then 

      local selectText=editor.getSelectedText()
      if selectText~="" and selectText~=editor.text then

        if String(selectText).contains("0x") then 
          pcall(function() ps_bar.backgroundColor=int(editor.getSelectedText()) end)
        elseif (#selectText==6 or #selectText==8) then 
          pcall(function() ps_bar.backgroundColor=Color.parseColor("#"..selectText) end)
        end

        if APIConfig.RevoltHashMap.containsKey(selectText) then
          弹出导入.visibility=View.VISIBLE
          查看类.text="查看"..APIConfig.RevoltHashMap.get(selectText).."的API"
          if String(当前打开).endsWith(".java") then
            导入类.text="import "..APIConfig.RevoltHashMap.get(selectText)..";"
          else
            导入类.text=[[import "]]..APIConfig.RevoltHashMap.get(selectText)..[["]] 
          end 
        end
      end

      if ClipModeBar.visibility==8 then
        ClipModeBar.visibility=View.VISIBLE
      end
    else
      ClipModeBar.visibility=View.GONE
      弹出导入.visibility=View.GONE
      ps_bar.backgroundColor=Color.parseColor(app_theme.colorPrimary)
    end
  end
}
--==============设置剪切板监听结束====================

--===================添加补全========


function initNames()
  local function adds()
    require "import"
    import "com.mythoi.androluaj.util.APIConfig" 
    local classes = require "javaapi.android"
    local ms = { "onCreate",
      "onStart",
      "onResume",
      "onPause",
      "onStop",
      "onDestroy",
      "onActivityResult",
      "onResult",
      "onCreateOptionsMenu",
      "onOptionsItemSelected",
      "onClick",
      "onTouch",
      "onLongClick",
      "onItemClick",
    }
    local buf = String[#ms + #classes]
    for k, v in ipairs(ms) do
      buf[k - 1] = v
    end
    local l = #ms
    for k, v in ipairs(classes) do
      buf[l + k - 1] = string.match(v, "%w+$")
      APIConfig.RevoltHashMap.put(buf[l + k - 1],v)
      APIConfig.hashMap.put(v,buf[l + k - 1]) 
    end
    return buf
  end
  task(adds, function(buf) 
    初始全局names=buf
    editor.addNames(buf) 
  end)


  local buf={}
  local tmp={}
  local curr_ms=luajava.astable(LuaActivity.getMethods())
  for k,v in ipairs(curr_ms) do
    v=v.getName()
    if not tmp[v] then
      tmp[v]=true
      table.insert(buf,v.."(")
    end
  end
  editor.addPackage("activity",buf)
end
initNames()
--===================添加补全=============


--========初始化符号栏bar=============
initPsBar(ps_bar)
--=================================


--======drawerlayout监听=开始=====
drawerLayout.setDrawerListener{
  onDrawerSlide=function(drawerView, slideOffset)
    imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE); 
    imm.hideSoftInputFromWindow(drawerView.getWindowToken(), 0); 
  end;
  onDrawerOpened=function( drawerView) 
  end;
  onDrawerClosed=function(drawerView)
    if mainBar.title~=drawerBar.title and drawerBar.title~="工程列表" then
      menuFunc["打开工程"]()
      mainBar.title=drawerBar.title 
    else


    end

  end;
  onDrawerStateChanged=function(newState)
  end
}

--===========drawerlayout监听结束=================

--初始化工程列表函数
function initProjectListView(_路径)

  if not File(_路径).exists() then
    _路径=config.projectPath
  end

  ProjectListViewInit(projectListView,config.projectPath,_路径,
  function(pathFile)

    if not pathFile.exists() then 
      initProjectListView(pathFile.parent) 
      Toast.makeText(activity,"文件不存在",0).show() 
      return 
    end

    if mainBar.title~=drawerBar.title and drawerBar.title~="工程列表" then
      menuFunc["打开工程"]()
      mainBar.title=drawerBar.title 
      return
    end


    pathStr=String(pathFile.path)
    if not (pathStr.endsWith(".lua") or pathStr.endsWith(".aly") or pathStr.endsWith(".java") or pathStr.endsWith(".xml") or pathStr.endsWith(".txt") or pathStr.endsWith(".gitignore") or pathStr.endsWith(".log") ) then 
      Utils.openFile(activity,pathFile.path) 
      return 
    end

    if pathFile.path==当前打开 then
      drawerLayout.closeDrawer(3)
      return
    end

    menuFunc.打开文件(pathFile.path) 

  end,function(pathFile)

    if not pathFile.exists() then 
      initProjectListView(pathFile.parent) 
      Toast.makeText(activity,"文件不存在",0).show() 
      return 
    end

    items={"复制路径","重命名","删除"}

    AlertDialog.Builder(activity)
    .setItems(items,{onClick=function(l,v)


        if items[v+1]=="复制路径" then
          cm=activity.getSystemService(Context.CLIPBOARD_SERVICE)
          local cd = ClipData.newPlainText("label", pathFile.path)
          cm.setPrimaryClip(cd)
          Toast.makeText(activity,"已复制",0).show()
        elseif items[v+1]=="重命名" then


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
              text="文件名:";
            };
            {
              EditText;
              text=pathFile.name;
              layout_marginTop="5dp";
              layout_width="80%w";
              layout_gravity="center",
              id="edit1";
            };
          };

          AlertDialog.Builder(this)
          .setTitle("重命名")
          .setView(loadlayout(InputLayout))
          .setPositiveButton("重命名",{onClick=function(v) 

              if pathFile.parent~=config.projectPath and pathFile.isDirectory() and not edit1.text:match("^[%w_%-]+$") then
                Toast.makeText(activity,"文件名不规范，仅支持字母数字下划线",0).show() 
                return
              end

              if pathFile.isFile() and not edit1.text:match("^[%w_%-%.]+$") then
                Toast.makeText(activity,"文件名不规范，仅支持字母数字下划线",0).show() 
                return
              end

              if pathFile.parent==config.projectPath and not edit1.text:match("^[%w_%-%z\194-\244\128-\191]+$") then
                Toast.makeText(activity,"文件名不规范，仅支持中文字母数字下划线",0).show() 
                return
              end



              if 当前工程路径==nil then
                os.rename(pathFile.path,pathFile.parent.."/"..edit1.text) 
                initProjectListView(pathFile.parent) 
                return
              end



              local 修改为=String(当前打开).replace(pathFile.path,pathFile.parent.."/"..edit1.text) 
              if File(pathFile.parent.."/"..edit1.text).exists() then
                Toast.makeText(activity,"文件已存在",0).show() 
                return
              else
                当前打开=修改为
              end

              for k,v in pairs(最近打开) do
                if String(v).startsWith(pathFile.path) then
                  最近打开[k]=String(v).replace(pathFile.path,pathFile.parent.."/"..edit1.text)
                end
              end

              if pathFile.isFile() then 
                光标表.put(replaceStr(pathFile.parent.."/"..edit1.text),光标表[replaceStr(pathFile.path)])
                光标表.remove(pathFile.path) 
              else
                local 光标表temp=HashMap()
                光标表temp.putAll(光标表)
                iter=光标表temp.entrySet().iterator()
                while iter.hasNext() do 
                  entry = iter.next(); 
                  key=entry.getKey() 
                  val=entry.getValue() 
                  if String(key).startsWith(pathFile.path) then
                    光标表.remove(key) 
                    光标表.put(replaceStr(String(key).replace(pathFile.path,pathFile.parent.."/"..edit1.text)),val)
                  end
                end

              end
              os.rename(pathFile.path,pathFile.parent.."/"..edit1.text) 
              if pathFile.path==当前工程路径 then
                mainBar.title=edit1.text
                drawerBar.title=edit1.text
                当前工程路径=config.projectPath.."/"..edit1.text 
              end
              initProjectListView(pathFile.parent) 
              menuFunc.保存()

            end})
          .setNegativeButton("取消",nil)
          .show()

        elseif items[v+1]=="删除" then 
          AlertDialog.Builder(activity)
          .setTitle("删除"..pathFile.name)
          .setMessage("删除后不可恢复，是否继续")
          .setPositiveButton("删除",{onClick=function(v)

              --[[      if pathFile.path==当前工程路径 then 
                Toast.makeText(activity,"不能删除已打开的工程",0).show()
                return
              end]]

              if pathFile.isFile() then 
                光标表.remove(pathFile.path)
              else
                local 光标表temp=HashMap()
                光标表temp.putAll(光标表)
                iter=光标表temp.entrySet().iterator()
                while iter.hasNext() do 
                  entry = iter.next(); 
                  key=entry.getKey() 
                  val=entry.getValue() 
                  if String(key).startsWith(pathFile.path) then
                    光标表.remove(key) 
                  end
                end
              end


              local 最近打开temp=table.clone(最近打开)
              for k,v in pairs(最近打开temp) do
                if String(v).startsWith(pathFile.path) then 
                  table.removeItem(最近打开,v)
                end
              end

              LuaUtil.rmDir(pathFile) 
              initProjectListView(pathFile.parent)
              if pathFile.path==当前工程路径 then                                        
                当前工程路径=nil
                当前打开=nil
                最近打开={}
                initData() 
                menuFunc.保存()
                return
              end 


              if 当前打开==nil or not File(当前打开).exists() then

                ps_bar.visibility=View.GONE
                editor.visibility=View.GONE

                if 当前工程路径~=nil then
                  无打开文件.visibility=View.VISIBLE
                  无打开工程.visibility=View.GONE
                end

                local 菜单= mainBar.Menu
                for i=0,菜单.size()-1 do
                  if 菜单.getItem(i).title=="代码" then
                    菜单.getItem(i).enabled=false
                  end
                end

                当前打开=nil
                menuFunc.保存()

              end

            end})
          .setNegativeButton("取消",nil)
          .show()
        end

      end})
    .show()
  end)
end
--初始化菜单函数
function initMenu()
  --初始化抽屉菜单========
  drawerBar.title="工程列表"
  drawerMenu=drawerBar.Menu
  activity.getMenuInflater().inflate(R.menu.menu_drawer, drawerMenu);
  -- drawerBar.getOverflowIcon().setColorFilter(LightingColorFilter(0xffffffff,0xffffffff))
  drawerBar.onMenuItemClick=function(i)
    if i.toString()=="新建工程" then
      menuFunc["新建"]()
    else
      pcall(menuFunc[i.toString()])
    end
  end
  if app_theme.colorPrimary=="#222222" then
    --  drawerMenu.getItem(0).setIcon(R.mipmap.ic_bright)
    弹出导入.backgroundColor=0xff333333
    导入类.backgroundColor=0xff333333
  else
    --  drawerMenu.getItem(0).setIcon(R.mipmap.ic_moon)
  end
  drawerBar.getChildAt(1).onClick=function(v)
    cm=activity.getSystemService(Context.CLIPBOARD_SERVICE)
    local cd = ClipData.newPlainText("label", v.text)
    cm.setPrimaryClip(cd)
    Toast.makeText(activity,"已复制路径",1000).show()
  end
  --===============

  --初始化主菜单========
  mainBar.title="ALuaj"
  mainMenu=mainBar.Menu
  activity.getMenuInflater().inflate(R.menu.menu_main, mainMenu);
  -- mainBar.getOverflowIcon().setColorFilter(LightingColorFilter(0xffffffff,0xffffffff))
  mainBar.onMenuItemClick=function(i)
    option=string.gsub(i.toString()," ", "")
    pcall(menuFunc[option])
    if option=="保存" then 
      Toast.makeText(activity,"已保存所有文件",0).show() 
    end
  end

  mainBar.getChildAt(0).onClick=function(v)
    if 当前打开==nil or 当前工程路径==nil then 
      return
    end
    Toast.makeText(activity,String(当前打开).replace(当前工程路径.."/",""),1).show()
  end


  --=================

  --初始化剪切板菜单=====
  ClipModeBar.title="选择文字"
  ClipMenu=ClipModeBar.Menu
  activity.getMenuInflater().inflate(R.menu.menu_clip, ClipMenu);
  --  ClipModeBar.getOverflowIcon().setColorFilter(LightingColorFilter(0xffffffff,0xffffffff))
  ClipModeBar.onMenuItemClick=function(i)
    option=i.toString()
    if option=="全选" then
      editor.selectAll()
    elseif option=="剪切" then
      editor.cut() 
    elseif option=="复制" then
      editor.copy()
    elseif option=="粘贴" then
      editor.paste() 
    else
      menuFunc[option]()
    end
  end
  --============

  --初始化搜索菜单=========
  searchMenu=SearchModeBar.Menu
  activity.getMenuInflater().inflate(R.menu.menu_search, searchMenu);
  SearchModeBar.onMenuItemClick=function(i)
    editor.findNext()
  end
  --==============.
end

function initData()

  if 当前工程路径 and File(当前工程路径).exists() then

    if 当前打开 then 
      menuFunc.打开文件(当前打开) 
    else
      editor.visibility=View.GONE
      无打开文件.visibility=View.VISIBLE
      无打开工程.visibility=View.GONE
      ps_bar.visibility=View.GONE 
      local 菜单= mainBar.Menu
      for i=0,菜单.size()-1 do
        if 菜单.getItem(i).title=="代码" then
          菜单.getItem(i).enabled=false
        end
      end
    end
    mainBar.title=File(当前工程路径).name
    drawerBar.title=File(当前工程路径).name
  else
    mainBar.title="ALuaj"
    drawerBar.title="工程列表" 
    editor.visibility=View.GONE
    无打开文件.visibility=View.GONE
    无打开工程.visibility=View.VISIBLE
    ps_bar.visibility=View.GONE
    local 菜单= mainBar.Menu
    for i=0,菜单.size()-1 do
      if 菜单.getItem(i).title=="新建" or 菜单.getItem(i).title=="教程" or 菜单.getItem(i).title=="关于" or 菜单.getItem(i).title=="设置" or 菜单.getItem(i).title=="A P I" or 菜单.getItem(i).title=="工程" then
        菜单.getItem(i).enabled=true
      else
        菜单.getItem(i).enabled=false
      end
    end

    local 菜单= drawerBar.Menu
    for i=0,菜单.size()-1 do
      if 菜单.getItem(i).title=="切换主题" or 菜单.getItem(i).title=="新建工程" then
        菜单.getItem(i).enabled=true
      else
        菜单.getItem(i).enabled=false
      end
    end
  end
end


initProjectListView(当前路径)
initMenu()
initData()




function onNewIntent(intent)
  local uri = intent.getData()
  if not uri then 
    return 
  end
  local importPath=String(uri.getPath()).replace("/external_files","")
  if uri and (importPath:find("%.alp$") or importPath:find("%.alj$")) then
    imports(importPath)
  end
end


function getalpinfo(path)

  local app = {}

  if path:find("%.alj$") then 
    if not pcall(function() loadstring(tostring(String(LuaUtil.readZip(path, "src/init.lua"))), "bt", "bt", app)()end) then
      if not pcall(function() loadstring(tostring(String(LuaUtil.readZip(path, "assets/init.lua"))), "bt", "bt", app)() end) then
        Toast.makeText(activity, "缺少init.lua", Toast.LENGTH_SHORT ).show()
      end
    end
  else
    if not pcall(function() loadstring(tostring(String(LuaUtil.readZip(path, "init.lua"))), "bt", "bt", app)()end) then
      Toast.makeText(activity, "缺少init.lua", Toast.LENGTH_SHORT ).show()
    end
  end

  local str = string.format("名称: %s\
版本: %s\
包名: %s\
作者: %s\
说明: %s\
路径: %s",
  app.appname,
  app.appver,
  app.packagename,
  app.developer,
  app.description,
  path
  )
  return str, app.mode
end

function imports(path)
  create_imports_dlg()
  local mode
  imports_dlg.Message, mode = getalpinfo(path)
  if mode == "plugin" or path:match("^([^%._]+)_plugin") then
    imports_dlg.setTitle("导入插件")
  end
  imports_dlg.show()
end

function importx(path, tp)
  require "import"
  import "java.util.zip.*"
  import "java.io.*"

  local app = {}

  if path:find("%.alp$") then
    if not pcall(function() loadstring(tostring(String(LuaUtil.readZip(path, "init.lua"))), "bt", "bt", app)()end) then
      Toast.makeText(activity, "缺少init.lua", Toast.LENGTH_SHORT ).show()
    end
  end

  local s = app.appname or String(String(File(path).name).replace(".alj","")).replace(".alp","")
  local p = app.packagename or "com.aluaj.demo"

  local out = config.projectPath.."/" .. s

  if tp == "plugin" then
    out = config.rootPath.."/plugin/" .. s
  end



  if tp == "plugin" then
    Toast.makeText(activity, "导入插件:" .. s, Toast.LENGTH_SHORT ).show()
    LuaUtil.unZip(path,out)
    return out
  end

  Toast.makeText(activity, "导入工程:" .. s, Toast.LENGTH_SHORT ).show()
  if path:find("%.alj$") then
    LuaUtil.unZip(path,out)
    mainBar.title=s
    drawerBar.title=s
    menuFunc.打开工程()
    initProjectListView(当前工程路径) 
  else 
    LuaUtil.unZip(luajava.luadir.."/androluaj.res",out) 
    mainBar.title=s
    drawerBar.title=s
    替换文件字符串(out.."/res/values/strings.xml","&AppName",app.appname)
    替换文件字符串(out.."/AndroidManifest.xml","&PackageName",app.packagename)
    LuaUtil.unZip(path,out.."/src")
    menuFunc.打开工程()
    initProjectListView(当前工程路径)
  end
  return out
end


function create_imports_dlg()
  if imports_dlg then
    return
  end
  imports_dlg = AlertDialogBuilder(activity)
  imports_dlg.setTitle("导入")
  imports_dlg.setPositiveButton("确定", {
    onClick = function()
      local path = imports_dlg.Message:match("路径: (.+)$")
      if imports_dlg.Title == "导入插件" then
        importx(path, "plugin")
        imports_dlg.setTitle("导入")
      else
        importx(path)
      end
    end })
  imports_dlg.setNegativeButton("取消", nil)
end
