//
//  ViewController.m
//  Sqlit3附加数据库
//
//  Created by yachaocn on 16/3/1.
//  Copyright © 2016年 NavchinaMacBook. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

#define docPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FMDatabase *db = [FMDatabase databaseWithPath:[docPath stringByAppendingPathComponent:@"unencryptDB.db3"]];
    if ([db open]) {
        
//       创建未加密数据库
        NSString *sql = @"create table if not exists polit(id integer, userName text, password text)";
        BOOL result = [db executeUpdate:sql];
        
        if (result) {
            NSLog(@"create table polit succsss...");
        }else{
            NSLog(@"create table polit error...");
        }
        
//        插入数据
        NSString *insertSql = @"insert into polit(id, userName, password) values(1,'张三','zhangsan')";
        BOOL insetResult = [db executeUpdate:insertSql];
        if (insetResult) {
            NSLog(@"insert into polit a value success....");
        }else{
            NSLog(@"insert into polit a value error...");
        }
        
        /*
//        加密数据库（实质是：创建encryptDB.db3数据库，从unencryptDB.db3中导出所有数据到encryptDB.db3，同时加密数据）
//        1.ATTACH  追加一个加密的数据库（不存在则创建）
//        2.sqlcipher_export    导出所有数据到加密数据库
//        3.DETACH 关闭追加
        NSString *encryptDBsql =[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS encrypted KEY 'zhangyachao';"
                                 "SELECT sqlcipher_export('encrypted');"
                                 "DETACH DATABASE encrypted;",[docPath stringByAppendingPathComponent:@"encryptDB.db3"]];
       BOOL sql3 = [db executeStatements:encryptDBsql];
        if (sql3) {
            NSLog(@"statament success...");
        }else{
            NSLog(@"statament error....");
        }
         [db close];
         */
        
        /*
        
//        验证是否加密成功（通过解密数据库是否成功+数据库中表个数是否相同）》 注释上面代码
        db = [FMDatabase databaseWithPath:[docPath stringByAppendingPathComponent:@"encryptDB.db3"]];
        if ([db open] && [db setKey:@"zhangyachao"]) {
            NSLog(@"密码正确，打开加密数据库成功....");
        }else {
             NSLog(@"密码错误，打开加密数据库失败....");
        }
        
        NSString *tableCountSql = @"select count(*) from SQLITE_MASTER where sql is not null and type='table'";
        NSInteger count = [db intForQuery:tableCountSql];
        if (count > 0) {
            NSLog(@"数据库中表的个数为%ld",count);
        }else{
            NSLog(@"查询表个数错误！");
        }
        */
        
    }else{
        NSLog(@"open unencryptDB.db3 failed...");
    }
    
    /*
    //去除密码，导出不加密数据库
    db = [FMDatabase databaseWithPath:[docPath stringByAppendingPathComponent:@"encryptDB.db3"]];
    [db open];
    NSString *otherUnencryptDBsql =[NSString stringWithFormat:@"PRAGMA key = 'zhangyachao';"
                             "ATTACH DATABASE '%@' AS otherUnencryptDB KEY '';"
                             "SELECT sqlcipher_export('otherUnencryptDB');"
                             "DETACH DATABASE otherUnencryptDB;",[docPath stringByAppendingPathComponent:@"otherUnencryptDB.db3"]];
    BOOL otherUnencryptDBRes = [db executeStatements:otherUnencryptDBsql];
    if (otherUnencryptDBRes) {
        NSLog(@"数据库取消密成功...");
    }else{
        NSLog(@"数据客取消密码失败...");
    }*/
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
