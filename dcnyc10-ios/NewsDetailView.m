//
//  NewsDetailView.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailView.h"

@implementation NewsDetailView

@synthesize article;
@synthesize titleLabel;
@synthesize dateLabel;
@synthesize bodyWebView;
@synthesize scrollView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = article.title;
    
    CGRect frame;
    
    // Date label
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    [dateFormatter setDateFormat:@"EEEE MMMM d, YYYY"];
    dateLabel.text = [dateFormatter stringFromDate:article.created];        

    // Title Label
    titleLabel.text = article.title;
    [titleLabel sizeToFit];
    
    [bodyWebView loadHTMLString:article.body baseURL:[NSURL URLWithString:@"http://drupalcampnyc.org/"]];
    frame = bodyWebView.frame;
    frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height + 20.0;
    frame.size.height = 1;
    bodyWebView.frame = frame;
    CGSize fittingSize = [bodyWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    bodyWebView.frame = frame;

    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, bodyWebView.frame.origin.y + bodyWebView.frame.size.height); 
    
    UIImage *tileImage = [UIImage imageNamed:@"bg-repeat_light.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:tileImage];
    [tileImage release];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    CGRect frame = bodyWebView.frame;
    frame.size.height = 1;
    bodyWebView.frame = frame;
    CGSize fittingSize = [bodyWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    bodyWebView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);


    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, bodyWebView.frame.origin.y + bodyWebView.frame.size.height); 
}

@end
