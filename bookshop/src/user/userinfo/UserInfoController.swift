//
//  UserInfoController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/27.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

// 用户个人信息页面
class UserInfoController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // btn按钮，“修改”点击后变成“保存”，反之亦然
    @IBOutlet weak var btn: UIBarButtonItem!
    // 当前按钮是否显示为修改
    var isModify: Bool = true
    // 是否编辑并保存过
    var isModified: Bool = false
    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var nicknameTF: UITextField!
    
    override func viewDidLoad() {
        self.tableView.tableFooterView = UIView()
        nicknameTF.font = UIFont.systemFont(ofSize: 17)
        btn.title = "修改"
        nicknameTF.borderStyle = UITextField.BorderStyle.none
        nicknameTF.isEnabled = false
        nicknameTF.textAlignment = NSTextAlignment.right
        nicknameTF.textColor = UIColor.darkGray
        
        headImage.layer.masksToBounds = true
        headImage.layer.cornerRadius = headImage.frame.width / 2
        headImage.contentMode = .scaleToFill
        
        headImage.image = CommonUtil.getUser()?.getImg()
        accountLabel.text = CommonUtil.getUser()?.account
        nicknameTF.text = CommonUtil.getUser()?.nickname
    }
    
    // 点击右上角按钮进入/退出编辑
    @IBAction func modifyOrSave(_ sender: Any) {
        if(isModify){   // 进入编辑
            isModify = false
            btn.title = "保存"
            nicknameTF.borderStyle = UITextField.BorderStyle.roundedRect
            nicknameTF.isEnabled = true
            nicknameTF.textAlignment = NSTextAlignment.left
            nicknameTF.textColor = UIColor.black
        } else {    // 退出编辑
            let var1: String? = nicknameTF.text
            if(var1 == nil || var1!.count <= 0) {
                CBToast.showToastAction(message: "编辑内容不能为空，请重新编辑")
                return
            }
            
            isModify = true
            btn.title = "修改"
            nicknameTF.borderStyle = UITextField.BorderStyle.none
            nicknameTF.isEnabled = false
            nicknameTF.textAlignment = NSTextAlignment.right
            nicknameTF.textColor = UIColor.darkGray
            
            let user: User = CommonUtil.getUser()!
            user.nickname = nicknameTF.text
            let res: CommonUtil.Response = CommonUtil.modifyUserInfo(user: user)
            CBToast.showToastAction(message: res.msg! as NSString)
            
            isModified = true   // 发生了编辑并保存
        }
    }
    
    // 退出
    @IBAction func back(_ sender: Any) {
        if(isModified) {
            // 通知用户界面及时更新修改内容
            NotificationCenter.default.post(name: NSNotification.Name("modifyInfo"), object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //////////////////// 以下是点击图片更换头像 //////////////////////
    
    // 点击手势
    @IBAction func clickHeadImage(_ sender: UITapGestureRecognizer) {
        present(selectorController, animated: true, completion: nil)
    }
    
    // 弹出对话框，选择图片获取方式
    var selectorController: UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        // 打开相机拍照选择
        controller.addAction(UIAlertAction(title: "拍照选择", style: .default) { action in
            CBToast.showToastAction(message: "相机使用权限尚未开启")
//            self.takePhoto()
        })
        // 从相册中选择
        controller.addAction(UIAlertAction(title: "相册选择", style: .default) { action in
            self.pickPhoto()
        })
        // 还原默认图片
        controller.addAction(UIAlertAction(title: "使用默认头像", style: .default) { action in
            self.useDefaultImage()
        })
        return controller
    }
    
    func useDefaultImage() {
        headImage.image = UIImage(named: "img_4")
        let user = CommonUtil.getUser()
        user?.setImg(img: headImage.image!)
        CommonUtil.modifyUserInfo(user: user!)
        self.isModified = true
    }
    
//    func takePhoto(){
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .camera
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
//    }
    
    func pickPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("选中图片")
        self.dismiss(animated: true, completion: {
            var img: UIImage = info[.originalImage] as! UIImage
            if picker.allowsEditing {
                img = info[.editedImage] as! UIImage
            }
            self.headImage.image = img
            let user = CommonUtil.getUser()
            user?.setImg(img: img)
            CommonUtil.modifyUserInfo(user: user!)
            self.isModified = true
        })
    }
    
}
