'use strict'
import {NativeModules} from 'react-native'

const shareLocal = NativeModules.RNShareLocal

export function shareSimple(option){
  if(option instanceof Object && option.length == undefined){
    return shareLocal.simple(option.text,option.image,(error)=>{
      if(option.callback)option.callback(error);
    });
  }
}

export function shareLink(option){
  if(option instanceof Object && option.length == undefined){
    return shareLocal.url(option.title,option.link,option.icon,(error)=>{
      if(option.callback)option.callback(error);
    });
  }
}

export function sharePictures(option){
  if(option instanceof Object && option.length == undefined){
    return shareLocal.pictures(option.imagesUrl,(error)=>{
      if(option.callback)option.callback(error);
    });
  }
}
