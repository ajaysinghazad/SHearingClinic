//
//  SHearingClinicAppDelegate.h
//  SHearingClinic
//
//  Created by MobiApp Solutions on 04/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHearingClinicViewController;

@interface SHearingClinicAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SHearingClinicViewController *viewController;

@end
