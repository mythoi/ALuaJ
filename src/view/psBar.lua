require"import"
import "android.widget.TextView"
function click(v)
  pasteText=""
  if v.text=="(" then
    pasteText="()"
  elseif v.text=="{" then
    pasteText="{}"
  elseif v.text=="\"" then
    pasteText="\"\""
  elseif v.text=="'" then
    pasteText="''"
  elseif v.text=="[" then
    pasteText="[]"
  elseif v.text=="fun" then
    pasteText=[[function()]]
  elseif v.text=="前进" then

  elseif v.text=="后退" then

  else
    pasteText=v.Text
  end
  editor.paste(pasteText)
  if v.Text=="(" or v.Text=="{" or v.Text=="[" or v.Text=="\"" or v.Text=="'" then
    editor.moveCaret(editor.caretPosition-1)
  end
end


function longClick(v)
  editor.paste(v.Text)
  return true
end



function newButton(text)
  local sd = StateListDrawable()
  sd.addState({ pressed }, cd2)
  sd.addState({ 0 }, cd1)
  local btn = TextView(activity)
  btn.TextSize = 20;
  btn.TextColor=0xffffffff
  local pd = btn.TextSize / 2
  btn.setPadding(pd, pd / 2, pd, pd / 4)
  btn.Text = text
  if app_theme.colorPrimary=="#222222" then
    btn.backgroundColor=0xff333333 
  else
    btn.setBackgroundDrawable(sd)
  end
  btn.onClick = click
  btn.onLongClick=longClick
  return btn
end

function initPsBar(view)
  local ps = {"(", ")", "[", "]", "{", "}", "\"", "=", ":", ".", ",",";", "_", "+", "-", "*", "/", "\\", "%", "#", "^", "$", "?", "&", "|", "<", ">", "~", "'"};
  for k, v in ipairs(ps) do
    view.addView(newButton(v))
  end
end