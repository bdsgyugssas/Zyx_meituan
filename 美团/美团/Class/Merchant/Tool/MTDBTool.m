//
//  MTDBTool.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/24.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTDBTool.h"
#import "FMDatabase.h"

@implementation MTDBTool

static FMDatabase *_db;

+ (void)initialize
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *DBPath=[path stringByAppendingPathComponent:@"merchant.db"];
    
    _db=[FMDatabase databaseWithPath:DBPath];
    
    [_db open];
    
    NSString *sql=@"CREATE TABLE IF NOT EXISTS t_merchant (id integer PRIMARY KEY,merchant blob NOT NULL,type text NOT NULL)";
    [_db executeUpdate:sql];
}

+ (void)saveMerchants:(NSArray *)merchants type:(MerchantType)type
{
    for (NSArray *merchant in merchants) {
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:merchant];
       [_db executeUpdateWithFormat:@"INSERT INTO t_merchant(merchant,type)VALUES(%@,%u)",data,type];
    }

}

+ (NSArray *)getDataWithType:(MerchantType)type
{
    
    FMResultSet *set=[_db executeQueryWithFormat:@"SELECT * FROM t_merchant WHERE type=%u",type];
    NSMutableArray *array=[NSMutableArray array];
    while (set.next) {
        NSData *data=[set objectForColumnName:@"merchant"];
        NSDictionary *dict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:dict];
    }
    return array;

}

@end
