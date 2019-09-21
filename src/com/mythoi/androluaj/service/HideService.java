package com.mythoi.androluaj.service;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import java.io.*;
import android.content.*;
import dalvik.system.*;

public class HideService extends Service{

  @Override
  public IBinder onBind(Intent intent) {
    return null;
  }


  @Override
  public int onStartCommand(Intent intent, int flags, int startId)
  {
    return super.onStartCommand(intent, flags, startId);
  }



  @Override
  public void onDestroy()
  { 
    super.onDestroy();   
    System.exit(0);       
  }

}