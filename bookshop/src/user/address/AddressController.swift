//
//  AddressController.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/6.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AddressController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellEventDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    private lazy var mgr: CLLocationManager = CLLocationManager()
    private lazy var geoCorder: CLGeocoder = CLGeocoder()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    // 表单
    var formView: UIVisualEffectView!
    var recvTF: UITextField!
    var phoneTF: UITextField!
    var addrTF: UITextField!
    var addrInForm: Address!
    var isAdd: Bool = true  // 是否点击了新增/修改
    
    override func viewDidLoad() {
        addBtn.layer.cornerRadius = 5
        
        // 地址列表初始化
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AddressCell.classForCoder(), forCellReuseIdentifier: "addressCell")
    
        initForm()
    }
    
    // 初始化表单
    func initForm() {
        
        // 整个屏幕的尺寸，不包括导航栏
        var bounds = CGSize(width: view.frame.width, height: view.frame.height)
        bounds.height -= (navigationController?.navigationBar.frame.height)!
        
        let h = bounds.height > 400 ? CGFloat(400) : bounds.height
        let w = bounds.width > 300 ? CGFloat(300) : bounds.width
        
        let x = (bounds.width - w) / 2
        let y = (bounds.height - h) / 3
        
        let form = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        form.layer.backgroundColor = UIColor.white.cgColor
        form.layer.cornerRadius = 10
        form.layer.shadowOpacity = 0.5  // 不透明度
        form.layer.shadowRadius = 10
        form.layer.shadowColor = UIColor.lightGray.cgColor
        form.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: w - 20, height: 30))
        titleLabel.text = "编辑地址"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        form.addSubview(titleLabel)
        
        recvTF = LinearTextField(frame: CGRect(x: 25, y: titleLabel.frame.maxY + 20, width: w - 50, height: 30))
        recvTF.placeholder = "收件人"
        form.addSubview(recvTF)
        
        phoneTF = LinearTextField(frame: CGRect(x: 25, y: recvTF.frame.maxY + 20, width: w - 50, height: 30))
        phoneTF.placeholder = "手机号码"
        form.addSubview(phoneTF)
        
        addrTF = LinearTextField(frame: CGRect(x: 25, y: phoneTF.frame.maxY + 20, width: w - 80, height: 30))
        addrTF.placeholder = "详细地址"
        form.addSubview(addrTF)
        
        let locateBtn = UIButton(frame: CGRect(x: addrTF.frame.maxX + 10 , y: phoneTF.frame.maxY + 25, width: 20, height: 20))
        locateBtn.setBackgroundImage(UIImage(named: "location"), for: .normal)
        locateBtn.addTarget(self, action: #selector(locate), for: .touchUpInside)
        form.addSubview(locateBtn)
        
        let saveBtn = UIButton(frame: CGRect(x: 25, y: 300, width: w - 50, height: 30))
        saveBtn.layer.cornerRadius = 5
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.backgroundColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
        saveBtn.addTarget(self, action: #selector(saveClick), for: .touchUpInside)
        form.addSubview(saveBtn)
        
        let cancelBtn = UIButton(frame: CGRect(x: 25, y: 340, width: w - 50, height: 30))
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.backgroundColor = UIColor.lightGray
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        form.addSubview(cancelBtn)
        
        // 毛玻璃效果
        let blurEffect = UIBlurEffect(style: .light)
        formView = UIVisualEffectView(effect: blurEffect)
        formView.frame = self.view.frame
        formView.isHidden = true
        formView.alpha = 0.0
        formView.contentView.addSubview(form)
        
        self.view.addSubview(formView)
    }
    
    // 点击空白处回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (CommonUtil.getUser()?.getAddrList().count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell") as! AddressCell
        cell.initCell(index: indexPath.row, addr: (CommonUtil.getUser()?.getAddrList()[indexPath.row])!, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 动态计算显示地址的高度
        let text = (CommonUtil.getUser()?.getAddrList()[indexPath.row].addr)!
        let textHeight = MultilineLabel.caculateHeight(width: tableView.frame.width - 90, fontOfSize: 14, textStr: text, lineSpacing: 5)
        return 50 + textHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            CommonUtil.deleteAddress(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    // 点击修改图标
    func onclick(index: Int) {
        isAdd = false
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.formView.alpha = 1.0
            self.formView.isHidden = false
        }
        
        // 填充
        addrInForm = CommonUtil.getUser()?.getAddrList()[index]
        recvTF.text = addrInForm?.receiver
        phoneTF.text = addrInForm?.phone
        addrTF.text = addrInForm?.addr
    }
    
    
    // 点击新增按钮
    @IBAction func clickAddBtn(_ sender: Any) {
        isAdd = true
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.formView.alpha = 1.0
            self.formView.isHidden = false
        }
    }
    
    // 取消编辑地址
    @objc func cancelClick() {
        self.formView.alpha = 0.0
        self.formView.isHidden = true
        
        recvTF.text = ""
        phoneTF.text = ""
        addrTF.text = ""
    }
    
    // 保存编辑地址
    @objc func saveClick() {
        let var1 = recvTF.text
        let var2 = phoneTF.text
        let var3 = addrTF.text
        if(StringUtil.isEmpty(str: var1) || StringUtil.isEmpty(str: var2) || StringUtil.isEmpty(str: var3)){
            CBToast.showToastAction(message: "输入不能为空")
            return
        }
        
        if(isAdd) {
            let address = Address(addr: var3!, receiver: var1!, phone: var2!)
            CommonUtil.addAddress(address: address)
        } else {
            addrInForm.receiver = var1
            addrInForm.phone = var2
            addrInForm.addr = var3
            CommonUtil.modifyAddress()
        }
        
        self.formView.alpha = 0.0
        self.formView.isHidden = true
        recvTF.text = ""
        phoneTF.text = ""
        addrTF.text = ""
        
        tableView.reloadData()
    }
    
    // 点击获取定位
    @objc func locate() {
//        mgr.requestWhenInUseAuthorization()
        mgr.requestAlwaysAuthorization()
        mapView.showsUserLocation = true

        guard let center = mapView.userLocation.location else {
            CBToast.showToastAction(message: "获取定位失败，请重试")
            return
        }
        mapView.setCenter(center.coordinate, animated: true)
        let region = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        geoCorder.reverseGeocodeLocation(center, completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil {
                CBToast.showToastAction(message: "获取定位失败")
                print("定位错误：" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                var str = ""
                if(!StringUtil.isEmpty(str: pm.locality)) { // 城市
                    str += pm.locality!
                }
                if(!StringUtil.isEmpty(str: pm.thoroughfare)) { // 街道
                    str += pm.thoroughfare!
                }
                self.addrTF.text = str
            } else {
                CBToast.showToastAction(message: "获取定位失败")
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
