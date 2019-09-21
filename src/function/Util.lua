require "import" 
import"function.config"
import "android.widget.*" 
import "android.widget.Toast"
import "android.view.*"
import "android.content.ClipData"
import "java.util.HashMap"

--====遍历文件目录
function 遍历目录(catalog)
  local n=0
  local t=os.clock()
  local ret={}
  local rootPath=catalog.getPath().."/"
  require "import"
  import "java.io.File" 
  import "java.lang.String"
  function FindFile(catalog)
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
        end
        local nm=String(f.Name)
        if nm.endsWith(".java") or nm.endsWith(".xml") or nm.endsWith(".lua") or nm.endsWith(".aly") then
          相对路径=string.gsub(f.getPath(),rootPath,"")
          if String(相对路径).startsWith("bin/") or String(相对路径).startsWith("gen/") then
            return
          end
          table.insert(ret,相对路径)
        end
      end
      luajava.clear(f)
    end
  end
  FindFile(catalog,name)
  return ret
end

--复制到剪切板
cm = activity.getSystemService(activity.CLIPBOARD_SERVICE)
function copyClip(str)
  local cd = ClipData.newPlainText("label", str)
  cm.setPrimaryClip(cd)
  Toast.makeText(activity, "已复制", 0).show()
end


--移除表元素
function table.removeItem(list, item, removeAll)
  local rmCount = 0
  for i = 1, #list do
    if list[i - rmCount] == item then
      table.remove(list, i - rmCount)
      if removeAll then
        rmCount = rmCount + 1
      else
        break
      end
    end
  end
end

--克隆表
function table.clone(org)
  return {table.unpack(org)}
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


--替换
function replaceStr(str) 
  tmp=String(str).replace(config.projectPath,"")
  tmp=String(tmp).replace("/","")
  tmp=String(tmp).replace(".","")
  tmp=String(tmp).replace("-","")
  return "_"..tmp
end

function 替换文件字符串(路径,要替换的字符串,替换成的字符串)
  if 路径 then
    路径=tostring(路径)
    内容=io.open(路径):read("*a")
    io.open(路径,"w+"):write(tostring(内容:gsub(要替换的字符串,替换成的字符串))):close()
  else
    return false
  end
end

function 写入文件(路径,内容)
  import "java.io.File"
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

function 读取文件(路径) 
  return io.open(路径):read("*a") 
end


import "java.io.File"
function 文件内是否包含(path,ext)

  local 是否包含=false

  function 递归(pathFile,ext)

    local files=pathFile.listFiles() or File{}
        
    for i=0,#files-1 do
      local f= files[i] 
      if f.isDirectory() then
        递归(f,ext)
      else
        if String(f.path).endsWith(ext) then

          是否包含=true

        end
      end
    end
  end

  递归(File(path),ext)

  return 是否包含

end

--print(文件内是否包含("/storage/emulated/0/MythoiProj/Project/Androlj/src/",".java"))