require "import"
import"function.config"
updateTheme()
import "android.widget.*"
import "logcat.luaLogLayout"
import "android.graphics.LightingColorFilter"
activity.setContentView(loadlayout(luaLogLayout))

  mainMenu=mtoolBar.Menu
  activity.getMenuInflater().inflate(R.menu.menu_lualog, mainMenu);
--  mtoolBar.getChildAt(1).getOverflowIcon().setColorFilter(LightingColorFilter(0xffffffff,0xffffffff))
  mtoolBar.onMenuItemClick=function(i)
    option=string.gsub(i.toString()," ", "")
    pcall(func[option])
    mtoolBar.title="LogCat-"..option
  end


function readlog(s)
  p=io.popen("logcat -d -v long "..s)
  local s=p:read("*a")
  p:close()
  s=s:gsub("%-+ beginning of[^\n]*\n","")
  if #s==0 then
    s="<run the app to see its log output>"
    end
  return s
end

function clearlog()
  p=io.popen("logcat -c")
  local s=p:read("*a")
  p:close()
  return s
end

func={}
func.All=function()
  activity.setTitle("LogCat - All")
  task(readlog,"",show)
end
func.Lua=function()
  activity.setTitle("LogCat - Lua")
  task(readlog,"lua:* *:S",show)
end
func.Test=function()
  activity.setTitle("LogCat - Test")
  task(readlog,"test:* *:S",show)
end
func.Tcc=function()
  activity.setTitle("LogCat - Tcc")
  task(readlog,"tcc:* *:S",show)
end
func.Error=function()
  activity.setTitle("LogCat - Error")
  task(readlog,"*:E",show)
end
func.Warning=function()
  activity.setTitle("LogCat - Warning")
  task(readlog,"*:W",show)
end
func.Info=function()
  activity.setTitle("LogCat - Info")
  task(readlog,"*:I",show)
end
func.Debug=function()
  activity.setTitle("LogCat - Debug")
  task(readlog,"*:D",show)
end
func.Verbose=function()
  activity.setTitle("LogCat - Verbose")
  task(readlog,"*:V",show)
end
func.Clear=function()
  task(clearlog,show)
end

--scroll=ScrollView(activity)
--scroll=ListView(activity)

scroll.FastScrollEnabled=true
logview=TextView(activity)
logview.TextIsSelectable=true
--scroll.addView(logview)
--scroll.addHeaderView(logview)
local r="%[ *%d+%-%d+ *%d+:%d+:%d+%.%d+ *%d+: *%d+ *%a/[^ ]+ *%]"

function show(s)
 -- logview.setText(s)
  --print(s)
  local a=LuaArrayAdapter(activity,{TextView,
    textIsSelectable=true,
    textSize="18sp",
    })
  local l=1
  for i in s:gfind(r) do 
    if l~=1 then
     a.add(s:sub(l,i-1))
     end
     l=i
    end
       a.add(s:sub(l))

   scroll.Adapter=a
end

func.Lua()

import "android.content.*"
cm=activity.getSystemService(activity.CLIPBOARD_SERVICE)

function copy(str)
  local cd = ClipData.newPlainText("label",str)
  cm.setPrimaryClip(cd)
  Toast.makeText(activity,"已复制的剪切板",1000).show()
end
--[[
scroll.onItemLongClick=function(l,v)
  local s=tostring(v.Text)
  copy(s)
  return true
end]]
