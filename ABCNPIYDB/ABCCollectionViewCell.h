//
//  LDCollectionViewCell.h
//  LivelyDemo
//
//  Created by Patrick Nollet on 07/03/2014.
//
//

#import <UIKit/UIKit.h>

@interface ABCCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;
@property (strong, nonatomic) NSMutableArray *headerArray;
@property (strong, nonatomic) NSMutableArray *detailArray;
@end
