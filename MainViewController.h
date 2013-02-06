//
//  MainViewController.h
//  SHearingClinic
//
//  Created by MobiApp Solutions on 04/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewController.h"
#import "AboutUsViewController.h"
#import "CliniciansViewController.h"
#import "ServicesViewController.h"
#import "ContactMapViewController.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    WelcomeViewController *welcomeView;
    AboutUsViewController *aboutUsView;
    CliniciansViewController *cliniciansView;
    ServicesViewController *servicesView;
    ContactMapViewController *contactMapView;
    
    UIImageView *bgImage;
    UIImageView *bgBarImage;
    
    
    
    
     UITableView *tblMainView;
        
     

}

@property(nonatomic,retain) UIImageView *bgImage;
@property(nonatomic,retain) UIImageView *bgBarImage;

@property(nonatomic,retain) UITableView *tblMainView;

@property(nonatomic,retain) WelcomeViewController *welcomeView;
@property(nonatomic,retain) AboutUsViewController *aboutUsView;
@property(nonatomic,retain) CliniciansViewController *cliniciansView;
@property(nonatomic,retain) ServicesViewController *servicesView;
@property(nonatomic,retain) ContactMapViewController *contactMapView;






@end
