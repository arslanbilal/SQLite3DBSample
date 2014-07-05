//
//  DBManager.m
//  SQLite3DBSample
//
//  Created by Bilal ARSLAN on 05/07/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

-(instancetype) initWithDatabaseFileName:(NSString *)dbFileNane
{
    self = [super init];
    
    if (self)
    {
        //  Set the documents directory path to the documentsDirectory property.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        
        //  Keep the database filename.
        self.databaseFileName = dbFileNane;
        
        //  Copy the databse file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

-(void)copyDatabaseIntoDocumentsDirectory
{
    //  Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        //  The database file does not exist in the documents directory, so copy it form the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFileName];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        //  Check if any error occured during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    
    
    
}



@end
