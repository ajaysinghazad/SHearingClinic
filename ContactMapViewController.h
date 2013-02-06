//
//  ContractMapViewController.h
//  SHearingClinic
//
//  Created by MobiApp Solutions on 05/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ContactMapViewController : UIViewController<NSXMLParserDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate,UIScrollViewDelegate>
{
    UIImageView *bgImage;
    UIImageView *bgBarImage;
    
    UIButton *btnBack;
    
    UIActivityIndicatorView *actIndicator;
    NSTimer *timer;
	
	UILabel *message;
	
	UIWebView *webMapImage;
	
	UIScrollView *imageScroll;
	
	UIScrollView *scrollView1;
	
	UIImageView *mapImage;
	
	UIButton *btnmap;
	
	
	
	

}
@property(nonatomic,retain) UIImageView *bgImage;
@property(nonatomic,retain) UIImageView *bgBarImage;

@property(nonatomic,retain) UIButton *btnBack;
@property(nonatomic,retain) UIActivityIndicatorView *actIndicator;
@property(nonatomic,retain) NSTimer *timer;

@property(nonatomic,retain) UILabel *message;
@property(nonatomic,retain) UIWebView *webMapImage;

@property(nonatomic,retain) UIScrollView *imageScroll;
@property(nonatomic,retain) UIScrollView *scrollView1;

@property(nonatomic,retain) UIImageView *mapImage;

@property(nonatomic,retain) UIButton *btnMap;

-(void)infoSendAndGetFromWeb;
-(void)handleTimer;

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

- (void) setScrollViewBackground;

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)imageScroll;

@end

