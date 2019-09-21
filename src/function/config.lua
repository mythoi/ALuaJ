require "import" 
import"mixtureJava"
import "android.graphics.Color"
import "android.os.Environment"
import "java.io.File"
import "android.preference.PreferenceManager"
import "com.mythoi.androluaj.activity.SettingActivity"

function getSharedData(key,defValue) 
  local pre = PreferenceManager.getDefaultSharedPreferences(activity);
  local ret = pre.getAll().get(key);
  if ret==nil then
    return defValue
  else
    return ret
  end
end


function getUIDesignerShareData(delval)
  local preferences=activity.getSharedPreferences("UIDesigner",0)
  preferences.getString("PREF_XMLDESIGNER_FILE", delval);
end


function setUIDesignerShareData(val)
  local preferences=activity.getSharedPreferences("UIDesigner",0)
  local editxml=preferences.edit()
  editxml.putString("PREF_XMLDESIGNER_FILE", val)
  editxml.commit()
end




function updateTheme()
  local themeColor=activity.getSharedData("themeColor","#3F51B5")
  SettingActivity.themeColor=themeColor
  app_theme={
    colorPrimary=themeColor; 
  }
  if themeColor=="#222222" then
    activity.setTheme(R.style.AppTheme2)
    activity.getWindow().setStatusBarColor(Color.parseColor(app_theme.colorPrimary)); 
  else
    activity.setTheme(R.style.AppTheme)
    activity.getWindow().setStatusBarColor(Color.parseColor(app_theme.colorPrimary)); 
  end
end

config={
  环境根路径=Environment.getExternalStorageDirectory().toString().."/.alj";
  pluginPath=Environment.getExternalStorageDirectory().toString().."/ALuaj/plugin";
  projectPath=Environment.getExternalStorageDirectory().toString().."/ALuaj/Project";
  cachePath=Environment.getExternalStorageDirectory().toString().."/ALuaj/cache";
  rootPath=Environment.getExternalStorageDirectory().toString().."/ALuaj";
  Android依赖=getSharedData("Android",Environment.getExternalStorageDirectory().toString().."/.alj/Android/android.jar");
  Maven依赖=getSharedData("m2repositoryPath",Environment.getExternalStorageDirectory().toString().."/.alj/Android/m2repository/");
  ALuaDex依赖=getSharedData("ALua",Environment.getExternalStorageDirectory().toString().."/.alj/AndroLua/androlua.dex");
  luaLib依赖=getSharedData("luaLib",Environment.getExternalStorageDirectory().toString().."/.alj/AndroLua/lua/");
  soLib依赖=getSharedData("soLib",Environment.getExternalStorageDirectory().toString().."/.alj/AndroLua/lib/");
  签名key路径=getSharedData("keyPath",nil);
  是否使用私签=getSharedData("isKey",false);
  是否免安装运行=getSharedData("isNoInstall",false);
  是否静默安装=getSharedData("isjmInstall",false);
  edit字体颜色=getSharedData("LuaEditTextColor","#ff000000");
  edit背景颜色=getSharedData("LuaEditBgColor","#ffffffff");
}

File(config.rootPath).mkdirs()
File(config.pluginPath).mkdirs()
File(config.cachePath).mkdirs()
File(config.projectPath).mkdirs()
function updateConfig()
  config={
    环境根路径=Environment.getExternalStorageDirectory().toString().."/.alj";
    projectPath=Environment.getExternalStorageDirectory().toString().."/ALuaj/Project";
    cachePath=Environment.getExternalStorageDirectory().toString().."/ALuaj/cache";
    rootPath=Environment.getExternalStorageDirectory().toString().."/ALuaj";
    Android依赖=getSharedData("Android",Environment.getExternalStorageDirectory().toString().."/.alj/Android/android.jar");
    Maven依赖=getSharedData("m2repositoryPath",Environment.getExternalStorageDirectory().toString().."/.alj/Android/m2repository/");
    ALuaDex依赖=getSharedData("ALua",Environment.getExternalStorageDirectory().toString().."/.alj/AndroLua/androlua.dex");
    luaLib依赖=getSharedData("luaLib",Environment.getExternalStorageDirectory().toString().."/.alj/AndroLua/lua/");
    soLib依赖=getSharedData("soLib",Environment.getExternalStorageDirectory().toString().."/.alj/AndroLua/lib/");
    签名key路径=getSharedData("keyPath",nil);
    是否使用私签=getSharedData("isKey",false);
    是否免安装运行=getSharedData("isNoInstall",false);
    是否静默安装=getSharedData("isjmInstall",false);
    edit字体颜色=getSharedData("LuaEditTextColor","#ff000000");
    edit背景颜色=getSharedData("LuaEditBgColor","#ffffffff");
  }
end