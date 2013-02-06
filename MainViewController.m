//
//  MainViewController.m
//  SHearingClinic
//
//  Created by MobiApp Solutions on 04/11/11.
//  Copyright 2011 MAS INDIA [mobiappsolutions@gmail.com]. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize bgImage,bgBarImage,tblMainView;


@synthesize welcomeView,servicesView,aboutUsView,cliniciansView,contactMapView;



NSArray *arrowImage;
NSArray *arrTittletext;


-(void)dealloc
{
     
    [welcomeView release];
    [aboutUsView release];
    [cliniciansView release];
    [servicesView release];
    [contactMapView release];
    [arrowImage release];
    [arrTittletext release];
    
    [tblMainView release];
    
    [bgBarImage release];
    [bgImage release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0,0 ,320,480)];
    
    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    [bgImage setImage:[UIImage imageNamed:@"bgImage.png"]];
    [self.view addSubview:bgImage];
    
    bgBarImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    [bgBarImage setImage:[UIImage imageNamed:@"Header.png"]];
    [self.view addSubview:bgBarImage];
    
    
    
    
    tblMainView=[[UITableView alloc]initWithFrame:CGRectMake(15,90 , 290,400 )style:UITableViewStyleGrouped];
    tblMainView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:tblMainView];
    
    tblMainView.delegate=self;
    tblMainView.dataSource=self;
    
    
    
    
    //[self.view addSubview:actIndicator];
 
    arrowImage=[[NSArray alloc]initWithObjects:@"Arrow.png",@"Arrow.png",@"Arrow.png",@"Arrow.png", nil];
   
    arrTittletext=[[NSArray alloc] initWithObjects:@"Welcome",@"About Us",@"Clinicians",@"Services",@"Contact / Map", nil];
    
     //[actIndicator stopAnimating];
    [super viewDidLoad];
}

#pragma mark Table delegate methods

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	return 0;
//	
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{    
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) 
    {
        if (indexPath.row==4)
        {
            return 70.0;
        }
        else
        {
            return 50.0;
        }
    }
    else
    {
    return 70.0;
    }
}

// Customize the number of rows in the table view.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{		
    if (section==0)
    {
        
        
		return[arrowImage count]+1 ;
	}
    else
    {
        return 1;
        
    }
	
}


// Customize the number of rows in the table view.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	
    
//	//TO GET AVAILABLE FONT
//	
// 	      for (NSString *family in [UIFont familyNames]) 
//            {
//  		       NSLog(@"%@", [UIFont fontNamesForFamilyName:family]);
//            }
//	
	
    
    static NSString *CellIdentifier = @"Cell";
    
    NSLog(@" %i",indexPath.section); 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

        cell.frame=CGRectMake(0, 0, 290, 50);

    }
    
   
    if (indexPath.section==0)
    {
        UIButton *btnImage;
        
        cell.textLabel.textColor=[UIColor colorWithRed:0.0/255.0 green:106.0/255.0 blue:179.0/255.0 alpha:1.0];
        cell.textLabel.font=[UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:22.0];
       
        cell.textLabel.text=[arrTittletext objectAtIndex:indexPath.row];
        

    //Adding a buton in cell
        if (indexPath.row==4) 
        {
           btnImage=[[UIButton alloc] initWithFrame:CGRectMake(250,22,15,20)];
        }
        else
        {
           btnImage=[[UIButton alloc] initWithFrame:CGRectMake(250,15,15,20)];
        }
    [btnImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnImage setTitle:@""forState:UIControlStateNormal];
    //[btnImage addTarget:self action:@selector(NewSchedule) forControlEvents:UIControlEventTouchUpInside];
    [btnImage setUserInteractionEnabled:NO];
            
        
        [btnImage setBackgroundImage:[UIImage imageNamed:@"Arrow2.png"] forState:UIControlStateNormal];
        [cell addSubview:btnImage];
    
    }
    else
    {
        cell.textLabel.textColor=[UIColor colorWithRed:0.0/255.0 green:106.0/255.0 blue:179.0/255.0 alpha:1.0];
        cell.textLabel.font=[UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:28.0];
        cell.textLabel.textAlignment=UITextAlignmentCenter;
        
        cell.textLabel.text=@"03 5022 7333";
 
    
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
    switch (indexPath.row)
    {
                        
        case 0:
            
            welcomeView=[[WelcomeViewController alloc]init];
            [self.view addSubview:welcomeView.view];
            
            
            break;
        case 1:
            //[actIndicator startAnimating];
            aboutUsView=[[AboutUsViewController alloc]init];
            [self.view addSubview:aboutUsView.view];
            
            
            
            
            break;
        case 2:
            //[actIndicator startAnimating];
            cliniciansView=[[CliniciansViewController alloc]init];
            [self.view addSubview:cliniciansView.view];
            
            
            
            break;
        case 3:
            //[actIndicator startAnimating];
            servicesView=[[ServicesViewController alloc]init];
            [self.view addSubview:servicesView.view];
            
            
            
            break;
        case 4:
            //[actIndicator stopAnimating];
            contactMapView=[[ContactMapViewController alloc]init];
            [self.view addSubview:contactMapView.view];
            
            
            
            break;
        default:
            break;
            
    }

   } 
 else
   {
        NSString *phoneNumber = [@"tel://" stringByAppendingString:@"03-5022-7333"];
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
   }
       
    
    
}
//-(void)timer1
//{
//   
//    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 
//                                             target:self 
//                                           selector:@selector(handleTimer) 
//                                           userInfo:nil 
//                                            repeats:NO]; 
//}




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
