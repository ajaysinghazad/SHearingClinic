//
//  ContractMapViewController.m
//  SHearingClinic
//
//  Created by MobiApp Solutions on 05/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import "ContactMapViewController.h"


@implementation ContactMapViewController

@synthesize bgImage,bgBarImage;//tblContactMapView;
@synthesize btnBack;
@synthesize actIndicator,timer;

@synthesize message;
@synthesize webMapImage;

@synthesize imageScroll;
@synthesize scrollView1;
@synthesize mapImage;
@synthesize btnMap;

NSMutableDictionary *dictFromWeb;
NSMutableArray *arrayFromWebServiceParse;
NSMutableDictionary *dictionaryAfterParseForWelcome;
NSString *strSearchFromWeb;
NSString *strTotalRecords;
int i;

UILabel *lblHeader;
UILabel *lblPhone;
UILabel *lblPhoneNumber;
UILabel *lblFax;
UILabel *lblFaxNumber;
UILabel *lblEmail;
UILabel *lblEmailAdd;
UILabel *lblWeb;
UILabel *lblWebName;
UILabel *lblPlane;
UILabel *lblImageName;



UIButton *btnEmail;
UIButton *btnweb;
UIButton *btnPhone;






-(void)dealloc
{
	[btnMap release];
	
    [webMapImage release];	
	[imageScroll release];
	[message release];
	
	[btnEmail release];
	[btnweb release];
	[btnPhone release];
	
    [mapImage release];
    [lblHeader release];
    [scrollView1 release];
    [lblHeader release];
    [lblPhone release];
    [lblPhoneNumber release];
    [lblFax release];
    [lblFaxNumber release];
    [lblEmail release];
    [lblEmailAdd release];
    [lblWeb release];
    [lblWebName release];
    [lblPlane release];
    [lblImageName release];
    //[myIconImage release];
    [dictionaryAfterParseForWelcome release];
    [arrayFromWebServiceParse release];
    [dictFromWeb release];
    [strTotalRecords release];
    [strSearchFromWeb release];
    [btnBack release];
    //[tblContactMapView release];
    [bgBarImage release];
    [bgImage release];
    [super dealloc];
    
    
    
}

-(void)handleTimer
{
   [self infoSendAndGetFromWeb];
    
    int j=0;
	
	for (i=0; i < [dictionaryAfterParseForWelcome count]; i++)
	{
		j=j+1;
		NSString *stringValueofJ=[[NSString alloc]initWithFormat:@"%i",j];
		
		[arrayFromWebServiceParse addObject:[dictionaryAfterParseForWelcome objectForKey:stringValueofJ]];
		
		
		//NSLog(@"%@",[[arrayFromWebServiceParse objectAtIndex:i] objectForKey:@"Address="]);
        
        
        
    }
    
    lblHeader.text=@"Contact";
    lblPhone.text=[[arrayFromWebServiceParse objectAtIndex:0] objectForKey:@"dt="];
	[btnPhone setTitle:[[arrayFromWebServiceParse objectAtIndex:0] objectForKey:@"dd="] forState:UIControlStateNormal];

    //lblPhoneNumber.text=[[arrayFromWebServiceParse objectAtIndex:0] objectForKey:@"dd="];
    lblFax.text=[[arrayFromWebServiceParse objectAtIndex:1] objectForKey:@"dt="];
    lblFaxNumber.text=[[arrayFromWebServiceParse objectAtIndex:1] objectForKey:@"dd="];
    lblEmail.text=[[arrayFromWebServiceParse objectAtIndex:2] objectForKey:@"dt="];
	
	[btnEmail setTitle:[[arrayFromWebServiceParse objectAtIndex:2] objectForKey:@"dd="] forState:UIControlStateNormal];
		
    //lblEmailAdd.text=[[arrayFromWebServiceParse objectAtIndex:2] objectForKey:@"dd="];
    lblWeb.text=[[arrayFromWebServiceParse objectAtIndex:3] objectForKey:@"dt="];
	[btnweb setTitle:[[arrayFromWebServiceParse objectAtIndex:3] objectForKey:@"dd="] forState:UIControlStateNormal];

    //lblWebName.text=[[arrayFromWebServiceParse objectAtIndex:3] objectForKey:@"dd="];
    lblImageName.text=[[arrayFromWebServiceParse objectAtIndex:3] objectForKey:@"paragraph="];
	
    //mapImage.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[arrayFromWebServiceParse objectAtIndex:3] objectForKey:@"img="]]]];
    
	
	
	[self.view addSubview:lblHeader];
    [self.view addSubview:lblPhone];
    [self.view addSubview:btnPhone];
    [self.view addSubview:lblFax];
    [self.view addSubview:lblFaxNumber];
    [self.view addSubview:lblEmail];
	[self.view addSubview:lblEmailAdd];
	[self.view addSubview:btnEmail];
    [self.view addSubview:lblWeb];
	[self.view addSubview:lblWebName];
	[self.view addSubview:btnweb];
    [self.view addSubview:lblPlane];
    [self.view addSubview:lblImageName];
    [self.view addSubview:scrollView1];
    [actIndicator stopAnimating];

    
}

-(void)clkbtnEmail
{
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
	
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Hello from Sunraysia Hearig Clinic!"];
	
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"info@sunraysiahearing.com.au"]; 
	NSArray *ccRecipients = [NSArray arrayWithObjects:@"", nil]; 
	NSArray *bccRecipients = [NSArray arrayWithObject:@""]; 
	
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];	
	[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"icon114" ofType:@"png"];
    NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"icon114"];
	
	// Fill out the email body text
	NSString *emailBody = @"This application is running successfully. ";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(void)clkbtnweb
{

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sunraysiahearing.com.au/"]];
}

-(void)clkbtnPhone
{
	NSString *phoneNumber = [@"tel://" stringByAppendingString:@"03-5022-7333"];
    
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
	
}


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
		
    actIndicator=[[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]autorelease];
    actIndicator.frame=CGRectMake(0.0, 0.0, 40.0, 40.0);
    actIndicator.center=self.view.center;
    
    dictionaryAfterParseForWelcome=[[NSMutableDictionary alloc]init];
    arrayFromWebServiceParse=[[NSMutableArray alloc]init];
    strTotalRecords=[[NSString alloc]initWithString:@"0"];
    
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0,0 ,320,480)];
    
    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    [bgImage setImage:[UIImage imageNamed:@"bgImage.png"]];
    [self.view addSubview:bgImage];
    
    bgBarImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    [bgBarImage setImage:[UIImage imageNamed:@"Header.png"]];
    [self.view addSubview:bgBarImage];
    
    btnBack=[[UIButton alloc] initWithFrame:CGRectMake(240,30,68,22)];
    [btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBack setTitle:@""forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"iconBack.png"] forState:UIControlStateNormal];
	
    [btnBack addTarget:self action:@selector(clkbtnBack) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setUserInteractionEnabled:YES];
    [self.view addSubview:btnBack];
    
    
        lblHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 320, 20)];
        lblHeader.backgroundColor=[UIColor clearColor];
        lblHeader.textColor=[UIColor whiteColor];
        lblHeader.font=[UIFont boldSystemFontOfSize:18.0];
        lblHeader.textAlignment=UITextAlignmentLeft;
        
       //[self.view addSubview:lblHeader];
    
          
    
     scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0,250,self.view.frame.size.width,self.view.frame.size.height)];
     //[scrollView1 zoomToRect:CGRectMake(0, 0, imageScroll.contentSize.width, imageScroll.contentSize.height) animated:YES];
	scrollView1.contentSize = CGSizeMake(320, 300);
	//scrollView1=[[UIScrollView alloc]init];
//	[scrollView1 zoomToRect:CGRectMake(0, 0, imageScroll.contentSize.width, imageScroll.contentSize.height) animated:YES];
	//scrollView1.contentSize = CGSizeMake(320, 550);
	
	
	//imageScroll= [[UIScrollView alloc] initWithFrame:CGRectMake(5,220,self.view.frame.size.width,self.view.frame.size.height)];
	
	//imageScroll= [[UIScrollView alloc] initWithFrame:CGRectMake(5,200,self.view.frame.size.width,self.view.frame.size.height)];
	//[imageScroll zoomToRect:CGRectMake(0, 0, imageScroll.contentSize.width, imageScroll.contentSize.height) animated:YES];
//	[imageScroll zoomToRect:CGRectMake(50, 50, 100, 200) animated:YES];
//	 //imageScroll.contentSize = CGSizeMake(400, 550);
    
    
    lblPhone=[[UILabel alloc]initWithFrame:CGRectMake(10, 120, 80, 20)];
    lblPhone.backgroundColor=[UIColor clearColor];
    lblPhone.textColor=[UIColor whiteColor];
    lblPhone.font=[UIFont boldSystemFontOfSize:12.0];
    lblPhone.textAlignment=UITextAlignmentLeft;             
    
	btnPhone=[[UIButton alloc] initWithFrame:CGRectMake(100, 120, 97, 20)];
    [btnPhone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnPhone.titleLabel.font  = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
    [btnPhone setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
	[btnPhone addTarget:self action:@selector(clkbtnPhone) forControlEvents:UIControlEventTouchUpInside];
    [btnPhone setUserInteractionEnabled:YES];
    
    
    lblPhoneNumber=[[UILabel alloc]initWithFrame:CGRectMake(100, 120, 220, 20)];
    lblPhoneNumber.backgroundColor=[UIColor clearColor];
    lblPhoneNumber.textColor=[UIColor whiteColor];
    lblPhoneNumber.font=[UIFont boldSystemFontOfSize:12.0];
    lblPhoneNumber.textAlignment=UITextAlignmentLeft;             
    
    
    lblFax=[[UILabel alloc]initWithFrame:CGRectMake(10, 145, 80, 20)];
    lblFax.backgroundColor=[UIColor clearColor];
    lblFax.textColor=[UIColor whiteColor];
    lblFax.font=[UIFont boldSystemFontOfSize:12.0];
    lblFax.textAlignment=UITextAlignmentLeft;
    
    
    
    lblFaxNumber=[[UILabel alloc]initWithFrame:CGRectMake(100, 145, 220, 20)];
    lblFaxNumber.backgroundColor=[UIColor clearColor];
    lblFaxNumber.textColor=[UIColor whiteColor];
    lblFaxNumber.font=[UIFont boldSystemFontOfSize:12.0];
    lblFaxNumber.textAlignment=UITextAlignmentLeft;
    
    
    
    lblEmail=[[UILabel alloc]initWithFrame:CGRectMake(10, 170, 80, 20)];
    lblEmail.backgroundColor=[UIColor clearColor];
    lblEmail.textColor=[UIColor whiteColor];
    lblEmail.font=[UIFont boldSystemFontOfSize:12.0];
    lblEmail.textAlignment=UITextAlignmentLeft;
	
	
	btnEmail=[[UIButton alloc] initWithFrame:CGRectMake(100, 170, 200, 20)];
    [btnEmail setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnEmail.titleLabel.font  = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
    [btnEmail setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
	[btnEmail addTarget:self action:@selector(clkbtnEmail) forControlEvents:UIControlEventTouchUpInside];
    [btnEmail setUserInteractionEnabled:YES];
   
    
    lblEmailAdd=[[UILabel alloc]initWithFrame:CGRectMake(101, 186, 197, 2)];
    lblEmailAdd.backgroundColor=[UIColor blueColor];

    
    lblWeb=[[UILabel alloc]initWithFrame:CGRectMake(10, 195, 80, 20)];
    lblWeb.backgroundColor=[UIColor clearColor];
    lblWeb.textColor=[UIColor whiteColor];
    lblWeb.font=[UIFont boldSystemFontOfSize:12.0];
    lblWeb.textAlignment=UITextAlignmentLeft;
	
	
	btnweb=[[UIButton alloc] initWithFrame:CGRectMake(100, 195, 200, 20)];
    [btnweb setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnweb.titleLabel.font  = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
    [btnweb setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
	[btnweb addTarget:self action:@selector(clkbtnweb) forControlEvents:UIControlEventTouchUpInside];
    [btnweb setUserInteractionEnabled:YES];
   
    
    lblWebName=[[UILabel alloc]initWithFrame:CGRectMake(102, 212, 200, 2)];
    lblWebName.backgroundColor=[UIColor blueColor];
      
    
    lblPlane=[[UILabel alloc]initWithFrame:CGRectMake(0, 220, 320, 1)];
    lblPlane.backgroundColor=[UIColor whiteColor];
    
    
    lblImageName=[[UILabel alloc]initWithFrame:CGRectMake(10, 225, 310, 20)];
    lblImageName.backgroundColor=[UIColor clearColor];
    lblImageName.textColor=[UIColor whiteColor];
    lblImageName.font=[UIFont boldSystemFontOfSize:12.0];
    lblImageName.textAlignment=UITextAlignmentLeft;
   
	mapImage=[[UIImageView alloc]initWithFrame:CGRectMake(6,10,300,227)];
   [mapImage setImage:[UIImage imageNamed:@"map.png"]];
	
	
	btnMap=[[UIButton alloc] initWithFrame:CGRectMake(6,10,300,227)];
    [btnMap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMap setTitle:@""forState:UIControlStateNormal];
    [btnMap setBackgroundImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];
	[btnMap addTarget:self action:@selector(clkbtnMap) forControlEvents:UIControlEventTouchUpInside];
    [btnMap setUserInteractionEnabled:YES];
	

	// NSString *filePath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"png"];
//	NSURL *url=[NSURL fileURLWithPath:filePath]; 
//	
	
	NSString *mapUrl = [NSString stringWithFormat: @"http://maps.google.com/maps?q=Sunraysia+Hearing+Clinic,+Ontario+Avenue,+Mildura,+Victoria,+Australia&hl=en&sll=37.0625,-95.677068&sspn=38.008397,65.830078&vpsrc=0&hq=Sunraysia+Hearing+Clinic,&hnear=Ontario+Ave,+Mildura+Victoria+3500,+Australia&t=m&z=14"]; 
	NSURL *url = [NSURL URLWithString:mapUrl]; 
	
	
	webMapImage=[[UIWebView alloc]initWithFrame:CGRectMake(10, -50, 300, 270)];
	//[self.webMapImage loadRequest:[NSURLRequest requestWithURL:url]];
	webMapImage.delegate=self;
	
	[self.webMapImage loadRequest:[NSURLRequest requestWithURL:url]];
	
	//imageScroll=[[UIScrollView alloc]init];
//	imageScroll.contentSize = mapImage.frame.size;
//	[imageScroll addSubview:mapImage];
//	imageScroll.minimumZoomScale = 0.4;
//	imageScroll.maximumZoomScale = 4.0;
//	imageScroll.delegate = self;
//	[imageScroll setZoomScale:imageScroll.minimumZoomScale];
	
	//scrollView1=[[UIScrollView alloc]init];
	//scrollView1.contentSize = mapImage.frame.size;
	//[scrollView1 addSubview:mapImage];
//	scrollView1.minimumZoomScale = 0.4;
//	scrollView1.maximumZoomScale = 4.0;
//	scrollView1.delegate = self;
//	[scrollView1 setZoomScale:scrollView1.minimumZoomScale];
	
	
	//UIScrollView *sv = [[webMapImage subviews] objectAtIndex:0];
	//[sv zoomToRect:CGRectMake(0, 0, sv.contentSize.width, sv.contentSize.height) animated:YES];
	
	//[imageScroll addSubview:mapImage];
	
	//[self.view addSubview:scrollView1];
	
	//[scrollView1 addSubview:btnMap];
    
	[self.view addSubview:actIndicator];
    [actIndicator startAnimating];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:NO];
    
       
      [super viewDidLoad];
}

-(void)clkbtnMap
{
	

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"For more information go on http://www.sunraysiahearing.com.au/ " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
	
	[alert show];
	[alert release];


}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)imageScroll
//{
//	return mapImage;
//	
//	
//}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"started loading");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[scrollView1 addSubview:webMapImage];
	//[myWebView addSubview:btnHome];
	
}
//Error handling
 - (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
	 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
			 error.localizedDescription];
	[self.webMapImage loadHTMLString:errorString baseURL:nil];
}

-(void)infoSendAndGetFromWeb
{
    
    
    NSMutableURLRequest *req =[[ NSMutableURLRequest alloc ] initWithURL: 
                               [ NSURL URLWithString:@"http://www.sunraysiahearing.com.au/feeds/contact.php?"]]; 
    NSMutableString *postBody =[NSMutableString stringWithFormat:@""];
    
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [req setHTTPBody:[postBody dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPMethod:@"POST"];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    
    [req release];
    
    //XML Parser Initialize
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:urlData];
    [parser setDelegate:self];        
    [parser parse];
       
}

# pragma mark degate Methods of xml parser

static NSString *strTag;


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict 
{
	
	strTag=elementName;
	if ([elementName isEqualToString:@"dl"] )
	{
		
		dictFromWeb=[[NSMutableDictionary alloc]init];
		int total=[strTotalRecords intValue];
		total=total+1;
		strTotalRecords=[NSString stringWithFormat:@"%i",total];
               
	}
    
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	NSLog(@"%@",string);
	
	if ([string isEqualToString:@"\n"] || [string isEqualToString:@"\n\t\t\t"] ||  [string isEqualToString:@"\n\t\t"]||[string isEqualToString:@"\n\t"])
	{
		
	}
	else
	{
		NSString *strTagName=[[NSString alloc]initWithFormat:@"%@=",strTag];
		
		[dictFromWeb setObject:string forKey:strTagName];		
		
		[strTagName release];
	}
	
	
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName 
{
	if ([elementName isEqualToString:@"dl"])
	{
		
		[dictionaryAfterParseForWelcome setValue:dictFromWeb forKey:strTotalRecords];
        
		
	}
	
}


# pragma mark degate Methods of xml parser

static NSString *strTag;



-(void)clkbtnBack
{
    
    [self.view removeFromSuperview];
    
    
}


//            
//            NSString *strIconImage=[[NSString alloc]init];
//            strIconImage=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"img="];
//            
//            myIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320.0, 360.0)];
//            
//            UIImage *ImageView =[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strIconImage]]];
//            
//            NSLog(@"Hello Deepak %@= ",strIconImage);
//            [strIconImage release];
//            
//            myIconImage.image=ImageView;
//            
//            [cell.contentView addSubview: myIconImage];
//            
//            [ImageView release];
//        
//        }
//        
//        
//        
//    }
//    
//    
//    return cell;
//    
//}


- (void)viewDidUnload
{
	self.message = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
