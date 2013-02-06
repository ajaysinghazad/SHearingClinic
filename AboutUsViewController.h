//
//  AboutUsViewController.h
//  SHearingClinic
//
//  Created by MobiApp Solutions on 05/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController<NSXMLParserDelegate,UITextFieldDelegate,UITextViewDelegate>

{
    UIImageView *bgImage;
    UIImageView *bgBarImage;
    
    UIButton *btnBack;
    UITextView *txtMessage;
    
    UIActivityIndicatorView *actIndicator;
    
    NSTimer *timer;
   


}
@property(nonatomic,retain) UIImageView *bgImage;
@property(nonatomic,retain) UIImageView *bgBarImage;
@property(nonatomic,retain) UITextView *txtMessage;
@property(nonatomic,retain) UIButton *btnBack;
@property(nonatomic,retain) UIActivityIndicatorView *actIndicator;
@property(nonatomic,retain) NSTimer *timer;


-(void)infoSendAndGetFromWeb;

-(void)handleTimer;

@end
