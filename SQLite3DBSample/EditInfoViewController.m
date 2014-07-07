//
//  EditInfoViewController.m
//  SQLite3DBSample
//
//  Created by Bilal ARSLAN on 06/07/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

#import "EditInfoViewController.h"
#import "DBManager.h"

@interface EditInfoViewController ()
@property (nonatomic, strong) DBManager *dbManager;

-(void)loadInfoToEdit;
@end


@implementation EditInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //  Make self the delegate of the textfields.
    self.txtFirstname.delegate = self;
    self.txtLastname.delegate = self;
    self.txtAge.delegate = self;
    
    //  Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFileName:@"db.sql"];
    
    //  Check if shoul load specific record to edit.
    if (self.recordIDToEdit != -1)
    {
        //  Load the record with the specific ID from database.
        [self loadInfoToEdit];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Delegate Method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Action Method
- (IBAction)saveInfo:(id)sender
{
    //  Prepare the query string.
    //  If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
    NSString *query;
    
    if (self.recordIDToEdit == -1)
    {
        query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', %d)", self.txtFirstname.text, self.txtLastname.text, [self.txtAge.text intValue]];
    }
    else
    {
        query = [NSString stringWithFormat:@"update peopleInfo set firstname='%@', lastname='%@', age=%d where peopleInfoID=%d", self.txtFirstname.text, self.txtLastname.text, self.txtAge.text.intValue, self.recordIDToEdit];
    }
    
    
    
    NSLog(@"The query is: %@",query);
    
    //  Execute the query.
    [self.dbManager executeQuery:query];
    
    //  If the query was succesfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affacted rows = %d", self.dbManager.affectedRows);
        
        //  Inform the delegate that editing was finished.
        [self.delegate editingInfoWasFinished];
        
        //  Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NSLog(@"Could not execute the query");
    }
}

#pragma  mark - PrivateData
-(void)loadInfoToEdit
{
    //  Create a query
    NSString *query = [NSString stringWithFormat:@"select * from peopleInfo where peopleInfoID=%d",self.recordIDToEdit];
    
    //  Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDBWithQuery:query]];
    
    //  Set the loaded data to the textfields.
    self.txtFirstname.text = [[results objectAtIndex:0] objectAtIndex:1];
    self.txtLastname.text = [[results objectAtIndex:0] objectAtIndex:2];
    self.txtAge.text = [[results objectAtIndex:0] objectAtIndex:3];
    
    
    
}
@end
