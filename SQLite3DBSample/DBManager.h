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

-(instancetype) initWithDatabaseFileName:(NSString *)dbFileNane;
@end
