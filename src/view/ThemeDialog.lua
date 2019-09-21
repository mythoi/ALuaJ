require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.PorterDuff"
import "android.graphics.PorterDuffColorFilter"
import "layout"
--activity.setTitle('AndroLua+')
--activity.setTheme(android.R.style.Theme_Holo_Light)
--本颜色选择器由YuXuan原创
--一个正式的颜色选择器

--定义一个函数，可以改变card的背景颜色
function CircleButton(view,InsideColor)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  -- drawable.setCornerRadii({360,360,360,360,360,360,360,360});
  view.setBackgroundDrawable(drawable)
end


--创建布局
yuxuan={
  LinearLayout;
  orientation="vertical";
  layout_height="fill";
  layout_width="fill";
  gravity="center",
  --background="#808080",
  {
    CardView,
    layout_height="150dp";
    layout_width="fill";
    id="mmp5",
  };

  {
    TextView,
    text="#FF000000",
    id="mmp4",
    layout_width="80%w";
    layout_height="50dp";
    gravity="center",
  };

  --滑条零
  {
    LinearLayout;
    visibility="gone";
    orientation="horizontal";
    layout_height="50dp";
    layout_width="fill";
    gravity="center",
    {
      TextView,
      text="A",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
    {
      SeekBar;
      id="seek_Ap";
      layout_width="70%w";
      layout_height="50dp";
    },
    {
      TextView,
      text="FF",
      id="mmp6",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
  },


  --滑条一
  {
    LinearLayout;
    orientation="horizontal";
    layout_height="50dp";
    layout_width="fill";
    gravity="center",
    {
      TextView,
      text="R",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
    {
      SeekBar;
      id="seek_red";
      layout_width="70%w";
      layout_height="50dp";
    },
    {
      TextView,
      text="00",
      id="mmp1",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
  },


  --滑条二
  {
    LinearLayout;
    orientation="horizontal";
    layout_height="50dp";
    layout_width="fill";
    gravity="center",
    {
      TextView,
      text="G",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
    {
      SeekBar;
      id="seek_green";
      layout_width="70%w";
      layout_height="50dp";
    },
    {
      TextView,
      text="00",
      id="mmp2",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
  },

  --滑条三
  {
    LinearLayout;
    orientation="horizontal";
    layout_height="50dp";
    layout_width="fill";
    gravity="center",
    {
      TextView,
      text="B",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
    {
      SeekBar;
      id="seek_blue";
      layout_width="70%w";
      layout_height="50dp";
    },
    {
      TextView,
      text="00",
      id="mmp3",
      layout_width="5%w";
      layout_height="50dp";
      gravity="center",
    };
  },
}

function ThemeDialog(click1,click2,click3)
  local dialog=AlertDialog.Builder(activity)
  dialog.setView(loadlayout(yuxuan))
  dialog.setPositiveButton("设置主题",{onClick=function()
      click1(mmp4.getText())
    end})
  dialog.setNegativeButton("夜间模式",{onClick=function() click2() end})
  dialog.setNeutralButton("恢复默认",{onClick=function() click3() end})
  dialog.show()

  seek_Ap.setMax(255);
  seek_Ap.setProgress(255);

  seek_red.setMax(255);
  seek_red.setProgress(1);

  seek_green.setMax(255);
  seek_green.setProgress(1);

  seek_blue.setMax(255);
  seek_blue.setProgress(1);




  --修改SeekBar滑条颜色
  --尝试修改为透明试试
  seek_red.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFFFF0000,PorterDuff.Mode.SRC_ATOP))
  seek_red.Thumb.setColorFilter(PorterDuffColorFilter(0xFFFF0000,PorterDuff.Mode.SRC_ATOP))

  seek_green.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF00FF00,PorterDuff.Mode.SRC_ATOP))
  seek_green.Thumb.setColorFilter(PorterDuffColorFilter(0xFF00FF00,PorterDuff.Mode.SRC_ATOP))

  seek_blue.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF0000FF,PorterDuff.Mode.SRC_ATOP))
  seek_blue.Thumb.setColorFilter(PorterDuffColorFilter(0xFF0000FF,PorterDuff.Mode.SRC_ATOP))





  CircleButton(mmp5,0xFF000000)


  seek_Ap.setOnSeekBarChangeListener{
    onProgressChanged=function(SeekBar,progress)

      progress=progress+1
      e=Integer.toHexString(progress-1)
      e=string.upper(e)
      if #e==1 then
        e="0"..e
        mmp6.setText(e)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)
      else
        mmp6.setText(e)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)

      end
    end
  }








  --SeekBar绑定监听(一个接口，三个方法)
  seek_red.setOnSeekBarChangeListener{
    onStartTrackingTouch=function()
      -- 弹出消息("拖动")
    end,
    onStopTrackingTouch=function()

    end,
    onProgressChanged=function(SeekBar,progress)

      progress=progress+1
      a=Integer.toHexString(progress-1)
      a=string.upper(a)
      if #a==1 then
        a="0"..a
        mmp1.setText(a)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)
      else
        mmp1.setText(a)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)
      end
    end
  }


  seek_green.setOnSeekBarChangeListener{
    onStartTrackingTouch=function()
      -- 弹出消息("拖动")
    end,
    onStopTrackingTouch=function()

    end,
    onProgressChanged=function(SeekBar,progress)

      progress=progress+1
      b=Integer.toHexString(progress-1)
      b=string.upper(b)
      if #b==1 then
        b="0"..b
        mmp2.setText(b)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)
      else
        mmp2.setText(b)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)
      end


    end
  }

  seek_blue.setOnSeekBarChangeListener{
    onStartTrackingTouch=function()
      -- 弹出消息("拖动")
    end,
    onStopTrackingTouch=function()

    end,
    onProgressChanged=function(SeekBar,progress)

      progress=progress+1
      c=Integer.toHexString(progress-1)
      c=string.upper(c)
      if #c==1 then
        c="0"..c
        mmp3.setText(c)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)
      else
        mmp3.setText(c)
        d=mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
        mmp4.setText("#"..d)
        ys=int("0x"..d)
        CircleButton(mmp5,ys)
      end

    end
  }

  --获取颜色
  mmp4.onClick=function(v)
    import "android.content.*"
    --2.设置文本内容(只能为字符串类型)
    a=mmp4.getText()
    --3.活动开始
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(a)
    --4.获取剪切板内容
    b=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
    --5.比较剪切板与复制内容，得出反馈结果
    if b==a then
      Toast.makeText(activity,"颜色已复制",0).show()
    else
      Toast.makeText(activity,"颜色复制失败",0).show()
    end
  end

  --获取颜色
  mmp5.onClick=function(v)
    import "android.content.*"
    --2.设置文本内容(只能为字符串类型)
    a=mmp4.getText()
    --3.活动开始
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(a)
    --4.获取剪切板内容
    b=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
    --5.比较剪切板与复制内容，得出反馈结果
    if b==a then
      Toast.makeText(activity,"颜色已复制",0).show()
    else
      Toast.makeText(activity,"颜色复制失败",0).show()
    end
  end

end
