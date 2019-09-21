require "import"
import "android.widget.ArrayAdapter"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "java.io.File"
import "android.widget.ListView"
import "android.app.AlertDialog"

if app_theme.colorPrimary=="#222222" then 
  textcolo= "#ffffff" 
else 
  textcolo= "#777777" 
end 


item={
  LinearLayout;
  layout_width="fill";
  layout_height="wrap";
  padding="10dp"; 
  orientation="horizontal";
  {
    ImageView;
    layout_width="40dp";
    id="img";
    src="icon.png";
    layout_height="40dp";
    layout_gravity="center";
  };
  {
    LinearLayout;
    layout_width="fill";
    layout_height="wrap";
    layout_marginLeft="10dp";
    orientation="vertical";
    {
      TextView;
      id="title";
      textColor=textcolo;
      typeface=Typeface.defaultFromStyle(Typeface.BOLD);
    };
    {
      TextView;
      id="subtitle";
      text="包名 com.mythoi.androlj 权限 3";
      textColor="#888888";
    };
  };
};


function ProjectListViewInit(lv,StartPath,childPath,onclick,onlongclick)
  --  lv.setFastScrollEnabled(true)
  if app_theme.colorPrimary=="#222222" then 
    lv.backgroundColor=0xff333333
    imgColor="#ffffff"; 
  else 
    imgColor=app_theme.colorPrimary
  end 

  curPosition=lv.getFirstVisiblePosition()
  adp=LuaAdapter(activity,item)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    drawerBar.subtitle=tostring(path)--设置当前路径
    if path~=StartPath then--不是根目录则加上../
      adp.add({title="../",subtitle="返回上一级",img={imageResource=R.mipmap.ic_folder,ColorFilter=Color.parseColor(imgColor)}}) 
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

      cal = Calendar.getInstance();
      time = c.lastModified()
      cal.setTimeInMillis(time); 
      filetime=cal.getTime().toLocaleString()

      if path==StartPath then
        imgsrc=StartPath.."/"..c.Name.."/res/drawable/ic_launcher.png"
        imgsrc2=StartPath.."/"..c.Name.."/src/icon.png"
        if File(imgsrc).exists() then

        elseif File(imgsrc2).exists() then
          imgsrc=imgsrc2
        else
          imgsrc="icon.png"
        end
        adp.add({title=c.Name.."/",subtitle=filetime,img={src=imgsrc,ColorFilter=0}})
      elseif c.isDirectory() then--如果是文件夹则
        adp.add({title=c.Name.."/",subtitle=filetime,img={imageResource=R.mipmap.ic_folder,ColorFilter=Color.parseColor(imgColor)}})
      else
        local fileName=c.Name
        if String(fileName).endsWith(".lua") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_lua,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".aly") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_aly,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".java") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_java,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".xml") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_xml,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".jar") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_jar,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".dex") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_dex,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".aar") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_aar,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".so") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_so,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".alj") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_alj,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".txt") or String(fileName).endsWith(".gitignore") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_txt,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".apk") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_apk,ColorFilter=Color.parseColor(imgColor)}})
        elseif String(fileName).endsWith(".class") then
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_class,ColorFilter=Color.parseColor(imgColor)}})
        else
          adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_unknown,ColorFilter=Color.parseColor(imgColor)}})
        end
      end
    end
  end

  lv.onItemLongClick=function(l,v,p,s) 

    项目=tostring(v.Tag.title.text)
    if tostring(drawerBar.subtitle)==StartPath then
      路径=ls[p+1]
    else
      路径=ls[p]
    end

    if 项目=="../" then
      return true 
    else
      onlongclick(路径)
    end
    return true 
  end



  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Tag.title.text)
    if tostring(drawerBar.subtitle)==StartPath then
      路径=ls[p+1] 
      drawerBar.title=路径.Name
    else
      路径=ls[p]
    end

    if 项目=="../" then
      if File(drawerBar.subtitle).getParent()==StartPath then
        drawerBar.title=mainBar.title
      end
      if File(drawerBar.subtitle).getParentFile().exists() then
        SetItem(File(drawerBar.subtitle).getParentFile())
      else
        SetItem(StartPath)
      end
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      onclick(路径)
    else
      onclick(路径) 
    end
  end
  SetItem(childPath)
  lv.setSelection(curPosition);
end


--[[
function ProjectListViewInit(lv,StartPath,callback)
  --  lv.setFastScrollEnabled(true)
  adp=LuaAdapter(activity,item)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    drawerBar.subtitle=tostring(path)--设置当前路径
    if path~=StartPath then--不是根目录则加上../
      adp.add({title="../",subtitle="返回上一级",img={imageResource=R.mipmap.ic_folder,ColorFilter=Color.parseColor(app_theme.colorPrimary)}}) 
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
      
     cal = Calendar.getInstance();
     time = c.lastModified()
     cal.setTimeInMillis(time); 
     filetime=cal.getTime().toLocaleString()

      if path==StartPath then
        imgsrc=StartPath.."/"..c.Name.."/res/drawable/ic_launcher.png"
        imgsrc2=StartPath.."/"..c.Name.."/src/icon.png"
        if File(imgsrc).exists() then
          
        elseif File(imgsrc2).exists() then
          imgsrc=imgsrc2
        else
          imgsrc="icon.png"
        end
        adp.add({title=c.Name.."/",subtitle=filetime,img={src=imgsrc,ColorFilter=0}})
      elseif c.isDirectory() then--如果是文件夹则
        adp.add({title=c.Name.."/",subtitle=filetime,img={imageResource=R.mipmap.ic_folder,ColorFilter=Color.parseColor(app_theme.colorPrimary)}})
      else
        adp.add({title=c.Name,subtitle=filetime,img={imageResource=R.mipmap.file_textfile,ColorFilter=Color.parseColor(app_theme.colorPrimary)}})
      end
    end
  end

  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Tag.title.text)
    if tostring(drawerBar.subtitle)==StartPath then
      路径=ls[p+1] 
      drawerBar.title=路径.Name
    else
      路径=ls[p]
    end

    if 项目=="../" then
      if File(drawerBar.subtitle).getParent()==StartPath then
        drawerBar.title=mainBar.title
        end
      SetItem(File(drawerBar.subtitle).getParentFile())
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      callback(tostring(路径))
      --  ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end]]

