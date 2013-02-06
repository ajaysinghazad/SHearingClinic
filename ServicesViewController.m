//
//  ServicesViewController.m
//  SHearingClinic
//
//  Created by MobiApp Solutions on 05/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import "ServicesViewController.h"

@implementation ServicesViewController

@synthesize bgImage,bgBarImage,tblServicesView;
@synthesize btnBack;
@synthesize actIndicator,timer;

NSMutableDictionary *dictFromWeb;
NSMutableArray *arrayFromWebServiceParse;
NSMutableDictionary *dictionaryAfterParseForWelcome;
NSString *strSearchFromWeb;
NSString *strTotalRecords;
int i;
UIImageView *myIconImage;
UILabel *lblHeader;

-(void)dealloc
{
    [lblHeader release];
    [actIndicator release];
    [timer release];
    [myIconImage release];
    [dictionaryAfterParseForWelcome release];
    [arrayFromWebServiceParse release];
    [dictFromWeb release];
    [strTotalRecords release];
    [strSearchFromWeb release];
    [btnBack release];
    [tblServicesView release];
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
		
		
		NSLog(@"%@",[[arrayFromWebServiceParse objectAtIndex:i] objectForKey:@"title="]);
        
        //strSearchFromWeb =[[arrayFromWebServiceParse objectAtIndex:i] objectForKey:@"Icon_Image="] ;
        
    }
    [actIndicator stopAnimating];
    
    
    
    [self.view addSubview:tblServicesView];


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
    
    tblServicesView=[[UITableView alloc]initWithFrame:CGRectMake(0,90,320,391 )style:UITableViewStylePlain];
    tblServicesView.backgroundColor=[UIColor clearColor];
    
    tblServicesView.delegate=self;
    tblServicesView.dataSource=self;
    
    [self.view addSubview:actIndicator];
    [actIndicator startAnimating];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:NO];
    
        
    [super viewDidLoad];
}

-(void)infoSendAndGetFromWeb
{
    
    
    NSMutableURLRequest *req =[[ NSMutableURLRequest alloc ] initWithURL: 
                               [ NSURL URLWithString:@"http://www.sunraysiahearing.com.au/feeds/services.php?"]]; 
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
	if ([elementName isEqualToString:@"li"])
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
	
	if ([string isEqualToString:@"\n"]||[string isEqualToString:@"\n\t\t\t"]||[string isEqualToString:@"\n\t\t"]||[string isEqualToString:@"\n\t"])
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
	if ([elementName isEqualToString:@"li"])
	{
		
		[dictionaryAfterParseForWelcome setValue:dictFromWeb forKey:strTotalRecords];
        
		
	}
	
}


-(void)clkbtnBack
{
    
    [self.view removeFromSuperview];
    
    
}

#pragma mark Table delegate methods


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20.0;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    headerView.backgroundColor=[UIColor clearColor];
//    
//    lblHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 20)];
//    lblHeader.backgroundColor=[UIColor clearColor];
//    lblHeader.textColor=[UIColor whiteColor];
//    lblHeader.font=[UIFont boldSystemFontOfSize:18.0];
//    lblHeader.textAlignment=UITextAlignmentLeft;
//    lblHeader.text=@"Services";
//    
//    
//    [headerView addSubview:lblHeader];
//    
//    
//    return(headerView); 
//    
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	return 0;
//	
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{    
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) 
	{
		return 100.0;
	}
    else
	{
    return 80.0;
	}
    
}

// Customize the number of rows in the table view.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{		
    
    return [arrayFromWebServiceParse count];
    
    
	
}



// Customize the number of rows in the table view.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	
    
    
    static NSString *CellIdentifier = @"Cell";
    
    NSLog(@" %i",indexPath.section); 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (indexPath.row==0)
	{
		if (cell == nil)
			
		{
			
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			
			lblHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 20)];
			lblHeader.backgroundColor=[UIColor clearColor];
			lblHeader.textColor=[UIColor whiteColor];
			lblHeader.font=[UIFont boldSystemFontOfSize:18.0];
			lblHeader.textAlignment=UITextAlignmentLeft;
			lblHeader.text=@"Services";
			[cell.contentView addSubview:lblHeader];
			
			
			UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(90, 25, 230, 20)];
			lblName.backgroundColor=[UIColor clearColor];
			lblName.textColor=[UIColor whiteColor];
			lblName.font=[UIFont boldSystemFontOfSize:14.0];
			lblName.textAlignment=UITextAlignmentLeft;
			lblName.text=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"title="];
			[cell.contentView addSubview:lblName];
			
			//        UILabel *lblDegree=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, 240, 10)];
			//        lblDegree.backgroundColor=[UIColor clearColor];
			//        lblDegree.textColor=[UIColor whiteColor];
			//        lblDegree.font=[UIFont boldSystemFontOfSize:10.0];
			//        lblDegree.textAlignment=UITextAlignmentLeft;
			//        lblDegree.text=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"subtitle="];
			
			UILabel *lblContent=[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 230, 50)];
			lblContent.backgroundColor=[UIColor clearColor];
			[lblContent setNumberOfLines:2];
			lblContent.textColor=[UIColor whiteColor];
			lblContent.font=[UIFont boldSystemFontOfSize:12.0];
			lblContent.textAlignment=UITextAlignmentLeft;
			lblContent.text=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"paragraph="];
			[cell.contentView addSubview:lblContent];
			
			
			NSString *strIconImage=[[NSString alloc]init];
			strIconImage=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"img="];
			
			myIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10,25, 70.0, 70.0)];
			
			UIImage *ImageView =[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strIconImage]]];
			
			NSLog(@"Hello Deepak %@= ",strIconImage);
			[strIconImage release];
			
			myIconImage.image=ImageView;
			
			[cell.contentView addSubview: myIconImage];
			
			[ImageView release];
			
		}
		
	}
	else
	{
	
		

    
    if (cell == nil)
        
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 230, 20)];
        lblName.backgroundColor=[UIColor clearColor];
        lblName.textColor=[UIColor whiteColor];
        lblName.font=[UIFont boldSystemFontOfSize:14.0];
        lblName.textAlignment=UITextAlignmentLeft;
        lblName.text=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"title="];
        [cell.contentView addSubview:lblName];
        
//        UILabel *lblDegree=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, 240, 10)];
//        lblDegree.backgroundColor=[UIColor clearColor];
//        lblDegree.textColor=[UIColor whiteColor];
//        lblDegree.font=[UIFont boldSystemFontOfSize:10.0];
//        lblDegree.textAlignment=UITextAlignmentLeft;
//        lblDegree.text=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"subtitle="];
        
        UILabel *lblContent=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 230, 50)];
        lblContent.backgroundColor=[UIColor clearColor];
        [lblContent setNumberOfLines:2];
        lblContent.textColor=[UIColor whiteColor];
        lblContent.font=[UIFont boldSystemFontOfSize:12.0];
        lblContent.textAlignment=UITextAlignmentLeft;
        lblContent.text=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"paragraph="];
        [cell.contentView addSubview:lblContent];

        
        NSString *strIconImage=[[NSString alloc]init];
		strIconImage=[[arrayFromWebServiceParse objectAtIndex:indexPath.row] objectForKey:@"img="];
        
		myIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10,5, 70.0, 70.0)];
        
		UIImage *ImageView =[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strIconImage]]];
		
		NSLog(@"Hello Deepak %@= ",strIconImage);
		[strIconImage release];
		
		myIconImage.image=ImageView;
		
		[cell.contentView addSubview: myIconImage];
        
        [ImageView release];
        
    }
    }
    
    return cell;
    
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
