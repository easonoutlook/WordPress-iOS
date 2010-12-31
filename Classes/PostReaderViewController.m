//
//  PostReaderViewController.m
//  WordPress
//
//  Created by Jorge Bernal on 12/30/10.
//  Copyright 2010 WordPress. All rights reserved.
//

#import "PostReaderViewController.h"


@implementation PostReaderViewController
@synthesize categoriesTextField, statusTextField, titleTextField, tagsTextField;
@synthesize contentView;
@synthesize post;

- (id)initWithPost:(Post *)aPost {
    if (self = [super initWithNibName:@"PostReaderViewController-iPad" bundle:nil]) {
        self.post = aPost;
    }
    
    return self;
}

- (void)refreshUI {
    titleTextField.text = self.post.postTitle;
    tagsTextField.text = self.post.tags;
    categoriesTextField.text = [self.post categoriesText];
    statusTextField.text = self.post.statusTitle;
    contentView.text = self.post.content;
}

- (void)viewDidLoad {
    [self refreshUI];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(showModalEditor)];
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];
}

- (void)showModalEditor {
    PostViewController *postViewController;
    
    if (DeviceIsPad()) {
        postViewController = [[PostViewController alloc] initWithNibName:@"PostViewController-iPad" bundle:nil];
    } else {
        postViewController = [[PostViewController alloc] initWithNibName:@"PostViewController" bundle:nil];
    }
    postViewController.post = self.post;
    postViewController.hasChanges = NO;
    postViewController.editMode = kEditPost;
    [postViewController refreshUIForCurrentPost];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:postViewController];
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:nav animated:YES];
    [nav release];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showModalEditor];
    return NO;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self showModalEditor];
    return NO;
}

@end