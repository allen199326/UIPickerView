//
//  ViewController.m
//  picKerView复习
//
//  Created by Mac on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *fruit;

@property (weak, nonatomic) IBOutlet UILabel *drink;

@property (weak, nonatomic) IBOutlet UILabel *labFood;

@property(nonatomic,strong)NSArray *foods;

- (IBAction)randomSelect;

@end

@implementation ViewController


- (NSArray *)foods
{
    if(_foods==nil)
    {
        _foods=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foods" ofType:@"plist"]];
    }
    return _foods;
}

//随机显示数据
- (IBAction)randomSelect {
    
    for(int compenont=0;compenont<self.foods.count;compenont++)
    {
        //获得上一个行号
        int oldRow=[self.pickerView selectedRowInComponent:compenont];
        //获得每列有几行
        int count=[self.foods[compenont] count];
        //设置为上一个行号
        int row=oldRow;
        
        //如果行号相同则随机获取下一个行号
        while (row==oldRow) {
            row=arc4random()%count;
        }
        
        //自选中component列row行
        [self.pickerView selectRow:row inComponent:compenont animated:YES];
        
        //显示选中行数据
        [self pickerView:nil didSelectRow:row inComponent:compenont];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化显示数据
    for(int component=0;component<self.foods.count;component++)
    {
        [self pickerView:nil didSelectRow:0 inComponent:component];
    }
}

//数据源方法

//获得共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  self.foods.count;
}

//获得每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *subFood=self.foods[component];
    return subFood.count;
}

//显示每一行（文本）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foods[component][row];
}

//显示选中每一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==0)//水果
    {
        self.fruit.text=self.foods[component][row];
    }
    else if(component==1)
    {
        self.drink.text=self.foods[component][row];
    }
    else if(component==2)
    {
        self.labFood.text=self.foods[component][row];
    }
}

@end
