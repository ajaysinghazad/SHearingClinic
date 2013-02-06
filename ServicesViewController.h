//
//  ServicesViewController.h
//  SHearingClinic
//
//  Created by MobiApp Solutions on 05/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesViewController : UIViewController<NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
{

    UIImageView *bgImage;
    UIImageView *bgBarImage;
    UITableView *tblServicesView;
    UIButton *btnBack;
    
    UIActivityIndicatorView *actIndicator;
    NSTimer *timer;

}

@property(nonatomic,retain) UIImageView *bgImage;
@property(nonatomic,retain) UIImageView *bgBarImage;
@property(nonatomic,retain) UITableView *tblServicesView;
@property(nonatomic,retain) UIButton *btnBack;
@property(nonatomic,retain) UIActivityIndicatorView *actIndicator;
@property(nonatomic,retain) NSTimer *timer;

-(void)infoSendAndGetFromWeb;
-(void)handleTimer;
@end
