package com.kmlidc.RNShareLocal;
import android.net.Uri;
import android.content.Intent;
import android.content.ComponentName;
import android.app.Activity;


import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReactMethod;


import com.facebook.react.bridge.ActivityEventListener;
import android.util.Log;

import java.lang.String;
import java.util.ArrayList;
import java.net.URL;

/**
 * Created by yangbin on 2017/5/20.
 */

public class RNShareLocalManager extends ReactContextBaseJavaModule implements ActivityEventListener{
    private ReactApplicationContext reactContext;
    private Callback callback;

    final int SHARE_REQUEST = 500;

    public RNShareLocalManager(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.reactContext.addActivityEventListener(new RNShareLocalActivityEventListener());
    }

    @Override
    public String getName() {
        return "RNShareLocal";
    }

    private class RNShareLocalActivityEventListener implements ActivityEventListener {
        public void onActivityResult(Activity activity, final int requestCode, final int resultCode, final Intent intent) {
            if (requestCode == SHARE_REQUEST) {
                try {
                    callback.invoke("success");
                }catch (Exception e) {
                    System.out.println(e);
                }
            }
        }

        public void onNewIntent(Intent intent) {

        }
    }

    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {

    }

    public void onNewIntent(Intent intent) {

    }

    @ReactMethod
    public void message(String winTitle,String subject,String message,ReadableArray component, Callback callback) {
        this.callback = callback;

        Intent intent=new Intent(Intent.ACTION_SEND);
        intent.putExtra(Intent.EXTRA_SUBJECT,subject);
        intent.putExtra(Intent.EXTRA_TEXT,message);
        intent.setType("text/plain");

        Intent chooser = Intent.createChooser(intent, winTitle);
        chooser.addCategory(Intent.CATEGORY_DEFAULT);

        //是否指定App打开
        if(component != null && component.size() == 2) {
            intent.setComponent(new ComponentName(component.getString(0), component.getString(1)));
        }

        try {
            getCurrentActivity().startActivityForResult(chooser, SHARE_REQUEST);
        }catch (Exception e){

        }
    }

    @ReactMethod
    public void link(String winTitle,String subject,String url,ReadableArray component, Callback callback) {
        this.callback = callback;
        Intent intent=new Intent(Intent.ACTION_SEND);
        intent.putExtra(Intent.EXTRA_SUBJECT,subject);
        intent.putExtra(Intent.EXTRA_TEXT, url);
        intent.setType("text/html");

        Intent chooser = Intent.createChooser(intent, winTitle);
        chooser.addCategory(Intent.CATEGORY_DEFAULT);

        //是否指定App打开
        if(component != null && component.size() == 2) {
            intent.setComponent(new ComponentName(component.getString(0), component.getString(1)));
        }

        try {
            getCurrentActivity().startActivityForResult(chooser, SHARE_REQUEST);
        }catch (Exception e){

        }
    }

    @ReactMethod
    public void pictures(String winTitle,String subject,String message,ReadableArray imagesFile,ReadableArray component, Callback callback) {
        this.callback = callback;
        ArrayList<Uri> uris = new ArrayList<Uri>();
        for(int i=0; i<imagesFile.size();i++){
            uris.add(Uri.parse(imagesFile.getString(i)));
        }
        Intent intent=new Intent(Intent.ACTION_SEND_MULTIPLE);
        intent.putExtra(Intent.EXTRA_SUBJECT,subject);
        intent.putExtra(Intent.EXTRA_TEXT, message);
        intent.putExtra(Intent.EXTRA_STREAM, uris);
        intent.putExtra ("Kdescription", message);
        intent.setType("image/*");

        Intent chooser = Intent.createChooser(intent, winTitle);
        chooser.addCategory(Intent.CATEGORY_DEFAULT);

        //是否指定App打开
        if(component != null && component.size() == 2) {
            intent.setComponent(new ComponentName(component.getString(0), component.getString(1)));
        }

        try {
            getCurrentActivity().startActivityForResult(chooser, SHARE_REQUEST);
        }catch (Exception e){
            System.out.println(e);
        }
    }

}
