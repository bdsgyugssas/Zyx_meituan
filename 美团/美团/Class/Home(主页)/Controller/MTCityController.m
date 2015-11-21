//
//  MTCityController.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTCityController.h"
#import "MTCityGroup.h"
#import "MJExtension.h"
#import "MTHotCell.h"


@interface MTCityController ()

@property (strong, nonatomic) NSArray *cityGroups;


@end

@implementation MTCityController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
    [self achieveData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark -私有方法
- (void)achieveData
{
    NSString *cityGroupsPath=[[NSBundle mainBundle] pathForResource:@"cityGroups" ofType:@"plist"];
    NSArray *allGroups=[NSArray arrayWithContentsOfFile:cityGroupsPath];
    self.cityGroups=[MTCityGroup mj_objectArrayWithKeyValuesArray:allGroups];

}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    button.size=button.currentImage.size;
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=left;

}

#pragma mark -监听方法
- (void)returnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:return 1;
        default: {
            MTCityGroup *group=self.cityGroups[section];
            return group.cities.count;
        }
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1=@"Cell";
    static NSString *identifier2=@"SpecialCell";

    if (indexPath.section==0) {
        MTHotCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell==nil) {
            cell=[[MTHotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        
        return cell;
    }else {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        
        MTCityGroup *group=self.cityGroups[indexPath.section];
        cell.textLabel.text=group.cities[indexPath.row];
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    MTCityGroup *group=self.cityGroups[section];
    return group.title;
}
#pragma mark -Table view delegate



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
