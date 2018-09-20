'use strict'
import {NativeModules,Platform,CameraRoll} from 'react-native'

const shareLocal = NativeModules.RNShareLocal

export function shareMessage(option){
  if(option instanceof Object && option.length == undefined){
    if(Platform.OS === 'ios'){
      return shareLocal.message(option.text,option.image,option.excluded,(result)=>{
        if(option.callback)option.callback(result);
      });
    }else if (Platform.OS === 'android') {
      return shareLocal.message(option.winTitle,option.subject,option.text,option.component,(error)=>{
        if(option.callback)option.callback(error);
      });
    }
  }
}

export function shareLink(option){
  if(option instanceof Object && option.length == undefined){
    if(Platform.OS === 'ios'){
      return shareLocal.link(option.title,option.link,option.icon,option.excluded,(result)=>{
        if(option.callback)option.callback(result);
      });
    }else if (Platform.OS === 'android') {
      return shareLocal.link(option.winTitle,option.subject,option.url,option.component,(error)=>{
        if(option.callback)option.callback(error);
      });
    }
  }
}

export function sharePictures(option){
  if(option instanceof Object && option.length == undefined){
    if(Platform.OS === 'ios'){
      return shareLocal.pictures(option.imagesUrl,option.excluded,(result)=>{
        if(option.callback)option.callback(result);
      });
    }else if (Platform.OS === 'android') {
      shareLocal.downloadImage(option.imagesUrl).then(result=>{
        var imagesFile = JSON.parse(result);
        return shareLocal.pictures(option.winTitle,option.subject,option.text,imagesFile,option.component,(error)=>{
          if(option.callback)option.callback(error);
        });
      });
    }
  }
}

export function downloadImage(imagesUrl){
  if (Platform.OS === 'android') {
    return shareLocal.downloadImage(imagesUrl).then(result=>{
      var imagesFile = JSON.parse(result);
      return imagesFile;
    });
  }
}
