//
//  CSMImageInfo.h
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSMImageInfo : NSObject

//- id integer primary key autoincrement
//
//自增id主键
@property(nonatomic,assign,readwrite) int m_id;

//
//- path varchar(255)
//
//路径，如`ROSI-1/ROSI-1-000.jpg`这个指的的本地图片文件路径
@property(nonatomic,retain,readwrite) NSString *path;

//
//- url varchar(255)
//
//服务器端图片url，如`http://pic.rosi.mn//image/00001/$.face.jpg`
@property(nonatomic,retain,readwrite) NSString *url;

//
//- title varchar(255)
//
//专辑名称，如`ROSI-1`
@property(nonatomic,retain,readwrite) NSString *title;

//
//- order_i integer
//
//专辑内图片[整型]编号，如`2`
@property(nonatomic,assign,readwrite) int order_i;

//
//- order_s varchar(10)
//
//专辑内图片[字符型]编号，如`002`
@property(nonatomic,retain,readwrite) NSString *order_s;

//
//- face_image integer
//
//是否为封面图片，如`url = http://pic.rosi.mn//image/00001/$.face.jpg`的就是封面图片
@property(nonatomic,assign,readwrite) BOOL is_face_image;

@end
