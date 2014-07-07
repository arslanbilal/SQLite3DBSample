//
//  EditInfoViewController.h
//  SQLite3DBSample
//
//  Created by Bilal ARSLAN on 06/07/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditInfoViewControllerDelegate
-(void)editingInfoWasFinished;
@end


@interface EditInfoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (nonatomic, strong) id<EditInfoViewControllerDelegate> delegate;

- (IBAction)saveInfo:(id)sender;
@end
