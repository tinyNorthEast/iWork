//
//  WGResetUserInfoController.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetUserInfoController.h"

#import <extobjc.h>
#import <QiniuSDK.h>

#import "WGProgressHUD.h"
#import "UIImageView+WGHTTP.h"
#import "WGValidJudge.h"

#import "WGQNTokenRequest.h"
#import "WGQiNiuTokenModel.h"
#import "WGUserInfoModel.h"
#import "WGResetUserInfoRequest.h"

@interface WGResetUserInfoController()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary *infoDic;

@property (nonatomic, copy) NSData *imageData;
@property (nonatomic, copy) UIImage *headerImage;

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UITextField *mailField;
@property (weak, nonatomic) IBOutlet UITextField *enNameField;
@property (weak, nonatomic) IBOutlet UITextField *experienceField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;

@end

@implementation WGResetUserInfoController

- (void)viewDidLoad{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
//    [self.view addGestureRecognizer:tap];
    
    [self.headerView wg_loadImageFromURL:self.userInfoModel.pic placeholder:[UIImage imageNamed:@"user_defaultHeader"]];
    self.mailField.text = self.userInfoModel.mail;
    self.enNameField.text = self.userInfoModel.en_name;
    self.experienceField.text = self.userInfoModel.experience.stringValue;
    self.companyField.text = self.userInfoModel.company;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self hideKeyboard];
}

- (void)hideKeyboard{
//    [self.mailField resignFirstResponder];
//    [self.enNameField resignFirstResponder];
//    [self.experienceField resignFirstResponder];
//    [self.companyField resignFirstResponder];
}
- (void)hideKeyBoard:(UIGestureRecognizer *)recognizer{
    [self hideKeyboard];
}
#pragma mark - Init
- (NSMutableDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic = [NSMutableDictionary dictionary];
    }
    return _infoDic;
}
- (void)setUserInfoModel:(WGUserInfoModel *)userInfoModel{    
    _userInfoModel = userInfoModel;
}

#pragma mark - IBAction
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backAction:(id)sender {
    [self back];
}
- (IBAction)saveAction:(id)sender {
    if (self.mailField.text.length && ![self.mailField.text isEqualToString:self.userInfoModel.mail]) {
        [self.infoDic setObject:self.mailField.text forKey:@"mail"];
    }
    if (self.enNameField.text.length && ![self.enNameField.text isEqualToString:self.userInfoModel.en_name]) {
        [self.infoDic setObject:self.enNameField.text forKey:@"en_name"];
    }
    if (self.experienceField.text.length && ![self.experienceField.text isEqualToString:self.userInfoModel.experience.stringValue]) {
        [self.infoDic setObject:self.experienceField.text forKey:@"experience"];
    }
    if (self.companyField.text.length && ![self.companyField.text isEqualToString:self.userInfoModel.company]) {
        [self.infoDic setObject:self.companyField.text forKey:@"company"];
    }
    
    if (self.infoDic.allKeys.count == 0) {
        [self back];
        return;
    }
    
    WGResetUserInfoRequest *request = [[WGResetUserInfoRequest alloc] initWithUserInfo:self.infoDic];
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        if (baseModel.infoCode.integerValue == TokenFailed) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
            UIViewController *vc = [sb instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
        else if (baseModel.infoCode.integerValue == 0) {
            [self back];
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
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
                      [self.headerView setImage:self.headerImage];
                      [self.infoDic setObject:[NSString stringWithFormat:@"http://7xoors.com1.z0.glb.clouddn.com/%@",key] forKey:@"pic"];
                      
                  } option:nil];
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
        [as showInView:self.view];
    }
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
