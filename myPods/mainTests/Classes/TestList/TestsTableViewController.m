//
//  TestsTableViewController.m
//  Pods
//
//  Created by David on 16/9/26.
//
//

#import "TestsTableViewController.h"
#import "ScrollViewPage.h"
#import "EmptyPage.h"
#import "ThereDTouchPage.h"
#import "SelfUIControlPage.h"
#import "RACCommandViewPage.h"
#import "FormControlPage.h"
#import "UICollectionViewDemo1Page.h"
#import "CameraViewController.h"

@interface TestsTableViewController ()

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *tableSeleted;

@end

@implementation TestsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self setupTableView];
    [self initData];
}

- (void)initData
{
    _tableData = @[
                   @{@"2016-Q3":@[
                             @{@"scroll view绘制过程":[ScrollViewPage class]},
                             @{@"self UI控件":[SelfUIControlPage class]},
                             @{@"3D Touch":[ThereDTouchPage class]}
                             ]},
                   @{@"2016-Q4":@[
                             @{@"wifi信息":[RACCommandViewPage class]},
                             @{@"form view":[FormControlPage class]},
                             @{@"UICollectionView 1":[UICollectionViewDemo1Page class]}
                             ]},
                   @{@"2017-Q1":@[
                             @{@"720图片采集相机":[CameraViewController class]},
                             @{@"test":[EmptyPage class]}
                             ]}
                   ];
    _tableSeleted = [[NSMutableArray alloc]init];
    [_tableData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_tableSeleted addObject:@NO];
    }];
}

- (void)setupNavigation
{
    self.navigationItem.title = @"淡漠列表";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x49b9f0);
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[myCell class] forCellReuseIdentifier:NSStringFromClass([myCell class])];
    [self.tableView registerClass:[myHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([myHeader class])];
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber * selected = self.tableSeleted[section];
    if ([selected boolValue]) {
        NSDictionary * tempDic = self.tableData[section];
        NSArray * tempArray = tempDic[tempDic.allKeys[0]];
        return tempArray.count;
    } else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    myHeader * headerView = (myHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([myHeader class])];
    NSDictionary * tempDic = self.tableData[section];
    NSNumber * selected = self.tableSeleted[section];
    [headerView setHeaderWithName:(NSString*)(tempDic.allKeys[0]) selected:[selected boolValue]];
    @weakify(self);
    headerView.click = ^{
        @strongify(self);
        if(selected.boolValue){
            self.tableSeleted[section] = @NO;
        } else {
            self.tableSeleted[section] = @YES;
        }
        [self.tableView reloadData];
    };
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([myCell class]) forIndexPath:indexPath];
    myCell *celltemp = (myCell *)cell;
    NSDictionary * tempDic = self.tableData[indexPath.section];
    NSArray * tempArray = tempDic[tempDic.allKeys[0]];
    NSDictionary * tempDic2 = tempArray[indexPath.row];
    NSString * strName = tempDic2.allKeys[0];
    Class goToVC = tempDic2[tempDic2.allKeys[0]];
    celltemp.name.text = strName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * tempDic = self.tableData[indexPath.section];
    NSArray * tempArray = tempDic[tempDic.allKeys[0]];
    NSDictionary * tempDic2 = tempArray[indexPath.row];
    NSString * strName = tempDic2.allKeys[0];
    Class goToVC = tempDic2[tempDic2.allKeys[0]];
    
    [self.navigationController pushViewController:[[goToVC alloc]init] animated:YES];
}

@end

@interface myCell()

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation myCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bottomLine];
        [self.contentView addSubview:self.name];
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout
{
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self).offset(25);
    }];
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = UIColorFromRGB(0xefefef);
    }
    return _bottomLine;
}

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.font = Font(14);
    }
    return _name;
}

@end

@interface myHeader()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *name;

@end

@implementation myHeader


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bottomLine];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.imageView];
        self.contentView.backgroundColor = UIColorFromRGB(0xfefefe);
        [self setupLayout];
        [self bindEvent];
    }
    return self;
}

- (void)bindEvent
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    if (_click) {
        self.click();
    }
}

- (void)setupLayout
{
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.right.bottom.equalTo(self.contentView);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@10);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = UIColorFromRGB(0xefefef);
    }
    return _bottomLine;
}

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.font = Font(16);
    }
    return _name;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.image = [MainTestsBundleGeter getImage:@"Arrow.png"];
    }
    return _imageView;
}

- (void)setHeaderWithName:(NSString *)name selected:(BOOL)isSelected
{
    if (!isSelected) {
        CGAffineTransform rotate = CGAffineTransformMakeRotation( -1.0 / 2.0 * 3.14 );
        [self.imageView setTransform:rotate];
    } else {
        CGAffineTransform rotate = CGAffineTransformMakeRotation(0);
        [self.imageView setTransform:rotate];
    }
    self.name.text = name;
}

@end
