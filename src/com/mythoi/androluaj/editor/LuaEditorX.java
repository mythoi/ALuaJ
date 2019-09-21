package com.mythoi.androluaj.editor;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.ActionMode;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.EditText;
import android.widget.RadioGroup.LayoutParams;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;
import android.widget.Toast;
import com.myopicmobileX.textwarrior.android.AutoCompletePanel;
import com.myopicmobileX.textwarrior.android.FreeScrollingTextField;
import com.myopicmobileX.textwarrior.android.YoyoNavigationMethod;
import com.myopicmobileX.textwarrior.common.ColorScheme;
import com.myopicmobileX.textwarrior.common.ColorSchemeDark;
import com.myopicmobileX.textwarrior.common.ColorSchemeLight;
import com.myopicmobileX.textwarrior.common.Document;
import com.myopicmobileX.textwarrior.common.DocumentProvider;
import com.myopicmobileX.textwarrior.common.LanguageLuaJava;
import com.myopicmobileX.textwarrior.common.LanguageXML;
import com.myopicmobileX.textwarrior.common.Lexer;
import com.myopicmobileX.textwarrior.common.LinearSearchStrategy;
import com.myopicmobileX.textwarrior.common.ReadTask;
import com.mythoi.androluaj.util.APIConfig;
import java.io.File;
import java.io.FileOutputStream;
import android.os.Looper;
import android.os.Handler;
import com.myopicmobileX.textwarrior.common.LanguageC;
import android.graphics.Color;
import com.mythoi.androluaj.editor.LuaEditorX.OpenFinishListener;

public class LuaEditorX extends FreeScrollingTextField
{

  private Document _inputingDoc;

  private boolean _isWordWrap;

  private Context mContext;

  private String _lastSelectedFile;

  private String fontDir="/storage/emulated/0/androlua/fonts/";

  private int _index;

  private String initNames[];
  
  public LuaEditorX(Context context, AttributeSet attr)
  {
    super(context, attr);
    mContext = context;
    setTypeface(Typeface.MONOSPACE);
    File df=new File(fontDir + "default.ttf");
    if (df.exists())
    setTypeface(Typeface.createFromFile(df));
    File bf=new File(fontDir + "bold.ttf");
    if (bf.exists())
    setBoldTypeface(Typeface.createFromFile(bf));
    File tf=new File(fontDir + "italic.ttf");
    if (tf.exists())
    setItalicTypeface(Typeface.createFromFile(tf));
    DisplayMetrics dm=context.getResources().getDisplayMetrics();

    float size=TypedValue.applyDimension(2, BASE_TEXT_SIZE_PIXELS, dm);


    setTextSize((int)size);
    setShowLineNumbers(true);
    setHighlightCurrentRow(true);
    setWordWrap(false);
    setAutoIndentWidth(2);
    LanguageLuaJava initLang=(LanguageLuaJava)LanguageLuaJava.getInstance();
    Lexer.setLanguage(initLang);
    initNames=initLang.getNames();
    AutoCompletePanel.setLanguage(initLang); 
    setNavigationMethod(new YoyoNavigationMethod(this));
    TypedArray array = mContext.getTheme().obtainStyledAttributes(new int[] { 
      android.R.attr.colorBackground, 
      android.R.attr.textColorPrimary, 
      android.R.attr.textColorHighlight,
    }); 
    int backgroundColor = array.getColor(0, 0xFF00FF); 
    int textColor = array.getColor(1, 0xFF00FF); 
    int textColorHighlight = array.getColor(2, 0xFF00FF); 
    array.recycle();
    setTextColor(textColor);
    setTextHighligtColor(textColorHighlight);
    setBasewordColor(0xFFEB7F23);
  }


  public LuaEditorX(Context context)
  {
    super(context);
    mContext = context;
    setTypeface(Typeface.MONOSPACE);
    File df=new File(fontDir + "default.ttf");
    if (df.exists())
    setTypeface(Typeface.createFromFile(df));
    File bf=new File(fontDir + "bold.ttf");
    if (bf.exists())
    setBoldTypeface(Typeface.createFromFile(bf));
    File tf=new File(fontDir + "italic.ttf");
    if (tf.exists())
    setItalicTypeface(Typeface.createFromFile(tf));
    DisplayMetrics dm=context.getResources().getDisplayMetrics();

    float size=TypedValue.applyDimension(2, BASE_TEXT_SIZE_PIXELS, dm);

    setTextSize((int)size);
    setShowLineNumbers(true);
    setHighlightCurrentRow(true);
    setWordWrap(false);
    setAutoIndentWidth(2);
    LanguageLuaJava initLang=(LanguageLuaJava)LanguageLuaJava.getInstance();
    Lexer.setLanguage(initLang);
    initNames=initLang.getNames();
    AutoCompletePanel.setLanguage(initLang); 
    setNavigationMethod(new YoyoNavigationMethod(this));
    TypedArray array = mContext.getTheme().obtainStyledAttributes(new int[] { 
      android.R.attr.colorBackground, 
      android.R.attr.textColorPrimary, 
      android.R.attr.textColorHighlight,
    }); 
    int backgroundColor = array.getColor(0, 0xFF00FF); 
    int textColor = array.getColor(1, 0xFF00FF); 
    int textColorHighlight = array.getColor(2, 0xFF00FF); 
    array.recycle();
    setTextColor(textColor);
    setTextHighligtColor(textColorHighlight);
    setBasewordColor(0xFFEB7F23);
  }


  @Override
  public Object clone() throws CloneNotSupportedException
  {
    // TODO: Implement this method
    return super.clone();
  }

  @Override
  protected void onLayout(boolean changed, int left, int top, int right, int bottom)
  {
    // TODO: Implement this method
    super.onLayout(changed, left, top, right, bottom);
    if (_index != 0 && right > 0)
    {
      moveCaret(_index);
      _index = 0;
    }
  }



  public void setDark(boolean isDark)
  {
    if (isDark)
    setColorScheme(new ColorSchemeDark());
  else
    setColorScheme(new ColorSchemeLight());
  }


  //mythoi优化添加大量关键字卡顿问题
  Handler handler=new Handler();
  public void addNames(final String newName[])
  { 
    new Thread(){

      public void run()
      {
        LanguageLuaJava lang=(LanguageLuaJava) Lexer.getLanguage();
        String[] old=lang.getNames();
        String[] news=new String[old.length + newName.length];
        System.arraycopy(old, 0, news, 0, old.length);
        System.arraycopy(newName, 0, news, old.length, newName.length);
        lang.setNames(news);
        Lexer.setLanguage(lang);
        respan(); 
        handler.post(new Runnable(){
          public void run()
          { 
            invalidate(); 
          }
        });
      }
    }.start();

  }


  public void clearNames(){
    LanguageLuaJava lang=(LanguageLuaJava) Lexer.getLanguage();
    lang.setNames(initNames);
    Lexer.setLanguage(lang);
    respan(); 
    invalidate(); 
  }

  public void addPackage(String pack,String arr[]){
    LanguageLuaJava lang=(LanguageLuaJava) Lexer.getLanguage();
    lang.addBasePackage(pack,arr); 
    Lexer.setLanguage(lang);
    AutoCompletePanel.setLanguage(lang); 
    respan(); 
    invalidate(); 
  }

  public boolean isName(String key){
    LanguageLuaJava lang=(LanguageLuaJava) Lexer.getLanguage();
    
    return lang.isName(key);
  }


 
  public void setPanelBackgroundColor(int color)
  {
    // TODO: Implement this method
    _autoCompletePanel.setBackgroundColor(color);
  }

  public void setPanelTextColor(int color)
  {
    // TODO: Implement this method
    _autoCompletePanel.setTextColor(color);
  }

  public void setKeywordColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.KEYWORD, color);
  }

  public void setUserwordColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.LITERAL, color);
  }

  public void setBasewordColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.NAME, color);
  }

  public void setStringColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.STRING, color);
  }

  public void setCommentColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.COMMENT, color);
  }

  public void setBackgoudColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.BACKGROUND, color);
  }

  public void setTextColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.FOREGROUND, color);
  }

  public void setTextHighligtColor(int color)
  {
    getColorScheme().setColor(ColorScheme.Colorable.SELECTION_BACKGROUND, color);
  }

  public String getSelectedText()
  {
    // TODO: Implement this method
    return _hDoc.subSequence(getSelectionStart(), getSelectionEnd() - getSelectionStart()).toString();
  }

  @Override
  public boolean onKeyShortcut(int keyCode, KeyEvent event)
  {
    final int filteredMetaState = event.getMetaState() & ~KeyEvent.META_CTRL_MASK;
    if (KeyEvent.metaStateHasNoModifiers(filteredMetaState))
    {
      switch (keyCode)
        {
          case KeyEvent.KEYCODE_A:
          selectAll();
          return true;
          case KeyEvent.KEYCODE_X:
          cut();
          return true;
          case KeyEvent.KEYCODE_C:
          copy();
          return true;
          case KeyEvent.KEYCODE_V:
          paste();
          return true;
        }
      }
      return super.onKeyShortcut(keyCode, event);
    }


    public EditText gotoLine()
    {

      edit = new EditText(mContext){
        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count)
        {
          if (s.length() > 0)
          {
            idx = 0;
            _gotoLine();
          }
        }

      };
      edit.setTextColor(Color.WHITE);
      edit.setHint("输入行号...");
      edit.setHintTextColor(0x55ffffff);
      edit.setBackgroundColor(0);
      edit.setSingleLine(true);
      edit.setInputType(2);
      edit.setImeOptions(2);
      edit.setOnEditorActionListener(new OnEditorActionListener(){
        @Override
        public boolean onEditorAction(TextView p1, int p2, KeyEvent p3)
        {
          // TODO: Implement this method
          _gotoLine();
          return true;
        }
      });
      edit.setLayoutParams(new LayoutParams(-1, -1)); 
      return edit;
      // startGotoMode();
    }

    public void _gotoLine()
    {
      String s=edit.getText().toString();
      if (s.isEmpty())
      return;

      int l=Integer.valueOf(s).intValue();
      if (l > _hDoc.getRowCount())
      {
        l = _hDoc.getRowCount();
      }
      gotoLine(l);
      // TODO: Implement this method
    }


    private EditText edit;
    public EditText search(String searchText)
    {
      edit = new EditText(mContext){
        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count)
        {
          if (s.length() > 0)
          {
            idx = 0;
            findNext();
          }
        }
      };
      edit.setText(searchText);
      edit.setHint("输入查找内容...");
      edit.setHintTextColor(0x55ffffff);
      edit.setBackgroundColor(0);
      edit.setTextColor(Color.WHITE);
      edit.setSingleLine(true);
      edit.setImeOptions(3);
      edit.setOnEditorActionListener(new OnEditorActionListener(){

        @Override
        public boolean onEditorAction(TextView p1, int p2, KeyEvent p3)
        {
          // TODO: Implement this method
          findNext();
          return true;
        }
      });

      edit.setLayoutParams(new LayoutParams(-1, -1));
      // edit.requestFocus();

      return edit;
      //startFindMode(searchText);
    }
    public void findNext()
    {
      // TODO: Implement this method
      finder = new LinearSearchStrategy();
      String kw=edit.getText().toString();
      if (kw.isEmpty())
      {
        selectText(false);
        return;
      }
      idx = finder.find(getText(), kw, idx, getText().length(), false, false);
      if (idx == -1)
      {
        selectText(false);
        Toast.makeText(mContext, "未找到", 500).show();
        idx = 0;
        return;
      }
      setSelection(idx, edit.getText().length());
      idx += edit.getText().length();
      moveCaret(idx);
    }




    public void startGotoMode()
    {
      // TODO: Implement this method
      startActionMode(new ActionMode.Callback(){

        private int idx;

        private EditText edit;

        @Override
        public boolean onCreateActionMode(ActionMode mode, Menu menu)
        {
          // TODO: Implement this method
          mode.setTitle("转到");
          mode.setSubtitle(null);

          edit = new EditText(mContext){
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count)
            {
              if (s.length() > 0)
              {
                idx = 0;
                _gotoLine();
              }
            }

          };
          edit.setTextColor(Color.WHITE);
          edit.setSingleLine(true);
          edit.setInputType(2);
          edit.setImeOptions(2);
          edit.setOnEditorActionListener(new OnEditorActionListener(){

            @Override
            public boolean onEditorAction(TextView p1, int p2, KeyEvent p3)
            {
              // TODO: Implement this method
              _gotoLine();
              return true;
            }
          });
          edit.setLayoutParams(new LayoutParams(getWidth() / 3, -1));
          menu.add(0, 1, 0, "").setActionView(edit);
          menu.add(0, 2, 0, mContext.getString(android.R.string.ok));
          edit.requestFocus();
          return true;
        }

        private void _gotoLine()
        {
          String s=edit.getText().toString();
          if (s.isEmpty())
          return;

          int l=Integer.valueOf(s).intValue();
          if (l > _hDoc.getRowCount())
          {
            l = _hDoc.getRowCount();
          }
          gotoLine(l);
          // TODO: Implement this method
        }

        @Override
        public boolean onPrepareActionMode(ActionMode mode, Menu menu)
        {
          // TODO: Implement this method
          return false;
        }

        @Override
        public boolean onActionItemClicked(ActionMode mode, MenuItem item)
        {
          // TODO: Implement this method
          switch (item.getItemId())
            {
              case 1:
              break;
              case 2:
              _gotoLine();
              break;

            }
            return false;
          }

          @Override
          public void onDestroyActionMode(ActionMode p1)
          {
            // TODO: Implement this method
          }
        });
      }

      public void startFindMode(final String searchText)
      {
        // TODO: Implement this method
        startActionMode(new ActionMode.Callback(){

          private LinearSearchStrategy finder;

          private int idx;

          private EditText edit;

          @Override
          public boolean onCreateActionMode(ActionMode mode, Menu menu)
          {
            // TODO: Implement this method
            mode.setTitle("搜索");
            mode.setSubtitle(null);

            edit = new EditText(mContext){
              @Override
              public void onTextChanged(CharSequence s, int start, int before, int count)
              {
                if (s.length() > 0)
                {
                  idx = 0;
                  findNext();
                }
              }
            };
            edit.setText(searchText);
            edit.setTextColor(Color.WHITE);
            edit.setSingleLine(true);
            edit.setImeOptions(3);
            edit.setOnEditorActionListener(new OnEditorActionListener(){

              @Override
              public boolean onEditorAction(TextView p1, int p2, KeyEvent p3)
              {
                // TODO: Implement this method
                findNext();
                return true;
              }
            });

            edit.setLayoutParams(new LayoutParams(getWidth() / 2, -1));
            menu.add(0, 1, 0, "").setActionView(edit);
            menu.add(0, 2, 0, mContext.getString(android.R.string.search_go));
            edit.requestFocus();
            return true;
          }

          @Override
          public boolean onPrepareActionMode(ActionMode mode, Menu menu)
          {
            // TODO: Implement this method
            return false;
          }

          @Override
          public boolean onActionItemClicked(ActionMode mode, MenuItem item)
          {
            // TODO: Implement this method
            switch (item.getItemId())
              {
                case 1:
                break;
                case 2:
                findNext();
                break;

              }
              return false;
            }

            private void findNext()
            {
              // TODO: Implement this method
              finder = new LinearSearchStrategy();
              String kw=edit.getText().toString();
              if (kw.isEmpty())
              {
                selectText(false);
                return;
              }
              idx = finder.find(getText(), kw, idx, getText().length(), false, false);
              if (idx == -1)
              {
                selectText(false);
                Toast.makeText(mContext, "未找到", 500).show();
                idx = 0;
                return;
              }
              setSelection(idx, edit.getText().length());
              idx += edit.getText().length();
              moveCaret(idx);
            }

            @Override
            public void onDestroyActionMode(ActionMode p1)
            {
              // TODO: Implement this method
            }
          });

        }



        @Override
        public void setWordWrap(boolean enable)
        {
          // TODO: Implement this method
          _isWordWrap = enable;
          super.setWordWrap(enable);
        }

        public DocumentProvider getText()
        {
          return createDocumentProvider();
        }

        public void insert(int idx, String text)
        {
          selectText(false);
          moveCaret(idx);
          paste(text);
          //_hDoc.insert(idx,text);
        }

        public void setText(CharSequence c, boolean isRep)
        {
          replaceText(0, getLength() - 1, c.toString());
        }

        public void setText(CharSequence c)
        {
          //TextBuffer text=new TextBuffer();
          Document doc=new Document(this);
          doc.setWordWrap(_isWordWrap);
          doc.setText(c);
          setDocumentProvider(new DocumentProvider(doc));
          //doc.analyzeWordWrap();
        }

        public void setSelection(int index)
        {
          selectText(false);
          if (!hasLayout())
          moveCaret(index);
        else
          _index = index;
        }

        public void gotoLine(int line)
        {
          if (line > _hDoc.getRowCount())
          {
            line = _hDoc.getRowCount();
          }
          int i=getText().getLineOffset(line - 1);
          setSelection(i);
        }

        public void undo()
        {
          DocumentProvider doc = createDocumentProvider();
          int newPosition = doc.undo();

          if (newPosition >= 0)
          {
            //TODO editor.setEdited(false); if reached original condition of file
            setEdited(true);

            respan();
            selectText(false);
            moveCaret(newPosition);
            invalidate();
          }

        }

        public void redo()
        {
          DocumentProvider doc = createDocumentProvider();
          int newPosition = doc.redo();

          if (newPosition >= 0)
          {
            setEdited(true);

            respan();
            selectText(false);
            moveCaret(newPosition);
            invalidate();
          }

        }


        public boolean isOpenJava=false;
        public void open(String filename,OpenFinishListener openFinishListener)
        {
          _lastSelectedFile = filename;

          if (_lastSelectedFile.endsWith(".xml")||_lastSelectedFile.endsWith(".lua")||_lastSelectedFile.endsWith(".aly")||_lastSelectedFile.endsWith(".txt"))
          isOpenJava = false;
          if (_lastSelectedFile.endsWith(".xml"))
          {
            setBasewordColor(0xffEA9016);
            setKeywordColor(0xffEA9016);
            Lexer.getLanguage().addKeyWords(new String[]{"-","/","<",">"});
          }else{

            if (_lastSelectedFile.endsWith(".java"))
            isOpenJava = true;
            Lexer.getLanguage().removeKeyWords(new String[]{"-","/","<",">"});
            setBasewordColor(0xFF2D87C7);
            setKeywordColor(0xFFD040DD);
          }



          File inputFile = new File(filename);
          _inputingDoc = new Document(this);
          _inputingDoc.setWordWrap(this.isWordWrap());
          ReadTask _taskRead = new ReadTask(this, inputFile,openFinishListener);
          _taskRead.start();
        }

        public void save(String filename)
        {
          File outputFile = new File(filename);
          try
          {
            FileOutputStream out=new FileOutputStream(outputFile);
            byte[] b=getText().toString().getBytes();
            out.write(b, 0, b.length);
            out.close();
          }
          catch (Exception e)
          {}

        }


        private LinearSearchStrategy finder;

        private int idx;

        private String mKeyword;

        public boolean findNext(String keyword)
        {
          if (!keyword.equals(mKeyword))
          {
            mKeyword = keyword;
            idx = 0;
          }
          // TODO: Implement this method
          finder = new LinearSearchStrategy();
          String kw=mKeyword;
          if (kw.isEmpty())
          {
            selectText(false);
            return false;
          }
          idx = finder.find(getText(), kw, idx, getText().length(), false, false);
          if (idx == -1)
          {
            selectText(false);
            Toast.makeText(mContext, "未找到", 500).show();
            idx = 0;
            return false;
          }
          setSelection(idx, mKeyword.length());
          idx += mKeyword.length();
          moveCaret(idx);
          return true;
        }


        //文件打开完成监听器
        public interface OpenFinishListener{
          public void openFinish();
        }

      }
