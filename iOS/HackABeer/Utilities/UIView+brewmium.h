//
//  UIView+brewmium.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (brewmium)

- (void)flipWithDirection:(UIViewAnimationTransition)direction fromView:(id)fromView toView:(id)toView;

+ (instancetype)initFromXib:(Class)viewClass;

- (void)dumpParentHierarchy:(NSString *)text indent:(NSString *)indent;
- (void)dumpChildrenHierarchy:(NSString *)text indent:(NSString *)indent;

- (void)poParentsHierarchy:(NSString *)text indent:(NSString *)indent;
- (void)poChildrenHierarchy:(NSString *)text indent:(NSString *)indent;

@end
