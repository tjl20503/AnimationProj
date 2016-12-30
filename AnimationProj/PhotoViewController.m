//
//  PhotoViewController.m
//  AnimationProj
//
//  Created by Future on 16/6/8.
//  Copyright © 2016年 yuqin. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"
@interface PhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,assign) NSInteger index;

@end

#define Width self.view.frame.size.width
#define Height self.view.frame.size.height

//UICollectionView section的四周边距
#define SECTION_TOP_EDGE 5  //到header的距离
#define SECTION_LEFT_EDGE 10
#define SECTION_BOTTOM_EDGE 5 //到距离footer
#define SECTION_RIGHT_EDGE 10

//item的宽高比，高 = 宽 * 系数
#define ITEM_ASPECT_RATIO 1.1

//item之间的距离
#define ITEM_SPACE 10

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _dataArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg"];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 10, 30, 30);
    [back setBackgroundImage:[UIImage imageNamed:@"arrow180"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backB = [[UIBarButtonItem alloc] initWithCustomView:back];
//    self.navigationItem.leftBarButtonItem = backB;
    [self.view addSubview:back];
    
    CGFloat itemWidth = (self.view.frame.size.width-SECTION_RIGHT_EDGE-SECTION_LEFT_EDGE-ITEM_SPACE)/2;
    CGFloat itemHeight = itemWidth * ITEM_ASPECT_RATIO;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 1.1设置每个Item的大小
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);;
    
    // 1.2 设置每列最小间距
    flowLayout.minimumInteritemSpacing = ITEM_SPACE ;
    
    // 1.3设置每行最小间距
    flowLayout.minimumLineSpacing = ITEM_SPACE;
    
    // 1.4设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collection.collectionViewLayout = flowLayout;
    [_collection registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Collection"];
    _collection.delegate = self;
    _collection.dataSource = self;
}

- (void)returnBack:(UIButton *)sender
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType:@"cube"];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:animation forKey:@"cube"];
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animation1
{
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = 2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [_showImage.layer addAnimation:anima3 forKey:@"cc"];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Collection" forIndexPath:indexPath];
    cell.photoImg.image = [UIImage imageNamed:_dataArr[indexPath.row]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,10,10,10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *image = _dataArr[indexPath.row];
    _index = indexPath.row;
    [self showImage:[UIImage imageNamed:image]];
}


- (void)showImage:(UIImage *)image
{
    if (_showImage)
    {
        [_showImage removeFromSuperview];
    }
    
    _showImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width /2,self.view.frame.size.height / 2,0,0)];
    _showImage.backgroundColor = [UIColor whiteColor];
    _showImage.contentMode = UIViewContentModeScaleAspectFit;
    _showImage.image = image;
    _showImage.userInteractionEnabled = YES;
    [self.view addSubview:_showImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    [_showImage addGestureRecognizer:tap];
    
    [self animation2];
}

- (void)imageClick:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:2.0 animations:^{
        
        _showImage.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [_showImage removeFromSuperview];
    }];

}

- (void)press:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:1.0 animations:^{
        _showImage.alpha = 0;
    } completion:^(BOOL finished) {
        [_showImage removeFromSuperview];
    }];
}

- (void)animation2
{
    [UIView animateWithDuration:1.0 animations:^{
        _showImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    //旋转动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima2.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima2.duration = 1.0;
    //组动画
//    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
//    groupAnimation.animations = [NSArray arrayWithObjects:anima2, nil];
//    groupAnimation.duration = 1.0f;
    
    [_showImage.layer addAnimation:anima2 forKey:@"transform.rotation"];
}

- (void)animation3
{
    [UIView animateWithDuration:0.7 animations:^{
        
        if (_index % 2)
        {
            _showImage.frame = CGRectMake(0,0, 80, 80);
        }
        else
        {
            _showImage.frame = CGRectMake(self.view.frame.size.width - 80,0, 80, 80);
        }
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 animations:^{
            
        _showImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)animation4
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
