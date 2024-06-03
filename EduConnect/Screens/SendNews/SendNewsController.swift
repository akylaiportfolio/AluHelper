//
//  SendNewsController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation
import UIKit

class SendNewsController: BaseController<SendNewsPresenter> {
   
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Send news"
        return view
    }()
    
    private lazy var imageView: BaseImage = {
        let view = BaseImage()
        view.backgroundColor = .gray
        view.contentMode = .center
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Title")
        
        view.editField.placeholder = "Title"
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var messageField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Message")
        
        view.editField.placeholder = "Massage"
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var send: BrandButton = {
        let view = BrandButton()
        view.setEnable(true)
        view.setTitle("Send news")
        return view
    }()
        
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
        
        send.onEnableTab { [self] in
            if messageField.editField.text?.isEmpty == false && titleField.editField.text?.isEmpty == false && imageView.image != nil {
                
                if let image = imageView.image {
                    presenter?.postNews(
                        title: titleField.editField.text ?? "",
                        message: messageField.editField.text ?? "",
                        image: image
                    )
                }
            } else {
                showMessage(message: "Guide not full")
            }
        }
        
        imageView.onTab { [self] in
            let controller = UIImagePickerController()
            controller.sourceType = .savedPhotosAlbum
            controller.allowsEditing = true
            controller.delegate = self
            present(controller, animated: true)
        }
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(128)
        }
        
        view.addSubview(titleField)
        titleField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(messageField)
        messageField.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(send)
        send.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeArea.bottom).offset(-8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
    }
}

extension SendNewsController: SendNewsDelegate {
    func showMessage(message: String) {
        let alert = UIAlertController(title: "Failure", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func showSussesd() {
        let alert = UIAlertController(title: "Success", message: "Your news ad has been sent.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.router?.back()
        }))
        
        present(alert, animated: true)
    }
}

extension SendNewsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            self.imageView.image = image
        }

        picker.dismiss(animated: true, completion: nil)
    }
}
