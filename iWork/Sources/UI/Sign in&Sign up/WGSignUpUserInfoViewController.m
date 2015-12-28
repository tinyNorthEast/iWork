//
//  WGSignUpUserInfoViewController.m
//  iWork
//
//  Created by Adele on 11/26/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignUpUserInfoViewController.h"

#import <extobjc.h>
#import <QiniuSDK.h>

#import "WGValidJudge.h"
#import "WGProgressHUD.h"
#import "NSMutableDictionary+WGExtension.h"
#import "WGSignUpWorkInfoViewController.h"
#import "WGQNTokenRequest.h"
#import "WGQiNiuTokenModel.h"

@interface WGSignUpUserInfoViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, copy) NSString *headerUrl;

@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation WGSignUpUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init
- (NSMutableDictionary *)userInfoDict{
    if (!_userInfoDict) {
        _userInfoDict = [NSMutableDictionary dictionary];
    }
    return _userInfoDict;
}

#pragma mark - IBACtion

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backAction:(id)sender {
    [self back];
}

- (IBAction)addPhotoAction:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    [as showInView:self.view];
}
- (IBAction)nextAction:(id)sender {
    if (![WGValidJudge isValidString:self.userNameTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写姓名" onView:self.view];
        return;
    }if (![WGValidJudge isValidString:self.emailTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写邮箱" onView:self.view];
        return;
    }
    
    [self.userInfoDict safeSetValue:self.userNameTextField.text forKey:@"zh_name"];
//    [self.userInfoDict safeSetValue:self.userNameTextField.text forKey:@"zh_name"];
    [self.userInfoDict safeSetValue:self.headerUrl forKey:@"pic"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    WGSignUpWorkInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGSignUpWorkInfoViewController"];
    vc.workInfoDict = self.userInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Request
- (void)getUplodImageToken{
    WGQNTokenRequest *request = [[WGQNTokenRequest alloc] init];

    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        WGQiNiuTokenModel *model = (WGQiNiuTokenModel *)baseModel;

        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putData:self.imageData key:@"header" token:model.data
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      [self.headerButton setImage:self.headerImage forState:UIControlStateNormal];
                      self.headerUrl = [NSString stringWithFormat:@"http://7xoors.com1.z0.glb.clouddn.com/%@",key];
                      
                  } option:nil];
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

#pragma mark - UIActionSheetDelegate
- (void)callCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Opps" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)callPhotoLibary{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self callCamera];
    }else{
        [self callPhotoLibary];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //得到图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * editedimage = [info objectForKey:UIImagePickerControllerEditedImage];
    NSURL *url      = [info objectForKey:UIImagePickerControllerReferenceURL];
    UIImage *newImg = [self scaleToSize:editedimage size:CGSizeMake(500, 500)];
    NSString *imgName = [url pathExtension];
    
    if( ![WGValidJudge isValidString:imgName] )
    {
        imgName = @"png";
    }
    
//    NSString *paths     = [NSString stringWithFormat:@"%@/Documents/TakePhoto/photo.%@", NSHomeDirectory(),imgName];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:paths]){
//        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        NSString *directryPath = [path stringByAppendingPathComponent:@"TakePhoto"];
//        [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
//        NSString *filePath = [directryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"photo.%@",imgName]];
//
//        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
//    }
//    
//    [UIImagePNGRepresentation(newImg) writeToFile:paths  atomically:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
   
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",imgName]];
    NSData *data = UIImageJPEGRepresentation(newImg,0.5);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
    
    self.imageData = data;
    self.headerImage = newImg;
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera )
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self getUplodImageToken];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
