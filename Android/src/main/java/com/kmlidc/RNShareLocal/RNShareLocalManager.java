package com.kmlidc.RNShareLocal;
import android.net.Uri;
import android.content.Intent;
import android.content.ComponentName;
import android.app.Activity;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.uimanager.IllegalViewOperationException;


import com.facebook.react.bridge.ActivityEventListener;
import android.util.Log;

import java.lang.String;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URL;
import java.net.HttpURLConnection;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;

import java.security.MessageDigest;
import java.math.BigInteger;
import java.io.FileInputStream;

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

    @ReactMethod
    public void downloadImage(ReadableArray imagesUrl, Promise promise){
        List<String> paths = new ArrayList<String>();
        for(int i=0; i<imagesUrl.size();i++){
            String imageUrl = imagesUrl.getString(i);
            String pathMd5 = this.md5(imageUrl);
            String fileName = i +".jpg";
            if(pathMd5.length() > 0) {
                fileName = pathMd5 +".jpg";
            }
            String path = this.download(imageUrl,fileName);
            paths.add(path);
        }

        JSONArray array = new JSONArray(paths);
        promise.resolve(array.toString());
    }

    //下载图片并保存
    public String download( String imageUrl, String fileName) {
        final String savePath = getReactApplicationContext().getExternalCacheDir() + "/" + fileName;
        try {
            File f = new File(savePath);
            //如果文件存在且不等于1.jpg等
            if( fileName.length() == 36 && f.exists()){
                return "file://" + savePath;
            }
            File dir = f.getParentFile();
            if(!dir.exists()) dir.mkdirs();//不存在目录则创建
            //如果是本地文件则拷贝
            if(imageUrl.indexOf("file") == 0){
                this.copyFile(imageUrl.substring(6),savePath);
                return "file://" + savePath;
            }
            FileOutputStream os = new FileOutputStream(f);
            byte[] data = getImage(imageUrl);
            os.write(data);
            os.close();
        } catch (Exception e) {
            e.getLocalizedMessage();
        }

        return "file://" + savePath;
    }

    /*
    * 获取网络图片
    */
    public byte[] getImage(String imageUrl) throws Exception{
        URL url = new URL(imageUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setConnectTimeout(5 * 1000);
        conn.setRequestMethod("GET");
        InputStream inStream = conn.getInputStream();
        if(conn.getResponseCode() == HttpURLConnection.HTTP_OK){
            return readStream(inStream);
        }
        return null;
    }


    /*
    获取图片流数据
     */
    public static byte[] readStream(InputStream inStream) throws Exception{
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while( (len=inStream.read(buffer)) != -1){
            outStream.write(buffer, 0, len);
        }
        outStream.close();
        inStream.close();
        return outStream.toByteArray();
    }

    /*
    复制文件
     */
    public void copyFile(String oldPath, String newPath) {
        try {
            int bytesum = 0;
            int byteread = 0;
            File oldfile = new File(oldPath);
            if (oldfile.exists()) { //文件存在时
                InputStream inStream = new FileInputStream(oldPath); //读入原文件
                FileOutputStream fs = new FileOutputStream(newPath);
                byte[] buffer = new byte[1444];
                int length;
                while ( (byteread = inStream.read(buffer)) != -1) {
                    bytesum += byteread; //字节数 文件大小
                    System.out.println(bytesum);
                    fs.write(buffer, 0, byteread);
                }
                inStream.close();
            }
        }
        catch (Exception e) {
            System.out.println("复制单个文件操作出错");
            e.printStackTrace();

        }

    }

    /*
    使用MD5加密
     */
    public static String md5(String str){
        try {
            // 生成一个MD5加密计算摘要
            MessageDigest md = MessageDigest.getInstance("MD5");
            // 计算md5函数
            md.update(str.getBytes());
            // digest()最后确定返回md5 hash值，返回值为8为字符串。因为md5 hash值是16位的hex值，实际上就是8位的字符
            // BigInteger函数则将8位的字符串转换成16位hex值，用字符串来表示；得到字符串形式的hash值
            return new BigInteger(1, md.digest()).toString(16);
        } catch (Exception e) {
            return "";
        }
    }

}
