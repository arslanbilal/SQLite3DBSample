//
//  DBManager.h
//  SQLite3DBSample
//
//  Created by Bilal ARSLAN on 05/07/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFileName;


-(instancetype) initWithDatabaseFileName:(NSString *)dbFileNane;
-(void)copyDatabaseIntoDocumentsDirectory;
@end
