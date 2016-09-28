//
//  TestsTableViewController.h
//  Pods
//
//  Created by David on 16/9/26.
//
//

#import <UIKit/UIKit.h>

@interface TestsTableViewController : UITableViewController

@end

@interface myCell : UITableViewCell

@property (nonatomic, strong) UILabel *name;

@end

@interface myHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) void (^click)();
- (void)setHeaderWithName:(NSString *) name selected:(BOOL)isSelected;
@end
