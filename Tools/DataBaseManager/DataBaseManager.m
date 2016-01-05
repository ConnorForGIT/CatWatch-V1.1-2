//
//  DataBaseManager.m
//  UI14_DataBase
//
//  Created by 老师先给我发 on 14-10-2.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "DataBaseManager.h"

static sqlite3 * dbPoint = nil; //  数据库指针

@implementation DataBaseManager
+ (void)open
{
    if (dbPoint) {
        return;
    }
    
   NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"Favorite.rdb"];
    
    int result = sqlite3_open(path.UTF8String, &dbPoint);
    
    if (result == SQLITE_OK) {
    }
}
+ (void)close
{
    sqlite3_close(dbPoint);
}


+ (void)create
{
    [self open];
    
    NSString * sql = [NSString stringWithFormat:@"create table Favorite (titleStr text, cover_thumbURL text, pubdateStr text, author text, source text, link_videoURL text, link_shareURL text, summaryStr text, contentStr text)"];
    
    NSString * sql1 = [NSString stringWithFormat:@"create table FavoriteNews (title text, cover_thumbURL text, cover text, pubdate text, author text, source text, link_shareURL text, summarySTR text, contentSTR text)"];
    
    sqlite3_exec(dbPoint, sql.UTF8String, NULL, NULL, NULL);
    sqlite3_exec(dbPoint, sql1.UTF8String, NULL, NULL, NULL);
    
}
+ (void)insert:(ModelSource *)model
{
    [self open];
    
    NSString * sql = [NSString stringWithFormat:@"insert into Favorite values ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", model.titleStr, model.cover_landscapeURL, model.pubdateStr, model.author, model.source, model.link_videoURL, model.link_shareURL, model.summaryStr, model.contentStr];

    sqlite3_exec(dbPoint, sql.UTF8String, NULL, NULL, NULL);
    
}
+ (void)insertNews:(Model *)model
{
    [self open];
    
    NSString * sql = [NSString stringWithFormat:@"insert into Favorite values ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", model.title, model.cover_thumbURL, model.cover, model.pubdate, model.author, model.source, model.link_shareURL, model.summarySTR, model.contentSTR];
    
    sqlite3_exec(dbPoint, sql.UTF8String, NULL, NULL, NULL);
    
}

+ (void)insertPro:(Product *)model
{
    
}

+ (void)remove:(ModelSource *)model
{
    [self open];
    NSString * sql = [NSString stringWithFormat:@"delete from Favorite where titleStr = '%@'", model.titleStr];
    sqlite3_exec(dbPoint, sql.UTF8String, NULL, NULL, NULL);
}
+ (void)removeNews:(Model *)model
{
    [self open];
    NSString * sql = [NSString stringWithFormat:@"delete from Favorite where titleStr = '%@'", model.title];
    sqlite3_exec(dbPoint, sql.UTF8String, NULL, NULL, NULL);
}

+ (void)update
{
    [self open];
    NSString * sql = @"update dls140818 set name = '汲国兴真帅' where number = 88";
    sqlite3_exec(dbPoint, sql.UTF8String, NULL, NULL, NULL);
}
+ (NSMutableArray *)select
{
    [self open];
    
    //创建数据库替身
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select * from Favorite";
    
    //执行语句
    int result = sqlite3_prepare_v2(dbPoint, sql.UTF8String, -1, &stmt, NULL);
    
    //判断
    if (result == SQLITE_OK) {
        // 创建数组用来保存查询的数据
        NSMutableArray * arr = [NSMutableArray array];
        
        //如果还有下一行
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //获取数据
            const unsigned char * title = sqlite3_column_text(stmt, 0);
            const unsigned char * cover_thumbURL = sqlite3_column_text(stmt, 1);
            const unsigned char * pubdateStr = sqlite3_column_text(stmt, 2);
            const unsigned char * author = sqlite3_column_text(stmt, 3);
            const unsigned char * source = sqlite3_column_text(stmt, 4);
            const unsigned char * link_videoURL = sqlite3_column_text(stmt, 5);
            const unsigned char * link_shareURL = sqlite3_column_text(stmt, 6);
            const unsigned char * summaryStr = sqlite3_column_text(stmt, 7);
            const unsigned char * contentStr = sqlite3_column_text(stmt, 8);
            
            //封装成model
            ModelSource * model = [[ModelSource alloc]init];
            model.titleStr = [NSString stringWithUTF8String:(const char *) title];
            model.cover_thumbURL = [NSString stringWithUTF8String:(const char *) cover_thumbURL];
            model.pubdateStr = [NSString stringWithUTF8String:(const char *) pubdateStr];
            model.author = [NSString stringWithUTF8String:(const char *) author];
            model.source = [NSString stringWithUTF8String:(const char *) source];
            model.link_videoURL = [NSString stringWithUTF8String:(const char *) link_videoURL];
            model.link_shareURL = [NSString stringWithUTF8String:(const char *) link_shareURL];
            model.summaryStr = [NSString stringWithUTF8String:(const char *) summaryStr];
            model.contentStr = [NSString stringWithUTF8String:(const char *) contentStr];
            
            [arr addObject:model];
        }
        
        sqlite3_finalize(stmt);
        return arr;
        
    }
    sqlite3_finalize(stmt);
    return [NSMutableArray array];
}
@end
