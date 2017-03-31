//
//  Globals.m
//  OAuth_Demo
//
//  Created by InnoeriOS1 on 2017/2/24.
//
//

#import <Foundation/Foundation.h>
#import "Globals.h"

//加密后的十六进制C字符串
//Original: "INNOWAYS API000"
const unsigned char _inno_AES_Key[] = {0x2D, 0x2F, 0x76, 0x29, 0x33, 0x25, 0x6F, 0x66, 0x18, 0x7C, 0x33, 0x76, 0x8, 0x3, 0x54, 0x00};
const unsigned char *inno_AES_Key = &_inno_AES_Key[0];
