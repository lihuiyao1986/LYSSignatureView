//
//  ViewController.m
//  LYSSignatureView
//
//  Created by jk on 2017/4/21.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSSignatureView.h"

@interface ViewController ()

@property(nonatomic,strong)LYSSignatureView *signatureView;

@property(nonatomic,strong)UIButton *clearBtn;

@property(nonatomic,strong)UIButton * getImageBtn;

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.signatureView];
    [self.view addSubview:self.clearBtn];
    [self.view addSubview:self.getImageBtn];
    [self.view addSubview:self.imageView];
    self.signatureView.placeholderFont = [UIFont systemFontOfSize:18];
    // Do any additional setup after loading the view, typically from a nib.
}

-(LYSSignatureView*)signatureView{
    if (!_signatureView) {
        _signatureView = [[LYSSignatureView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300.f)];
        _signatureView.lineW = 3;
        _signatureView.lineColor = [UIColor greenColor];
        _signatureView.lineBorderColor = [UIColor redColor];
        _signatureView.backgroundColor = [UIColor whiteColor];
    }
    return _signatureView;
}

-(UIButton*)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_clearBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_clearBtn setTitle:@"清除" forState:UIControlStateNormal];
        _clearBtn.frame = CGRectMake(0, CGRectGetMaxY(self.signatureView.frame), CGRectGetWidth(self.view.frame) / 2, 44.f);
        [_clearBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    return _clearBtn;
}

-(UIButton*)getImageBtn{
    if (!_getImageBtn) {
        _getImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getImageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_getImageBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_getImageBtn setTitle:@"获取签名" forState:UIControlStateNormal];
        _getImageBtn.frame = CGRectMake(CGRectGetMaxX(self.clearBtn.frame), CGRectGetMaxY(self.signatureView.frame), CGRectGetWidth(self.view.frame) / 2, 44.f);
        [_getImageBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    return _getImageBtn;
}

-(void)btnClicked:(UIButton*)sender{
    if (sender == self.clearBtn) {
        [self.signatureView clear];
    }else{
        self.imageView.image = [self.signatureView getImage];
    }
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.getImageBtn.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.getImageBtn.frame))];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
