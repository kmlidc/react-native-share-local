# React Native Share Local

shareLocal封装了IOS系统原生的分享组件。

**使用这个组件不需要集成微信、QQ等第三方服务的sdk，也不需要申请appke 只要按照下面的方法就可以调用**

## Installation

run `npm install react-native-share-local --save`

## Automatically link
run `react-native link react-native-share-local`

## Manually link

### iOS (via Cocoa Pods)
Add the following line to your build targets in your `Podfile`

`pod 'RNShareLocal', :path => '../node_modules/react-native-share-local'`

Then run `pod install`

### IOS (without Cocoa Pods)
1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. add `./node_modules/react-native-share-local/IOS/RNShareLocal.xcodeproj`
3. In the XCode project navigator, select your project, select the `Build Phases` tab and in the `Link Binary With Libraries` section add **libRNShareLocal.a**

### Android
- in android/app/build.gradle:

```diff
dependencies {
    ...
    compile "com.facebook.react:react-native:+"  // From node_modules
+   compile project(':react-native-share-local')
}
```
- in `android/settings.gradle`:

```diff
...
include ':app'
+ include ':react-native-share-local'
+ project(':react-native-share-local').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-share-local/android')
```

#### With React Native 0.29+

- in `MainApplication.java`:

```diff
+ import com.kmlidc.RNShareLocal.RNShareLocal;

  public class MainApplication extends Application implements ReactApplication {
    //......

    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
+         new RNShareLocal(),
          new MainReactPackage()
      );
    }

    ......
  }
```

#### With older versions of React Native:

- in `MainActivity.java`:

```diff
+ import com.kmlidc.RNShareLocal.RNShareLocal;

  public class MainActivity extends ReactActivity {
    ......

    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
+       new RNShareLocal(),
        new MainReactPackage()
      );
    }
  }
```

(Thanks to @chirag04 for writing the instructions)

### Windows
- Open the solution in Visual Studio for your Windows apps
- right click your in the Explorer and click Add > Existing Project...
- Navigate to `./<app-name>/node_modules/react-native-share-local/windows/RNShareLocal` and add `RNShareLocal.csproj`
- this time right click on your React Native Windows app under your solutions directory and click Add > Reference...
- check the `RNShareLocal` you just added and press ok
- open up `MainPage.cs` for your app and edit the file like so:

```diff
+ using RNShareLocal;
......
            get
            {
                return new List<IReactPackage>
                {
                    new MainReactPackage(),
+                   new RNShareLocalPackage(),
                };
            }
```

(Thanks to @josephan for writing the instructions)

## API
* `shareMessage(option)`普通分享
* `shareLink(option)`分享网址
* `sharePictures(option)`分享多图

## Example

### first import shareLocal
```js
import {shareMessage,shareLink,sharePictures} from 'react-native-share-local'
```

### shareMessage(option)
```js
<Text style={styles.welcome} onPress={()=>{
  var option={
    text:"普通分享文字",
    image:"http://img.gemejo.com/product/8c/099/cf53b3a6008136ef0882197d5f5.jpg",
    callback:(error)=>{
      if(!error){
        alert("这是回调方法")
      }
    }
  };
  shareMessage(option);
}}>
  普通分享
</Text>
```

### shareLink(option)
```js
<Text style={styles.welcome} onPress={()=>{
  var option={
    title:"分享网址标题",
    icon:"http://img.gemejo.com/product/8c/099/cf53b3a6008136ef0882197d5f5.jpg",
    link:"http://www.baidu.com",
    callback:(error)=>{
      if(!error){
        alert("这是回调方法")
      }
    }
  };
  shareLink(option);
}}>
  分享网址
</Text>
```
### sharePictures(option)
最多可分享九张图片，超过的不显示

```js
<Text style={styles.welcome} onPress={()=>{
  var images = [
    "http://img.gemejo.com/product/8c/099/cf53b3a6008136ef0882197d5f5.jpg",
    "http://img.gemejo.com/product/45/1f0/f2f5067b718a01ef30abf738100.jpg"
  ];
  var option={
    imagesUrl:images,
    callback:(error)=>{
      if(!error){
        alert("这是回调方法")
      }
    }
  }
  sharePictures(option);
}}>
  分享多图
</Text>
```
## 补充说明

分享过程中如果有图片，会先下载完成图片之后再弹出分享菜单。建议增加网络加载图标，然后通过回调关闭加载图标。