//
//  ViewController.h
//  HackABeer
//
//  Created by Eric Hayes on 5/23/15.
//  Copyright (c) 2015 Eric Hayes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *flipContainer;
@property (strong, nonatomic) IBOutlet UIView *configContainer;
@property (strong, nonatomic) IBOutlet UIView *tapContainer;
@property (strong, nonatomic) IBOutlet UIView *aboutContainer;

@property (strong, nonatomic) IBOutlet UILabel *palePulls;
@property (strong, nonatomic) IBOutlet UIImageView *palePulling;
@property (strong, nonatomic) IBOutlet UILabel *paleTemp;
@property (strong, nonatomic) IBOutlet UILabel *paleIdle;

@property (strong, nonatomic) IBOutlet UILabel *ipaPulls;
@property (strong, nonatomic) IBOutlet UILabel *ipaTemp;
@property (strong, nonatomic) IBOutlet UIImageView *ipaPulling;
@property (strong, nonatomic) IBOutlet UILabel *ipaIdle;

@end

