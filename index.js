'use strict'
import {NativeModules,Platform,CameraRoll} from 'react-native'
import RNFS from 'react-native-fs';

const Md5 = require('md5');
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
      downloadImage(option.imagesUrl).then(imagesFile=>{
        return shareLocal.pictures(option.winTitle,option.subject,option.text,imagesFile,option.component,(error)=>{
          if(option.callback)option.callback(error);
        });
      });
    }
  }
}

function getImageBase64 (url) {
  return new Promise((RES, REJ) => {
    fetch(url).then(r => r.blob()).then(blob => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const data = e.target.result;
        RES(data.split('base64,')[1]);
      }
      reader.readAsDataURL(blob);
    }).catch(REJ);
  })
}

export function downloadImage(imagesUrl){
  if (Platform.OS === 'android') {
    const storeLocation = `${RNFS.ExternalCachesDirectoryPath}`;
    return new Promise((resolve, reject)=>{
      var downFiles=[];
      var downNum=0;
      for(let key in imagesUrl){
        let pathName = Md5(imagesUrl[key]) + ".jpg";
        let downloadDest = `${storeLocation}/${pathName}`;
        if(imagesUrl[key].substring(0,4) == 'file'){
          RNFS.moveFile(imagesUrl[key],downloadDest).then((result)=>{
            downFiles[key]="file://" + downloadDest;
            downNum = downNum + 1;
            if(downFiles.length == imagesUrl.length)resolve(downFiles);
          })
        }else{
          RNFS.exists(downloadDest).then(exists=>{
            if(!exists){
              RNFS.downloadFile({fromUrl:imagesUrl[key],toFile:downloadDest}).promise.then(res => {
                downFiles[key]="file://" + downloadDest;
                downNum = downNum + 1;
                if(downNum == imagesUrl.length)resolve(downFiles);
              });
            }else{
              downFiles[key]="file://" + downloadDest;
              if(downFiles.length == imagesUrl.length)resolve(downFiles);
            }
          })
        }
      }
    });
  }
}
