package com.mythoi.androluaj.activity;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.SwitchPreference;
import android.util.Log;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.view.View.OnClickListener;
import android.widget.Toast;
import kellinwood.security.zipsigner.optional.DistinguishedNameValues;
import kellinwood.security.zipsigner.optional.CertCreator;
import android.preference.EditTextPreference;
import com.mythoi.androluaj.util.Utils;
import com.mythoi.androluaj.R;
import android.graphics.Color;
import android.preference.PreferenceScreen;
import java.lang.reflect.Method;
import android.widget.Toast;

public class SettingActivity extends PreferenceActivity
{

  private Preference createKey;

  private EditTextPreference setKeyPath;

  private SwitchPreference isjmInstall;

  public static String themeColor="#3F51B5";
  @Override
  protected void onCreate(Bundle savedInstanceState)
  {

    if(themeColor.equals("#222222")){
      setTheme(R.style.AppTheme2); 
    }else{
      setTheme(R.style.AppTheme); 
    }
    this.getWindow().setStatusBarColor(Color.parseColor(themeColor)); 
    super.onCreate(savedInstanceState);
    addPreferencesFromResource(R.xml.setting_activity);
    final PreferenceScreen dialog1=(PreferenceScreen) findPreference("editor");
    final PreferenceScreen dialog2=(PreferenceScreen) findPreference("runBuild");
    isjmInstall=(SwitchPreference)findPreference("isjmInstall");
    isjmInstall.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener(){

      public boolean onPreferenceChange(Preference p1,Object obj){
        if(obj.toString().equals("true")){          
          try{
            Class<?> threadClazz = Class.forName("com.androlua.util.RootUtil");
            Method method = threadClazz.getMethod("haveRoot");
             if(method.invoke(null).toString().equals("true"))
              return true;
             else{
              Toast.makeText(SettingActivity.this,"无root权限",0).show(); 
              return false;
            }
          }catch(Exception e){
            Toast.makeText(SettingActivity.this,"无root权限",0).show(); 
            return false;
          }

        }else{
          return true;
        } 
      }

    });

    dialog1.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener(){

      @Override
      public boolean onPreferenceClick(Preference p1)
      {
        dialog1.getDialog().getWindow().setStatusBarColor(Color.parseColor(themeColor)); 
        return false;
      }
    });

    dialog2.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener(){

      @Override
      public boolean onPreferenceClick(Preference p1)
      {
        dialog2.getDialog().getWindow().setStatusBarColor(Color.parseColor(themeColor)); 
        return false;
      }
    });

    setKeyPath = (EditTextPreference)findPreference("keyPath");
    createKey = findPreference("createKey");
    createKey.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener(){

      @Override
      public boolean onPreferenceClick(Preference p1)
      { 
        View view=LayoutInflater.from(SettingActivity.this).inflate(R.layout.create_key_dialog, null);
        final EditText keyPath=(EditText) view.findViewById(R.id.keyPath);
        final EditText cert=(EditText) view.findViewById(R.id.cert);
        final EditText pw=(EditText) view.findViewById(R.id.pw);
        final EditText repw=(EditText) view.findViewById(R.id.repw);
        final EditText validity=(EditText) view.findViewById(R.id.validity);
        final EditText name=(EditText) view.findViewById(R.id.name);
        final EditText company=(EditText) view.findViewById(R.id.company);
        final EditText organization=(EditText) view.findViewById(R.id.organization);
        final EditText street=(EditText) view.findViewById(R.id.street);
        final EditText city=(EditText) view.findViewById(R.id.city);
        final EditText county=(EditText) view.findViewById(R.id.county);
        final EditText state=(EditText) view.findViewById(R.id.state);
        new File(Utils.ROOT_PATH + "keys").mkdirs();
        keyPath.setText(Utils.ROOT_PATH + "keys/myKey.jks");
        AlertDialog.Builder alert=new AlertDialog.Builder(SettingActivity.this);
        alert.setTitle("创建签名证书");
        alert.setView(view);
        alert.setPositiveButton("创建", new DialogInterface.OnClickListener(){

          @Override
          public void onClick(DialogInterface p1, int p2)
          {
            if (!pw.getText().toString().equals(repw.getText().toString()))
            {
              Toast.makeText(SettingActivity.this, "前后密码不一致",0).show();
              return;
            }
            if (new File(keyPath.getText().toString()).exists())
            {
              new File(keyPath.getText().toString()).delete();
            }
            final Params params=new Params();
            params.distinguishedNameValues.setCommonName(name.getText().toString());
            params.distinguishedNameValues.setOrganization(company.getText().toString());
            params.distinguishedNameValues.setOrganizationalUnit(organization.getText().toString());
            params.distinguishedNameValues.setStreet(street.getText().toString());
            params.distinguishedNameValues.setLocality(city.getText().toString());
            params.distinguishedNameValues.setCountry(county.getText().toString());
            params.distinguishedNameValues.setState(state.getText().toString());
            new Thread(){

              public void run()
              {
                CertCreator.createKeystoreAndKey(keyPath.getText().toString(), pw.getText().toString().toCharArray(), "RSA", 2048, cert.getText().toString(), pw.getText().toString().toCharArray(), "SHA1withRSA", Integer.parseInt(validity.getText().toString()), params.distinguishedNameValues); 
                runOnUiThread(new Runnable(){

                  @Override
                  public void run()
                  {
                    SharedPreferences sharedPreferences=PreferenceManager.getDefaultSharedPreferences(SettingActivity.this);
                    SharedPreferences.Editor editor=sharedPreferences.edit();
                    editor.putString("signPassword", pw.getText().toString());
                    editor.commit(); 
                    Toast.makeText(SettingActivity.this,"创建成功",1).show();
                    setKeyPath.setText(keyPath.getText().toString()); 
                  }
                });

              }
            }.start();
          }
        });
        alert.setNegativeButton("取消", null);
        alert.show();
        return false;
      }
    });
  }


  class Params
  {
    int requestCode;
    String storePath;
    String storePass;
    String keyName;
    String keyAlgorithm;
    int keySize;
    String keyPass;
    int certValidityYears;
    String certSignatureAlgorithm;
    DistinguishedNameValues distinguishedNameValues = new DistinguishedNameValues();


  }
}

