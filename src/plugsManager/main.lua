require "import"
import "function.config"
updateTheme()
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "java.io.File"
import "plugsManager.layout"
import "plugsManager.item"

local luadir,luapath,curFile=...
local plugindir="/storage/emulated/0/ALuaj/plugin"

activity.setContentView(loadlayout(layout))

local function getinfo(dir)
  local app={}
  loadfile(plugindir.."/"..dir.."/init.lua","bt",app)()
  return app
end

local pds=File(plugindir).list()
Arrays.sort(pds)
local pls={}
local pps={}
for n=0,#pds-1 do
  local s,i=pcall(getinfo,pds[n])
  if s then
    table.insert(pls,i)
    table.insert(pps,pds[n])
  end
end

function checkicon(i)
  i=plugindir.."/"..pps[i].."/icon.png"
  local f=io.open(i)
  if f then
    f:close()
    return i
  else
    return "/storage/emulated/0/ALuaj/icon.png"
  end
end

adp=LuaAdapter(activity,item)
for k,v in ipairs(pls) do
  adp.add{icon=checkicon(k),title=v.appname.." "..v.appver,description=v.description or ""}
end
plist.Adapter=adp
plist.onItemClick=function(l,v,p,i)
--    luadir=plugindir.."/"..pps[p+1].."/"
--    luapath=luadir.."main.lua"
  activity.newActivity(plugindir.."/"..pps[p+1].."/main.lua",{luadir,luapath,curFile})
end

