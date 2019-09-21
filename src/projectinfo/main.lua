require "import"
import "function.config"
updateTheme()
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
require "permission"
import "projectinfo.layout"
import "xml"
import "java.io.File"
import "android.app.AlertDialog"


activity.setContentView(loadlayout(layout))

function ChoicePath(StartPath,callback)
  --创建ListView作为文件列表
  lv=ListView(activity).setFastScrollEnabled(true)
  --创建路径标签
  cp=TextView(activity)
  lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
  ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
  .setTitle("选择依赖库")
  .setPositiveButton("取消",{
    onClick=function()

    end})
  --  .setNegativeButton("Canel",nil)
  .setView(lay)
  .show()
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" and path~=StartPath then--不是根目录则加上../
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
      if c.isDirectory() and not String(c.name).endsWith(".aar") then--如果是文件夹则
        adp.add(c.Name.."/")
      elseif c.isFile() and String(c.name).endsWith(".aar") then
        adp.add(c.Name)
      end
    end
  end
  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)==StartPath then
      路径=ls[p+1]
    else
      路径=File(cp.Text.."/"..v.Text)
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      callback(路径)
      --ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end




plist=ListView(activity)
dlg=LuaDialog(activity)
dlg.title="更改权限"
dlg.view=plist
dlg.setButton("确定",nil)
btn.onClick=function()
  dlg.show()
end
projectdir=...
luaproject=projectdir.."/src/init.lua"
app={}
loadfile(luaproject,"bt",app)()
appname.Text=app.appname or "ALuaj"
appver.Text=app.appver or "1.0"
appcode.Text=app.appcode or "1"
appsdk.Text=app.appsdk or "15"
path_pattern.Text=app.path_pattern or ""
packagename.Text=app.packagename or "com.aluaj.demo"
developer.Text=app.developer or ""
description.Text=app.description or ""
debugmode.Checked=app.debugmode==nil or app.debugmode
app_key.Text=app.app_key or ""
app_channel.Text=app.app_channel or ""
app.compiles=app.compiles or {}
plist.ChoiceMode=ListView.CHOICE_MODE_MULTIPLE;
pss={}
ps={}
for k,v in pairs(permission_info) do
  table.insert(ps,k)
end
table.sort(ps)

for k,v in ipairs(ps) do
  table.insert(pss,permission_info[v])
end

adp=ArrayListAdapter(activity,android.R.layout.simple_list_item_multiple_choice,String(pss))
plist.Adapter=adp

pcs={}
for k,v in ipairs(app.user_permission or {}) do
  pcs[v]=true
end
for k,v in ipairs(ps) do
  if pcs[v] then
    plist.setItemChecked(k-1,true)
  end
end

local fs=luajava.astable(android.R.style.getFields())
local tss={"Theme"}
for k,v in ipairs(fs) do
  local nm=v.Name
  if nm:find("^Theme_") then
    table.insert(tss,nm)
  end
end

local tadp=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(tss))
tlist.Adapter=tadp

for k,v in ipairs(tss) do
  if v==app.theme then
    tlist.setSelection(k-1)
  end
end

function callback(c,j)
  print(dump(j))
end

local template=[[
appname="%s"
appver="%s"
appcode="%s"
appsdk="%s"
path_pattern="%s"
packagename="%s"
theme="%s"
app_key="%s"
app_channel="%s"
developer="%s"
description="%s"
debugmode=%s
user_permission={
  %s
}
compiles={
  %s
}
]]
local function dump(t)
  for k,v in ipairs(t) do
    t[k]=string.format("%q",v)
  end
  return table.concat(t,",\n  ")
end


function writeXml(rs)
  stringXmlPath=projectdir.."/res/values/strings.xml"
  xfile=xml.load(stringXmlPath)
  file=xfile:find("string","name","app_name")
  file[1]=appname.Text
  xfile:save(stringXmlPath)


  stringXmlPath=projectdir.."/AndroidManifest.xml"
  xfile=xml.load(stringXmlPath)

  for k,v in pairs(rs) do
    xfile:append("uses-permission")["android:name"] = "android.permission."..String(v).replace("\"","")
  end

  file=xfile:find("manifest","android:versionCode")
  file["android:versionName"]=appver.Text
  file["android:versionCode"]=appcode.Text
  file["package"]=packagename.Text
  file=xfile:find("uses-sdk","android:minSdkVersion")
  file["android:minSdkVersion"]=appsdk.Text
  xfile:save(stringXmlPath)


end

toolMenu=toolBar.Menu
activity.getMenuInflater().inflate(R.menu.menu_proinfo, toolMenu);
toolBar.onMenuItemClick=function(i)
  func[i.toString()]()
end

func={}
func["保存"]=function()
  if appname.Text=="" or appver.Text=="" or packagename.Text=="" then
    Toast.makeText(activity,"项目不能为空",500).show()
    return true
  end

  local cs=plist.getCheckedItemPositions()
  local rs={}
  for n=1,#ps do
    if cs.get(n-1) then
      table.insert(rs,ps[n])
    end
  end
  local thm=tss[tlist.getSelectedItemPosition()+1]
  local ss=string.format(template,appname.Text,appver.Text,appcode.Text,appsdk.Text,path_pattern.Text,packagename.Text,thm,app_key.Text,app_channel.Text,developer.Text,description.Text,debugmode.isChecked(),dump(rs),dump(app.compiles))
  local f=io.open(luaproject,"w")
  f:write(ss)
  f:close()
  writeXml(rs)
  Toast.makeText(activity, "已保存.", Toast.LENGTH_SHORT ).show()
  activity.result({appname.Text})
end



lastclick=os.time()-2
function onKeyDown(e)
  local now=os.time()
  if e==4 then
    if now-lastclick>2 then
      Toast.makeText(activity, "再按一次返回.", Toast.LENGTH_SHORT ).show()
      lastclick=now
      return true
    end
  end
end



--表是否含有某值
function table.contains(value, tbl)
  for k,v in ipairs(tbl) do
    if v == value then
      return true;
    end
  end
  return false;
end


btn2.onClick=function() 
  ChoicePath(File(config.Maven依赖).path,
  function(path)
    local lib=string.gsub(path.parent,File(config.Maven依赖).path.."/","")
    l=String(lib).split("/")
    lib=string.gsub(lib,"/",".",#l-3)
    lib=string.gsub(lib,"/",":")
    if not table.contains(lib,app.compiles) then
      table.insert(app.compiles,lib)
      Toast.makeText(activity,"导入成功",0).show()
    end
  end)

end
