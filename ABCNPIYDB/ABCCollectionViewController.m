//
//  ABCCollectionViewController.m
//  ABCNPIYDB
//
//  Created by Vijayakumar C on 18/8/14.
//  Copyright (c) 2014 Jabil. All rights reserved.
//

#import "ABCCollectionViewController.h"
#import "ABCCollectionViewFlowLayout.h"
#import "ABCCollectionViewCell.h"
#import "Station.h"
#import "ABCCollectionViewHeaderCell.h"
#import "ABCConfigurationViewController.h"
#import "TFHpple.h"
#import "HttpService.h"


#define DEF_CONFIG_OPTIONS @"//html/body/form/div/div/div/table/tr/td/select/option"
#define DEF_FOOTER_ITEMS  @"//html/body/form/div/div/div/table/tr/th"
#define DEF_HEADER_ITMES    @"//html/body/form/div/div/div/div/table/tr/th"
#define DEF_STATION_DETAILS @"//html/body/form/div/div/div/div/table/tr/td"


@interface ABCCollectionViewController()
{
}
@property (nonatomic, strong) ABCCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) HttpDashBoardDownloadService *httpDashBoardService;
@property (nonatomic, strong)  NSMutableArray *arrayStationDetails;
@property (nonatomic, strong) NSMutableArray *arrayHeaderItems;

@end

static NSString *ItemIdentifier = @"Cell";

@implementation ABCCollectionViewController

- (void) loadView{
    self.arrayHeaderItems = [[NSMutableArray alloc] init];
    self.arrayStationDetails = [[NSMutableArray alloc] init];

    self.flowLayout = [[ABCCollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    [self.collectionView registerClass:[ABCCollectionViewCell class] forCellWithReuseIdentifier:ItemIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ABCCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ItemIdentifier];
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"ABCCollectionViewHeaderCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

    [self.collectionView registerNib:[UINib nibWithNibName:@"ABCCollectionViewHeaderCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];

   
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    
    self.httpDashBoardService = [[HttpDashBoardDownloadService alloc] init ];
    [self.httpDashBoardService postDataToDashBoard:@"http://sinwuxappdev02/ABCNPIYDB3/Default.aspx?Type=First" username:@"CV" password:@"c_vijay12345" delegate:self];
}

- ( void) viewDidLoad{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;

    label.textColor = [UIColor purpleColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = @"ABCNPIY Dashboard";
    [label sizeToFit];
    
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(settingConfig:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    /*UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"FP Yield", @"FP Yield"]];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentedControlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)segmentedControl];
    self.navigationItem.leftBarButtonItem = segmentedControlButtonItem;
    */
    
}
- (IBAction)settingConfig:(id)sender{
    ABCConfigurationViewController *configController = [[ABCConfigurationViewController alloc] initWithNibName:@"ABCConfigurationViewController" bundle:nil];
    [self.navigationController pushViewController:configController animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"Station Count = %zd", [self.arrayStationDetails count]);
    return [self.arrayStationDetails count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    return CGSizeMake(0, 30);
}

/*- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(0, 30);
}*/

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        ABCCollectionViewHeaderCell *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];

        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"dd-MM-yyyy";
        headerView.lblTitle.text = [NSString stringWithFormat:@"%@",  [format stringFromDate:[NSDate new]] ];
        reusableview = headerView;

    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        
        ABCCollectionViewHeaderCell *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"dd-MM-yyyy";
        footerview.lblTitle.text = [format stringFromDate:[NSDate new]];
        footerview.backgroundColor  = [UIColor colorWithRed:256.0 green:10.0 blue:233.0 alpha:1.0];
        reusableview = footerview;
    }
    return reusableview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Cell";
    
    ABCCollectionViewCell * cell = (ABCCollectionViewCell * )[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell.backgroundView) {
        UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        cell.backgroundView = backgroundView;
    }

    cell.name.text = [[self.arrayStationDetails objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.headerArray = self.arrayHeaderItems;
    cell.detailArray = [self.arrayStationDetails objectAtIndex:indexPath.row];
    //refresh the station display
    [cell.detailsTableView reloadData];
    NSLog(@"CELL [%zd] : %@",indexPath.row, cell.detailArray);
    UIColor * altBackgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    cell.backgroundView.backgroundColor = [indexPath row] % 2 == 0 ? [UIColor whiteColor] : altBackgroundColor;
    cell.name.backgroundColor = [UIColor colorWithRed:0.1 green:343.0 blue:1.0 alpha:1.0f];
    return cell;
}

-(void) httpDashBoardData:(HttpDashBoardDownloadService*)service result:(NSData*)result{
    
    NSString *data =[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] ;
    NSLog(@"http result = %@\n", data);
    
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:result];
    NSMutableArray *arrayConfig = [[NSMutableArray alloc] init];
    [self getData:tutorialsParser ForXPathElement:DEF_CONFIG_OPTIONS fillWithArray:arrayConfig];
    
    NSMutableArray *arrayFooterItems = [[NSMutableArray alloc] init];
    [self getData:tutorialsParser ForXPathElement:DEF_FOOTER_ITEMS fillWithArray:arrayFooterItems ];
    
    [self getData:tutorialsParser ForXPathElement:DEF_HEADER_ITMES fillWithArray:self.arrayHeaderItems];
    
    [self getArrayOfData:tutorialsParser ForXPathElement:DEF_STATION_DETAILS fillWithArray:self.arrayStationDetails];
    
    [self.collectionView reloadData];
    
}


- (void) getData:(TFHpple*) tFHpple ForXPathElement:(NSString*)xPathElement fillWithArray:(NSMutableArray*)dataArray {

    NSArray *node = [ tFHpple searchWithXPathQuery:xPathElement];

    for (TFHppleElement *element in node) {
        for (TFHppleElement *child in element.children) {
            if ([child.tagName isEqualToString:@"text"]) {
                NSLog(@"%@", [child content]);
                [dataArray addObject:[child content]];
            }
        }
    }
}

- (void) getArrayOfData:(TFHpple*) tFHpple ForXPathElement:(NSString*)xPathElement fillWithArray:(NSMutableArray*)dataArray {
    NSArray *node = [ tFHpple searchWithXPathQuery:xPathElement];
    int rowIndex = 1;
    int columnIndex = 0;
    NSMutableArray *arrayItem = [[NSMutableArray alloc] init];

    for (TFHppleElement *element in node) {
        for (TFHppleElement *child in element.children) {
            columnIndex++;
            if ([child.tagName isEqualToString:@"text"]) {
                //NSLog(@"%@", [child content]);
                [arrayItem addObject:[child content]];
            }
        }
        if (columnIndex == [self.arrayHeaderItems count]) {
            NSLog(@"Row = %zd, %@", rowIndex, arrayItem);
            rowIndex++;
            [dataArray addObject:arrayItem];
            arrayItem = [[NSMutableArray alloc] init];
            columnIndex = 0;
        }
    }
}
@end
