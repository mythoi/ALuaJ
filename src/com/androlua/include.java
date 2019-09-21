package com.androlua;
import android.content.Context;
import android.widget.TextView;
import android.widget.Toast;

public class include extends TextView
{
	public include(Context context){
		super(context);
		setText("include : null");
	}	
	
	public void setLayout(String text){
		this.setText("include："+text);
	}
	
}