require "import" 
import"function.config"
updateTheme()
import "android.view.*"
import "android.graphics.LightingColorFilter"
import "com.mythoi.androluaj.R"
import "android.content.Context"
import "android.content.ClipData"
import "android.widget.Toast"
import "java.util.ArrayList"
import "android.util.Log"
import "android.content.DialogInterface"
import "android.app.AlertDialog"
import "android.widget.EditText"
import "android.widget.ListView"
import "android.widget.LinearLayout"
import "android.widget.Toolbar"
import "com.mythoi.androluaj.util.*"

layout={
  LinearLayout;
  layout_width="fill";
  layout_height="fill";
  orientation="vertical";
  {
    Toolbar;
    layout_width="fill";
    titleTextColor=0xffffffff;
    subtitleTextColor=0x55ffffff;
    id="logBar";
    title="LogCat";
    background=app_theme.colorPrimary;
  }; 
  {
    ListView;
    fastScrollEnabled="true";
    id="mListView";
    layout_width="fill";
    layout_height="fill"; 
  };
}

activity.setContentView(loadlayout(layout))


mArrayList2=ArrayList()
LogFilterType=""
LogFilterType2=""
if Utils.mArrayList.size() == 0 then
  mArrayList2.add("软件运行才能看到log输出");
else
  mArrayList2.addAll(Utils.mArrayList);
end
mLogAdapter=LogAdapter(activity, R.layout.log_listview_item, mArrayList2);
mListView.setAdapter(mLogAdapter);

mListView.setOnItemLongClickListener{

  onItemLongClick=function( p1, p2, p3, p4)

    cm = activity. getSystemService(Context.CLIPBOARD_SERVICE);
    mClipData = ClipData.newPlainText("Label",p2.text)
    cm.setPrimaryClip(mClipData);
    Toast.makeText(activity, "已复制", 0).show();
    return false;
  end
}

A().setNotifyListener({ 
  getNotify=function(curLogLine)
    if (String(curLogLine).contains(LogFilterType) and String(curLogLine).contains(LogFilterType2)) then
      mArrayList2.remove("软件运行才能看到log输出");
      mArrayList2.add(curLogLine);
      mLogAdapter.notifyDataSetChanged();
      mListView.setSelection(mListView.getBottom());
    end
  end
});


menuFunc={}
menuFunc.Logd=function()

  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains(" D ") and String(Utils.mArrayList.get(i)).contains("     :") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType =" D ";
  LogFilterType2 ="     :";


end
menuFunc.Logi=function()


  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains(" I ") and String(Utils.mArrayList.get(i)).contains("     :") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType =" I ";
  LogFilterType2 ="     :";


end

menuFunc.Logw=function()


  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains(" W ") and String(Utils.mArrayList.get(i)).contains("     :") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType =" W ";
  LogFilterType2 ="     :";


end

menuFunc.Loge=function()

  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains(" E ") and String(Utils.mArrayList.get(i)).contains("     :") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType =" E ";
  LogFilterType2 ="     :";


end

menuFunc.Logv=function()

  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains(" V ") and String(Utils.mArrayList.get(i)).contains("     :") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType =" V ";
  LogFilterType2 ="     :";

end


menuFunc.AndroidRuntime=function()

  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains("AndroidRuntime") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType = "AndroidRuntime";
  LogFilterType2 = "";


end

menuFunc.Causedby=function()

  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains("Caused by") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType = "Caused by";
  LogFilterType2 = "";


end


menuFunc.Systemout=function()

  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains("System.out") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType = "System.out";
  LogFilterType2 = "";

end

menuFunc.Systemerr=function()

  mArrayList2.clear();
  mLogAdapter.notifyDataSetChanged();
  for i=0,#Utils.mArrayList-1 do
    if String(Utils.mArrayList.get(i)).contains("System.err") then
      mArrayList2.add(String(Utils.mArrayList.get(i)));
    end
    mLogAdapter.notifyDataSetChanged();
  end 
  LogFilterType = "System.err";
  LogFilterType2 = "";

end

menuFunc.全部=function()
  mArrayList2.clear();
  mArrayList2.addAll(Utils.mArrayList);
  if mArrayList2.size() == 0 then
    mArrayList2.add("软件运行才能看到log输出");
  end
  mLogAdapter.notifyDataSetChanged();
  LogFilterType = "";
  LogFilterType2 = "";

end

menuFunc.暂停=function()
  暂停开始.setTitle("开始");
  LogCatReceiver.isStop = true;
end

menuFunc.开始=function()
  暂停开始.setTitle("暂停");
  LogCatReceiver.isStop = false;
end

menuFunc.清空=function()

  mArrayList2.clear();
  Utils.mArrayList.clear();
  mArrayList2.add("软件运行才能看到log输出");
  mLogAdapter.notifyDataSetChanged();
  LogFilterType = "";
  LogFilterType2 = "";


end

menuFunc.过滤=function()
  alert = AlertDialog.Builder(activity);
  alert.setTitle("自定义过滤");
  edit= EditText(activity);
  edit.setHint("关键字");
  alert.setView(edit);
  alert.setPositiveButton("过滤",DialogInterface.OnClickListener{

    onClick=function(p1,p2)
      mArrayList2.clear();
      mLogAdapter.notifyDataSetChanged();
      for i=0,#Utils.mArrayList-1 do
        if (String(Utils.mArrayList.get(i)).contains(edit.text)) then
          mArrayList2.add(String(Utils.mArrayList.get(i)));
          mLogAdapter.notifyDataSetChanged();
        end
        LogFilterType = edit.text;
        LogFilterType2 = "";
      end
    end
  });
  alert.setNegativeButton("取消", null);
  alert.show();
end
logMenu=logBar.Menu
activity.getMenuInflater().inflate(R.menu.menu_log,logMenu);
--logBar.getChildAt(1).getOverflowIcon().setColorFilter(LightingColorFilter(0xffffffff,0xffffffff))
logBar.onMenuItemClick=function(i)
  option=string.gsub(i.toString()," ", "")
  menuFunc[option]()
end
暂停开始=logMenu.getItem(1)