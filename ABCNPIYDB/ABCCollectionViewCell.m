//
//  LDCollectionViewCell.m
//  LivelyDemo
//
//  Created by Patrick Nollet on 07/03/2014.
//
//

#import "ABCCollectionViewCell.h"

@implementation ABCCollectionViewCell
@synthesize detailsTableView, headerArray, detailArray;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) prepareForReuse{
    self.name.text = @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    [detailsTableView setBounces:NO ];
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Cell TableView Data Count = %zd", [self.detailArray count]);
    return [self.detailArray count] -1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 15.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bla"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bla"];
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    NSString *strData;
    
    NSString *trimmedString = [[self.detailArray objectAtIndex:indexPath.row + 1] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString length] != 0) {
        strData = [NSString stringWithFormat:@"%@ : %@", [self.headerArray objectAtIndex:indexPath.row + 1], [self.detailArray objectAtIndex:indexPath.row + 1]];
        cell.textLabel.textColor  = [UIColor blueColor];
    }
    else{
        strData = [NSString stringWithFormat:@"%@", [self.headerArray objectAtIndex:indexPath.row + 1]];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    NSString *itemData = [ NSString stringWithString:strData];
    NSMutableAttributedString *attribString = [[NSMutableAttributedString alloc]initWithString:itemData];
    [attribString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [itemData length])];

    cell.textLabel.attributedText = attribString;

    
    return cell;
}

@end
