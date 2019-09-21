require "import"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "android.app.*"
import "function.config"
updateTheme()
import "android.graphics.LightingColorFilter"

layout={
  LinearLayout,
  layout_width="fill",
  orientation="vertical",
  {
    Toolbar;
    titleTextColor=0xffffffff;
    subtitleTextColor=0x55ffffff;
    layout_width="fill";
    id="toolBar";
    background=app_theme.colorPrimary;
    Title="Lua参考手册";
  };
  {
    LuaWebView,
    id="doc_web",
    layout_width="fill",
    layout_height="fill"
  },
}
activity.setContentView(loadlayout(layout))

func={}
func["目录"]=function()
  doc_web.loadUrl("file://"..activity.getLuaDir().."/luadoc/contents.html#contents")
end

func["返回"]=function()
  --luajava.clear(doc_web)
  activity.finish()
end

toolMenu=toolBar.Menu
activity.getMenuInflater().inflate(R.menu.menu_webdoc, toolMenu);
toolBar.onMenuItemClick=function(i)
  func[i.toString()]()
end


doc_web.loadUrl("file://"..activity.getLuaDir().."/luadoc/manual.html")
doc_web.setOnKeyListener(View.OnKeyListener{
  onKey=function (view,keyCode,event)
    if ((keyCode == event.KEYCODE_BACK) and view.canGoBack()) then
      view.goBack();
      return true;
    end
    return false
  end
})






