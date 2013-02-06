//
//  WelcomeViewController.m
//  SHearingClinic
//
//  Created by MobiApp Solutions on 05/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import "WelcomeViewController.h"


@implementation WelcomeViewController

@synthesize bgImage,bgBarImage;
@synthesize btnBack,txtMessage;
@synthesize actIndicator,timer;

NSMutableDictionary *dictFromWeb;
NSMutableArray *arrayFromWebServiceParse;
NSMutableDictionary *dictionaryAfterParseForWelcome;
NSString *strSearchFromWeb;
NSString *strTotalRecords;
int i;
UILabel *lblHeader;


-(void)dealloc
{
    [lblHeader release];
    [actIndicator release];
    [timer release];
    [txtMessage release];
    [dictionaryAfterParseForWelcome release];
    [arrayFromWebServiceParse release];
    [dictFromWeb release];
    [strTotalRecords release];
    [strSearchFromWeb release];
    [btnBack release];
    
    [bgBarImage release];
    [bgImage release];
    [super dealloc];

    
    
}

-(void)handleTimer
{

    [self infoSendAndGetFromWeb];
    
    
    int j=0;
	
    [arrayFromWebServiceParse removeAllObjects];
	for (i=0; i < [dictionaryAfterParseForWelcome count]; i++)
	{
		j=j+1;
		NSString *stringValueofJ=[[NSString alloc]initWithFormat:@"%i",j];
		
		[arrayFromWebServiceParse addObject:[dictionaryAfterParseForWelcome objectForKey:stringValueofJ]];
		
		
		//NSLog(@"%@",[[arrayFromWebServiceParse objectAtIndex:i] objectForKey:@"p="]);
        
        strSearchFromWeb =[[arrayFromWebServiceParse objectAtIndex:i] objectForKey:@"paragraph="] ;
        
        
        
    }
    
    [actIndicator stopAnimating];
    lblHeader.text=@"Welcome";
    txtMessage.text=strSearchFromWeb;
    
    
    

    
    
    //[timer invalidate];
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//    [actIndicator stopAnimating];
//    
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    //[actIndicator startAnimating];
     
    
    
    dictionaryAfterParseForWelcome=[[NSMutableDictionary alloc]init];
    strTotalRecords=[[NSString alloc]initWithString:@"0"];
    strSearchFromWeb=[[NSString alloc]init];
    arrayFromWebServiceParse=[[NSMutableArray alloc]init];
    
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0,0 ,320,480)];
    
    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    [bgImage setImage:[UIImage imageNamed:@"bgImage.png"]];
        
    bgBarImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    [bgBarImage setImage:[UIImage imageNamed:@"Header.png"]];
    
    
    btnBack=[[UIButton alloc] initWithFrame:CGRectMake(240,30,68,22)];
    [btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBack setTitle:@""forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"iconBack.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clkbtnBack) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setUserInteractionEnabled:YES];
   
    
    lblHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 320, 20)];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textColor=[UIColor whiteColor];
    lblHeader.font=[UIFont boldSystemFontOfSize:18.0];
    lblHeader.textAlignment=UITextAlignmentLeft;
    
    
    
    actIndicator=[[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]autorelease];
    actIndicator.frame=CGRectMake(0.0, 0.0, 40.0, 40.0);
    actIndicator.center=self.view.center;
    
        
    txtMessage=[[UITextView alloc]initWithFrame:CGRectMake(10, 115, 290, 365)];	//30, 150, 260, 125	
    txtMessage.font=[UIFont fontWithName:@"Arial" size:12.0];
    txtMessage.textColor = [UIColor whiteColor];
    txtMessage.backgroundColor=[UIColor clearColor];
    txtMessage.returnKeyType=UIReturnKeyDone;
    txtMessage.userInteractionEnabled=NO;
    //txtMessage.keyboardType=UIKeyboardTypeDefault;    
    txtMessage.delegate=self;
    
    
    [self.view addSubview:bgImage];
    [self.view addSubview:bgBarImage];
    [self.view addSubview:btnBack];
    [self.view addSubview:lblHeader];
    [self.view addSubview:txtMessage];
    
    [self.view addSubview:actIndicator];
    
    [actIndicator startAnimating];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:NO];
    
        
    //[self infoSendAndGetFromWeb];
       
    [super viewDidLoad];
    
}

-(void)infoSendAndGetFromWeb
{
    
   
    NSMutableURLRequest *req =[[ NSMutableURLRequest alloc ] initWithURL: 
                               [ NSURL URLWithString:@"http://www.sunraysiahearing.com.au/feeds/welcome.php?"]]; 
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

static NSString  *strTag;

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict 
{
	
	strTag=elementName;
	if ([elementName isEqualToString:@"pagecontent"])
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
	if ([elementName isEqualToString:@"pagecontent"])
	{
		
		[dictionaryAfterParseForWelcome setValue:dictFromWeb forKey:strTotalRecords];
		
	}
	
}


-(void)clkbtnBack
{
//    MainViewController *mainView=[[MainViewController alloc]init];
//    [self.view addSubview:mainView.view];

    [self.view removeFromSuperview];


}




- (void)viewDidUnload
{
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
