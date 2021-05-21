//  NSString+Help.m
//
//  Created by Mac10.9.4 on 14-9-21.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Help)

/**
 *  返回md5加密后的字符串
 */
- (NSString *)md5String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, length, bytes);
    
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}
/**
 *  返回sha1遍吗后的字符串
 */
- (NSString *)sha1String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, length, bytes);
    
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}
/**
 *  返回sha256遍吗后的字符串
 */
- (NSString *)sha256String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, length, bytes);
    
  NSString * shastr = [[self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH] uppercaseString];//转换大写
    return [shastr stringByReplacingOccurrencesOfString:@"0"withString:@"Z"];//改变0 换成Z
}
/**
 *  返回sha512遍吗后的字符串
 */
- (NSString *)sha512String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(str, length, bytes);
    
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    return [strM copy];
}
/**
  *  返回Base64遍吗后的字符串
  */
- (NSString *)base64Encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}
/**
 *  返回Base64解码后的字符串
 */
- (NSString *)base64Decode {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**
 *  计算一行字的size
 *
 *  @param fount fount
 *
 *  @return 计算好的 size
 */
- (CGSize)sizeWithStingFount:(UIFont *)fount
{
    return [self sizeWithStingFount:fount withMaxSize:CGSizeMake(MAXFLOAT, 0)];
}

/**
 *  计算字符串的size
 *
 *  @param fount   fount
 *  @param maxSize 字符串可以占据的最大的size
 *
 *  @return size
 *
 *  @exception 计算好的 size
 */
- (CGSize)sizeWithStingFount:(UIFont *)fount withMaxSize:(CGSize)maxSize;
{
    NSDictionary *attrs = @{NSFontAttributeName : fount};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
//处理url中的特殊字符
+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    return encodedString;
}
/*
 判断输入的手机号是否可用
 */
//手机号有效性
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    NSString *MOBILE = @"^(13[0-9]|14[5-9]|15[0-3,5-9]|16[2,5,6,7]|17[0-8]|18[0-9]|19[0-3,5-9])\\d{8}$";
    NSPredicate *pred_mobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [pred_mobile evaluateWithObject:mobileNum];
}
/**
 *  判断字符串是否为空
 *
 *  @param  字符串
 *
 *  @return YES or NO
 */
+ (BOOL) iSStringNull:(NSString *)nullStr
{
    if (nullStr == nil) {
        return YES;
    }
    if (nullStr == Nil) {
        return YES;
    }
    if (nullStr == NULL) {
        return YES;
    }
    if ([nullStr isEqualToString:@" "]) {
        return YES;
    }
    if ([nullStr isEqualToString:@"null"]) {
        return YES;
    }
    if ([nullStr isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([nullStr isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([nullStr isEqual:[NSNull null]]) {
        return YES;
    }
    if ([nullStr length] == 0) {
        return YES;
    }
    return NO;
}
- (NSString *)VerticalString{
    NSMutableString * str = [[NSMutableString alloc] initWithString:self];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}
@end
