require "import" 
import "android.widget.*" 
import "android.view.*"
import "android.app.ProgressDialog"
import "function.config"
import "com.androlua.util.RootUtil"
local bin_dlg, error_dlg
local function update(s)
  bin_dlg.setMessage(s)
end

local function callback(s,file)
  --  LuaUtil.rmDir(File(activity.getLuaExtDir("bin/.temp")))
  LuaUtil.rmDir(File(file.path.."/bin/compileInfo.xml"))
  LuaUtil.rmDir(File(file.path.."/bin/classes"))
  LuaUtil.rmDir(File(config.rootPath.."/main.lua"))
  LuaUtil.rmDir(File(config.rootPath.."/apk/"))
  LuaUtil.rmDir(File(config.rootPath.."/buildapk/"))
  LuaUtil.rmDir(File(file.path.."/bin/app.apk"))
  LuaUtil.rmDir(File(file.path.."/bin/app_unsign.apk")) 
  LuaUtil.rmDir(File(config.cachePath)) 
  File(config.cachePath).mkdirs()
  
  bin_dlg.hide()
  bin_dlg.Message = ""
  if not s:find("打包成功") then
    if s~="免安装模式" then
      error_dlg.Message = s
      error_dlg.show()
    else 
      activity.newActivity(file.path.."/_src/main.lua")
    end
  else
    if config.是否静默安装 and RootUtil.haveRoot() then
      import "android.content.*" 
      import "android.net.*" 
      import "java.io.File"
      import "xml"
      local stringXmlPath=file.path.."/AndroidManifest.xml"
      local xfile=xml.load(stringXmlPath)
      local file=xfile:find("manifest","android:versionCode")
      local package_name=file["package"]
      local packageManager = activity.getPackageManager();
      local it = packageManager.getLaunchIntentForPackage(package_name);
      activity.startActivity(it);
    else
      import "android.content.*" 
      import "android.net.*" 
      import "java.io.File"
      intent = Intent(Intent.ACTION_VIEW); 
      intent.setDataAndType(Uri.fromFile(File(file.path.."/bin/app_sign.apk")), "application/vnd.android.package-archive")
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      activity.startActivity(intent)
    end
  end
 end

local function create_bin_dlg()
  if bin_dlg then
    return
  end
  bin_dlg = ProgressDialog(activity);
  bin_dlg.setTitle("正在打包");
  bin_dlg.setMax(100);
  bin_dlg.cancelable=false
end

local function create_error_dlg2()
  if error_dlg then
    return
  end
  error_dlg = AlertDialogBuilder(activity)
  error_dlg.Title = "打包出错"
  error_dlg.setPositiveButton("确定", nil)
end


local function create_sign_dlg(func)
  if sign_dlg then
    sign_dlg.setPositiveButton("确定", {onClick=function(v) func(pwEdit) end})
    return sign_dlg
  end

  pwEdit=EditText(activity)
  pwEdit.inputType=0x00000081
  sign_dlg = AlertDialogBuilder(activity)
  sign_dlg.Title = "输入签名密码" 
  sign_dlg.setView(pwEdit)
  sign_dlg.setPositiveButton("确定", {onClick=function(v) func(pwEdit) end})
  sign_dlg.setNegativeButton("取消", nil)
  return sign_dlg
end

local function buildApk(file,param)

  require"import"
  import"function.config"
  import "java.io.File"
  import "function.console"
  import "java.io.PrintWriter"
  import "java.util.ArrayList"
  import "com.mythoi.androluaj.util.Utils"
  import "com.mythoi.androluaj.util.DealClasses"
  import "function.Util"
  import "com.mythoi.androluaj.service.HideService"
  import "android.content.Intent"
  import "android.os.Bundle"
  import "xml" 
  local apkFolder=config.rootPath.."/apk/"
  local apk里的so路径=activity.ApplicationInfo.nativeLibraryDir.."/"
  local apk里的lua路径=activity.Application.MdDir.."/"
  local 错误=StringBuffer()
  local files路径=activity.getFilesDir().path.."/"
  --初始化路径
  File(config.rootPath.."/buildapk/libs").mkdirs()
  File(config.rootPath.."/buildapk/resources").mkdirs()
  File(config.rootPath.."/buildapk/assets").mkdirs()
  File(config.rootPath.."/apk").mkdirs()
  File(file.path.."/libs/jar").mkdirs()
  File(file.path.."/libs/aar").mkdirs()
  File(file.path.."/libs/dex").mkdirs()
  File(file.path.."/libs/so").mkdirs()
  File(file.path.."/bin/classes").mkdirs()
  File(file.path.."/bin/libs").mkdirs()
  File(file.path.."/gen").mkdirs()
  File(file.path.."/assets").mkdirs()

  --初始化apt
  chmod = String{"chmod", "744",files路径.."apt"}
  Runtime.getRuntime().exec(chmod);

  if File(file.path.."/src/init.lua").exists() then
    dofile(file.path.."/src/init.lua")
  elseif File(file.path.."/assets/init.lua").exists() then
    dofile(file.path.."/assets/init.lua")
  end

  local function buildLua()

    local function checklib(path)

      --[[   if then
        return
      end]]

      local f = io.open(path)
      local s = f:read("*a")
      f:close()

      for m, n in s:gmatch("require *%(? *\"([%w_]+)%.?([%w_]*)") do
        cp = string.format("lib%s.so", m)
        if n ~= "" then
          lp = string.format("%s/%s.lua", m, n)
        else
          lp = string.format("%s.lua", m)
        end

        if not File(apkFolder.."lib/armeabi-v7a/"..cp).exists() then
          if File(config.soLib依赖..cp).exists() then
            LuaUtil.copyDir(config.soLib依赖..cp,apkFolder.."lib/armeabi-v7a/"..cp)
          elseif File(apk里的so路径..cp).exists() then
            LuaUtil.copyDir(apk里的so路径..cp,apkFolder.."lib/armeabi-v7a/"..cp)
          end 

        end

        if not File(apkFolder.."lua/"..lp).exists() then
          if lp=="loadlayout.lua" then 
            console.build(apk里的lua路径..lp,apkFolder.."lua/"..lp)
            checklib(apk里的lua路径..lp)
          elseif File(config.luaLib依赖..lp).exists() then
            console.build(config.luaLib依赖..lp,apkFolder.."lua/"..lp)
            checklib(config.luaLib依赖..lp)
          elseif File(apk里的lua路径..lp).exists() then
            console.build(apk里的lua路径..lp,apkFolder.."lua/"..lp) 
            checklib(apk里的lua路径..lp)
          end 

        end

      end

      for m, n in s:gmatch("import *%(? *\"([%w_]+)%.?([%w_]*)") do
        cp = string.format("lib%s.so", m) 
        if n ~= "" then
          lp = string.format("%s/%s.lua", m, n)
        else
          lp = string.format("%s.lua", m)
        end


        if not File(apkFolder.."lib/armeabi-v7a/"..cp).exists() then
          if File(config.soLib依赖..cp).exists() then 
            LuaUtil.copyDir(config.soLib依赖..cp,apkFolder.."lib/armeabi-v7a/"..cp)
          elseif File(apk里的so路径..cp).exists() then 
            LuaUtil.copyDir(apk里的so路径..cp,apkFolder.."lib/armeabi-v7a/"..cp)
          end
        end

        if not File(apkFolder.."lua/"..lp).exists() then
          if lp=="loadlayout.lua" then 
            console.build(apk里的lua路径..lp,apkFolder.."lua/"..lp)
            checklib(apk里的lua路径..lp)
          elseif File(config.luaLib依赖..lp).exists() then
            console.build(config.luaLib依赖..lp,apkFolder.."lua/"..lp)
            checklib(config.luaLib依赖..lp)
          elseif File(apk里的lua路径..lp).exists() then
            console.build(apk里的lua路径..lp,apkFolder.."lua/"..lp)
            checklib(apk里的lua路径..lp)
          end 

        end
      end
    end

    local function addDir(dir, f) 
      local ls = f.listFiles()
      for n = 0, #ls - 1 do
        local name = ls[n].getName()
        local luapath = ls[n].getPath() 
        if name:find("%.lua$") then 
          if dir..name=="main.lua" and param.isLog and not param.isNotIntall then

            --读文件
            local fi=io.input(luapath)
            local 写入内容="luajava.bindClass(\"adrt.LogSender\").sendLog(activity) "..io.read("*a")
            io.close()


            --写文件
            local fi=io.output(config.rootPath.."/main.lua")
            io.write(写入内容)
            io.flush()
            io.close()

            luapath=config.rootPath.."/main.lua"

          end
          local path, err = console.build(luapath,apkFolder.."assets/"..dir..name) 
          if not path then
            错误.append(err.."\n")
          else 
            checklib(luapath)
          end
        elseif name:find("%.apk$") or name:find("%.luac$") or name:find("^%.") then 
        elseif name:find("%.aly$") then 
          local path, err = console.build_aly(luapath,apkFolder.."assets/"..dir..string.gsub(name,"%.aly$",".lua")) 
          if not path then
            错误.append(err.."\n")
          end
        elseif ls[n].isDirectory() then
          addDir(dir .. name .. "/", ls[n])
        elseif not name:find("%.java$") then
          LuaUtil.copyDir(luapath,apkFolder.."assets/"..dir..name)
        end
      end
    end

    this.update("正在编译Lua...") 
    addDir("",File(file.path.."/src"))
    if File(config.soLib依赖.."libluajava.so").exists() then 
      LuaUtil.copyDir(config.soLib依赖.."libluajava.so",apkFolder.."lib/armeabi-v7a/libluajava.so")
    elseif File(apk里的so路径.."libluajava.so").exists() then 
      LuaUtil.copyDir(apk里的so路径.."libluajava.so",apkFolder.."lib/armeabi-v7a/libluajava.so")
    end
  end


  local function aarDeal()

    local function start(aarFile)
      if not aarFile.exists() then
        return
      end
      LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk/libs","classes.jar")
      LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk","libs")
      os.rename(config.rootPath.."/buildapk/libs/classes.jar",config.rootPath.."/buildapk/libs/"..string.gsub(aarFile.name,"%.aar$",".jar"))
      LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk/resources/"..aarFile.name,"res")
      LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk/resources/"..aarFile.name,"R.txt")
      LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk/resources/"..aarFile.name,"AndroidManifest.xml")
      LuaUtil.unZip(aarFile.path,config.rootPath.."/buildapk","assets")
    end

    this.update("正在处理aar...")
    aarList=File(file.path.."/libs/aar").listFiles()
    aarTable=luajava.astable(aarList)
    for k,v in pairs(aarTable) do
      start(v)
    end

    if compiles then

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
      end

    end

  end


  local function buildRes()

    local aarRess=File(config.rootPath.."/buildapk/resources/").listFiles()
    local aarRessTable=luajava.astable(aarRess)

    local function createRjava()

      local pkgs=""
      local comm0=ArrayList();
      comm0.add(files路径.."apt");
      comm0.add("package");
      comm0.add("--auto-add-overlay")
      comm0.add("-m")
      comm0.add("-J");
      comm0.add(file.path.."/gen/");
      comm0.add("-I");
      comm0.add(config.Android依赖);
      comm0.add("-M");
      comm0.add(file.path.."/AndroidManifest.xml"); 
      comm0.add("-S")
      comm0.add(file.path.."/res/"); 
      for k,v in pairs(aarRessTable) do
        comm0.add("-S")
        comm0.add(v.path.."/res/")

        if File(v,"R.txt").exists() then 
          local am=xml.load(v.path.."/AndroidManifest.xml")
          local pkg= am.package 
          pkgs=pkg..":"..pkgs 
        end

      end 
      comm0.add("--extra-packages") 
      comm0.add(pkgs)
      comm0.add("--no-version-vectors")
      --[[local args=String{
        files路径.."apt",
        "package", "-m",
        "--extra-packages","com.occ.r:com.occ.r2:com.occ.r3",
        "-S",v.path.."/res/",
        "-J",file.path.."/gen/",
        "-I",config.Android依赖,
        "-M",v.path.."/AndroidManifest.xml", 
      } ]]
      local args=comm0.toArray(String[comm0.size()])
      local result=String(Utils.runshell(args));--生成很多R.java

      if result.contains("ERROR:") or not result.contains("Writing all files...") or result.contains("error:") then 
        if result.contains("ERROR:")then
          错误.append(result.substring(result.indexOf("ERROR:")))
        else
          if (result.indexOf("error:") - #file.path - 70) < 0 then
            错误.append(result.substring(0))
          else
            错误.append(result.substring(result.indexOf("error:") - #file.path - 70))
          end
        end
        if 错误.toString()~="" then
          return 错误
        end
      end 
      return 错误
    end 

    local function start() 
      local comm=ArrayList();
      comm.add(files路径.."apt");
      comm.add("package");
      comm.add("-v");
      comm.add("-f");
      comm.add("--auto-add-overlay");
      comm.add("-m");
      comm.add("-S");
      comm.add(file.path.."/res/"); 
      for k,v in pairs(aarRessTable) do
        comm.add("-S");
        comm.add(v.path.."/res/");
      end
      comm.add("-J");
      comm.add(file.path.."/gen/");
      --      comm.add("-A");
      --      comm.add(file.path.."/assets/");
      comm.add("-M"); 
      comm.add(file.path.."/AndroidManifest.xml"); 
      comm.add("-I");
      comm.add(config.Android依赖);
      comm.add("-F");
      comm.add(file.path.."/bin/app.apk");
      comm.add("--no-version-vectors");
      local args=comm.toArray(String[comm.size()])
      local result=String(Utils.runshell(args));--生成很多R.java      
      if result.contains("ERROR:") or not result.contains("Writing all files...") or result.contains("error:") then
        if result.contains("ERROR:")then
          错误.append(result.substring(result.indexOf("ERROR:")))
        else
          if (result.indexOf("error:") - #file.path - 70) < 0 then
            错误.append(result.substring(0))
          else
            错误.append(result.substring(result.indexOf("error:") - #file.path - 70))
          end
        end 
      end
      return 错误
    end

    this.update("正在生成R.java...")
    if createRjava().toString()~="" then 
      return 错误
    end

    this.update("正在构建资源...")
    if start().toString()~="" then 
      return 错误
    end

  end

  local function buildJava()
    local result=DealClasses().deal(file.path)
    if result~="构建成功" then
      错误.append(result)
    end
    import "org.eclipse.jdt.internal.compiler.batch.Main"
    this.update("正在编译Java...")
    local main=Main(PrintWriter(System.out),PrintWriter(System.err), false, null, null);
    local command=StringBuffer()
    local jarFiles=File(file.path.."/libs/jar/").listFiles()
    local jarFiles2=File(config.rootPath.."/buildapk/libs/").listFiles()

    for k,v in pairs(luajava.astable(jarFiles)) do
      command.append("-classpath "..v.path.." "); 
    end

    for k,v in pairs(luajava.astable(jarFiles2)) do
      command.append("-classpath "..v.path.." ");
    end
    command.append(file.path.."/src/".." ");
    command.append(file.path.."/gen/".." ");
    if File(file.path.."/_src/").exists() then
      command.append(file.path.."/_src/".." ");
    end
    if main.compile("-verbose -nowarn -proc:none -log "..file.path.."/bin/compileInfo.xml".." -classpath "..config.Android依赖.." "..command.toString().." -source 1.7 -target 1.7 -time -g -d "..file.path.."/bin/classes/",PrintWriter(config.rootPath.."/log"),PrintWriter(config.rootPath.."/error")) then
      --  print("java编译成功")
    else 
      错误.append(读取文件(config.rootPath.."/error"))
    end
  end


  local function buildDex()
    this.update("正在构建dex...")
    import "com.duy.dx.command.dexer.Main"
    import "com.mythoi.developerApp.build.DexUtil"
    local array=ArrayList()
    array.add("--verbose");
    array.add("--no-strict");
    array.add("--output="..file.path.. "/bin/classes/classes.dex");
    --array.add("--num-threads=12");
    array.add(file.path.."/bin/classes/");
    local command=array.toArray(String[array.size()]);
    Main.main(command);

    local jarFiles=File(file.path.."/libs/jar/").listFiles()
    local jarFiles2=File(config.rootPath.."/buildapk/libs/").listFiles()
    local jarConut=#jarFiles+#jarFiles2
    local curIdx=0
    for k,v in pairs(luajava.astable(jarFiles)) do
      if not File(file.path.."/bin/libs/"..v.name..".dex").exists() then
        this.update("正在构建dex("..curIdx.."/"..jarConut..")..."); 
        curIdx=curIdx+1
        local array2 = ArrayList(); 
        array2.add("--verbose");
        array2.add("--no-strict");
        array2.add("--no-files");
        array2.add("--output="..file.path.."/bin/libs/"..v.name..".dex"); 
        --array2.add("--num-threads=12");
        array2.add(v.path);
        local command2=array2.toArray(String[array2.size()]);
        Main.main(command2);
      end 
    end

    for k,v in pairs(luajava.astable(jarFiles2)) do
      if not File(file.path.."/bin/libs/"..v.name..".dex").exists() then 
        this.update("正在构建dex("..curIdx.."/"..jarConut..")..."); 
        curIdx=curIdx+1
        local array2 = ArrayList(); 
        array2.add("--verbose");
        array2.add("--no-strict");
        array2.add("--no-files");
        array2.add("--output="..file.path.."/bin/libs/"..v.name..".dex"); 
        --array2.add("--num-threads=12");
        array2.add(v.path);
        local command2=array2.toArray(String[array2.size()]);
        Main.main(command2);
      end 
    end 

    this.update("正在合并dex...")
    local dexList=ArrayList();
    if not param.isLog or (param.isLog and not param.isNotIntall) then 
      dexList.add(config.ALuaDex依赖);
    end
    if param.isLog and not param.isNotIntall then
      dexList.add(files路径.."log.dex");
    end
    dexList.add(files路径.."lj.dex");
    dexList.add(file.path.."/bin/classes/classes.dex");
    local dexFiles=File(file.path.."/bin/libs/").listFiles()
    local dexFiles2=File(file.path.."/libs/dex/").listFiles()
    for k,v in pairs(luajava.astable(dexFiles)) do
      if File(file.path.."/libs/jar/"..String(v.name).replace(".dex", "")).exists() or File(config.rootPath.."/buildapk/libs/"..String(v.name).replace(".dex", "")).exists() then
        dexList.add(v.path);
      end
    end

    for k,v in pairs(luajava.astable(dexFiles2)) do
      dexList.add(v.path);
    end

    DexUtil.mergeDex(dexList,file.path.."/bin/classes.dex");

    return 错误
  end


  local function createApk()
    this.update("正在打包apk...")
    LuaUtil.copyDir(file.path.."/libs/so",apkFolder.."lib/")
    LuaUtil.copyDir(file.path.."/assets",apkFolder.."assets/")
    import "com.android.sdklib.build.ApkBuilder"
    builder = ApkBuilder(File(file.path.."/bin/app_unsign.apk"),
    File(file.path.."/bin/app.apk"), 
    File(file.path.."/bin/classes.dex"), 
    nil,nil)
    builder.addSourceFolder(File(apkFolder))

    local jarFiles=File(file.path.."/libs/jar/").listFiles()
    local jarFiles2=File(config.rootPath.."/buildapk/libs/").listFiles()

    for k,v in pairs(luajava.astable(jarFiles)) do
      builder.addResourcesFromJar(v);
    end

    for k,v in pairs(luajava.astable(jarFiles2)) do
      builder.addResourcesFromJar(v);
    end

    builder.sealApk();
  end


  local function signApk() 
    this.update("正在签名apk...")
    import "kellinwood.security.zipsigner.ZipSigner"
    local sign=ZipSigner()
    if not param.isLog and config.是否使用私签 and config.签名key路径 then
      import "java.security.KeyStore"
      import "kellinwood.security.zipsigner.optional.KeyStoreFileManager"
      import "kellinwood.security.zipsigner.optional.CustomKeySigner"
      CustomKeySigner.signZip(sign,config.签名key路径,param.keyPw,param.alias,param.keyPw,"SHA1withRSA",file.path.."/bin/app_unsign.apk",file.path.."/bin/app_sign.apk")
    else
      sign.setKeymode(ZipSigner.KEY_TESTKEY)
      sign.signZip(file.path.."/bin/app_unsign.apk",file.path.."/bin/app_sign.apk")
      LuaUtil.copyDir(file.path.."/bin/app_sign.apk",config.cachePath.."/temp.apk");
    end
  end

  local function installApk()
    if not config.是否静默安装 then
      return
    end
    import "com.androlua.util.RootUtil"
    local isRoot=RootUtil.haveRoot()--检测是否有root，返回true和false
    if not isRoot then
      return
    end
    this.update("正在安装apk...")
    local resultMsg=RootUtil.execRootCmd("pm install -r "..config.cachePath.."/temp.apk")--返回执行结果为文本型
  end

  function buildAll()
    local status, err = pcall(buildLua)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "Lua编译出错："..错误.toString(),file
    end


    local status, err = pcall(aarDeal)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "aar处理出错："..错误.toString(),file
    end


    local status, err = pcall(buildRes)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "资源编译出错："..错误.toString(),file
    end


    local status, err = pcall(buildJava)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "Java编译出错："..错误.toString(),file
    end


    local status, err = pcall(buildDex) 
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "dex构建出错："..错误.toString(),file
    end


    local status, err = pcall(createApk)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "apk打包出错："..错误.toString(),file
    end

    local status, err = pcall(signApk)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "apk签名出错："..错误.toString(),file
    end

    local status, err = pcall(installApk)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "apk安装出错："..错误.toString(),file
    end

  end


  function buildJavaAndDex()
    local status, err = pcall(aarDeal)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "aar处理出错："..错误.toString(),file
    end

    local status, err = pcall(buildRes)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "R.java生成出错："..错误.toString(),file
    end

    local status, err = pcall(buildJava)
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "Java编译出错："..错误.toString(),file
    end


    local status, err = pcall(buildDex) 
    if not status then
      错误.append(err)
    end
    if 错误.toString()~="" then
      return "dex构建出错："..错误.toString(),file
    end
    LuaUtil.copyDir(config.luaLib依赖,file.path.."/_src")
    LuaUtil.copyDir(file.path.."/assets",file.path.."/_src")
    LuaUtil.copyDir(file.path.."/src",file.path.."/_src") 
    LuaUtil.copyDir(file.path.."/bin/classes.dex",file.path.."/_src/libs/classes_temp.dex") 
    LuaUtil.copyDir(file.path.."/bin/app.apk",file.path.."/_src/libs/res.jar") 
    local intent=Intent(activity,HideService().getClass())
    activity.startService(intent) 
  end

  if param.isNotIntall and param.isLog then
    local result=buildJavaAndDex()
    if result~=nil then
      return result,file
    else
      return "免安装模式",file
    end
  else
    local result=buildAll()
    if result~=nil then
      return result,file
    else
      return "打包成功",file
    end
  end

end





local function build(file,isLog) 

  local p = {}
  local e, s = pcall(loadfile(file.path .. "/src/init.lua", "bt", p))
  if e then
    create_error_dlg2()
    create_bin_dlg()
    local isNotIntall=config.是否免安装运行 
    if config.是否使用私签 and not isLog then 
      create_sign_dlg(function(pwEdit)
        local alias=""
        local status,err=pcall(
        function()
          import "java.security.KeyStore"
          import "kellinwood.security.zipsigner.optional.KeyStoreFileManager" 
          local jks=KeyStoreFileManager.loadKeyStore(config.签名key路径,nil)
          alias=jks.aliases().nextElement()
          jks.getKey(alias,String(pwEdit.text).toCharArray())
        end)
        if not status then
          Toast.makeText(activity, "密码错误或私签不存在", Toast.LENGTH_SHORT).show()
          return
        end
        bin_dlg.show() 
        activity.newTask(buildApk, update, callback).execute{file,{alias=alias,keyPw=String(pwEdit.text).toCharArray(),isLog=isLog,isNotIntall=isNotIntall}}
      end).show()
    else 
      bin_dlg.show() 
      activity.newTask(buildApk, update, callback).execute{file,{isLog=isLog,isNotIntall=isNotIntall}}
    end
  else
    Toast.makeText(activity, "工程配置文件init.lua错误." .. s, Toast.LENGTH_SHORT).show()
  end

end

--bin(activity.getLuaExtDir("project/demo").."/")
return build