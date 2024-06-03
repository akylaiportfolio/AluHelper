//
//  FormController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/4/24.
//

import UIKit

class FormController: BaseController<FormPresenter> {
    
    private lazy var contener: UIScrollContainer = {
        return UIScrollContainer()
    }()
    
    private lazy var logo: BaseImage = {
        return BaseImage(image: .init(named: "AppMainIcon"))
    }()
    
    private lazy var viewTest: BaseView = {
        let view = BaseView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var sendForn: BrandButton = {
        let view = BrandButton()
        view.setEnable(false)
        view.setTitle("Send form")
        return view
    }()
    
    private lazy var infoLabel: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textColor = .init(hex: "#727272")
        
        let text = "Already have an account? Log in"
        
        let attribute = NSMutableAttributedString(string: text)
        
        attribute.changeColor(text, of: "Log in", hex: "#973535")

        view.attributedText = attribute
        return view
    }()
    
    private lazy var checkBox = CheckBox()
    
    private lazy var checkBoxTitle: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .init(hex: "#727272")
        
        let text = "I have read and agree to the privacy policy, terms of service."
        
        let attribute = NSMutableAttributedString(string: text)
        
        attribute.changeColor(text, of: "privacy policy", hex: "#973535")
        attribute.changeColor(text, of: "terms of service", hex: "#973535")

        view.attributedText = attribute
        view.numberOfLines = 0
        
        return view
    }()
    
    private lazy var email: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Gmail")
        
        view.editField.placeholder = "Mail"
        view.editField.left(.init(named: "Email"))
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var fullName: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Full name")
        
        view.editField.placeholder = "Full name"
        view.editField.left(.init(named: "Email"))
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var dateOfBirth: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Date of Birth")
        
        view.editField.placeholder = "DD/MM/AAAA"
        view.editField.left(.init(named: "DateOfBirth"))
        view.editField.autocapitalizationType = .none
        view.editField.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var courses: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Courses")
        
        view.editField.placeholder = "Select"
        view.editField.left(.init(named: "DateOfBirth"))
        view.editField.autocapitalizationType = .none
        view.editField.isUserInteractionEnabled = false
        
        return view
    }()
    
    private lazy var passwordField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Password")
        
        view.editField.placeholder = "Password"
        view.editField.setSecured()
        view.editField.left(.init(named: "Password"))
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var passwordReapatField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Reapat Password")
        
        view.editField.placeholder = "Password"
        view.editField.setSecured()
        view.editField.left(.init(named: "Password"))
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var uploadLabel: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textColor = .init(hex: "#000000")
        view.text = "Upload your photo"
        return view
    }()
    
    private lazy var uploadImage: BaseImage = {
        let view = BaseImage(image: UIImage(named: "UploadAvatar"))
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private var selectImage: UIImage? = nil
    
    override func setupController() {
        infoLabel.onTab { [self] in
            router?.back()
        }
        
        contener.onTab { [self] in
            hideKeyboard()
        }
        
        courses.onTab { [self] in
            presenter?.getAllGroup()
        }
        
        uploadImage.onTab { [self] in
            showUploadImage()
        }
        
        dateOfBirth.onTab { [self] in
            showDatePicker()
        }
        
        email.onChange { _ in
            self.validateValue()
        }
        
        fullName.onChange { _ in
            self.validateValue()
        }
        
        dateOfBirth.onChange { _ in
            self.validateValue()
        }
        
        courses.onChange { _ in
            self.validateValue()
        }
        
        passwordField.onChange { _ in
            self.validateValue()
        }
        
        passwordReapatField.onChange { _ in
            self.validateValue()
        }
        
        sendForn.onTab { [self] in
            validateValue(showError: true)
            
            if sendForn.state {
                presenter?.sendForm(
                    uploadImage.image ?? .closeEye,
                    email.editField.text ?? "",
                    fullName.editField.text ?? "",
                    dateOfBirth.editField.text ?? "",
                    courses.editField.text ?? "",
                    passwordField.editField.text ?? ""
                )
            }
        }
    }
    
    private func showDatePicker() {
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.timeZone = .current
        myDatePicker.datePickerMode = .date
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            
            self.courses.state(.normal)

            self.dateOfBirth.editField.text = formatter.string(from: myDatePicker.date)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func showUploadImage() {
        let controller = UIAlertController(title: "Upload image", message: nil, preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [self] action in
            let controller = UIImagePickerController()
            controller.sourceType = .camera
            controller.allowsEditing = true
            controller.delegate = self
            present(controller, animated: true)
        }))
        
        controller.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [self] action in
            let controller = UIImagePickerController()
            controller.sourceType = .savedPhotosAlbum
            controller.allowsEditing = true
            controller.delegate = self
            present(controller, animated: true)
        }))
        
        present(controller, animated: true)
    }
    
    override func setupSubViews() {
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
        }
        
        view.addSubview(sendForn)
        sendForn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            
            make.height.equalTo(45)
            
            make.bottom.equalTo(infoLabel.snp.top).offset(-16)
        }
        
        view.addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            
            make.width.height.equalTo(18)
            
            make.bottom.equalTo(sendForn.snp.top).offset(-12)
        }
        
        view.addSubview(checkBoxTitle)
        checkBoxTitle.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(6)
            
            make.centerY.equalTo(checkBox)
            
            make.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            
            make.left.right.equalToSuperview()
            
            make.bottom.equalTo(checkBox.snp.bottom).offset(-30)
        }
        
        contener.addView(logo)
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.top.equalToSuperview().offset(20)
        }
        
        contener.addView(uploadLabel)
        uploadLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.top.equalTo(logo.snp.bottom).offset(60)
        }
        
        contener.addView(uploadImage)
        uploadImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.width.equalTo(60)
            
            make.top.equalTo(uploadLabel.snp.bottom).offset(5)
        }
        
        contener.addView(email)
        email.snp.makeConstraints { make in
            make.top.equalTo(uploadImage.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
        }
        
        contener.addView(fullName)
        fullName.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
        }
        
        contener.addView(dateOfBirth)
        dateOfBirth.snp.makeConstraints { make in
            make.top.equalTo(fullName.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
        }
        
        contener.addView(courses)
        courses.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirth.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
        }
        
        contener.addView(passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(courses.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
        }
        
        contener.addView(passwordReapatField)
        passwordReapatField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
            
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    func validateValue(showError: Bool = false) {
        let image = selectImage != nil
        let courses = !(courses.editField.text?.isEmpty ?? true)
        let date = !(dateOfBirth.editField.text?.isEmpty ?? true)
        let name = !(fullName.editField.text?.isEmpty ?? true)
        let email = !(email.editField.text?.isEmpty ?? true) && (email.editField.text ?? "").contains("@gmail.com")

        let password = passwordField.editField.text == passwordReapatField.editField.text
        let passwordCount = (passwordField.editField.text ?? "").count >= 8
        
        let checkBox = checkBox.enable
        
        let check = image && courses && date && name && password && passwordCount && checkBox
        
        sendForn.setEnable(check)
        
        if !check && showError {
            if !image {
                let controller = UIAlertController(title: "Error", message: "upload your photo", preferredStyle: .actionSheet)
                
                controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                present(controller, animated: true)
            }
            
            if !email {
                self.courses.state(.error("Edit gmail"))
            }
            
            if !courses {
                self.courses.state(.error("Select courses"))
            }
            
            if !date {
                self.dateOfBirth.state(.error("Select date"))
            }
            
            if !name {
                self.fullName.state(.error("Edit full name"))
            }
            
            if !password {
                self.passwordField.state(.error("Password less than 8 char or not reapat"))
                self.passwordReapatField.state(.error("Password less than 8 char or not reapat"))
            }
            
            if !passwordCount {
                self.passwordField.state(.error("Password less than 8 char or not reapat"))
                self.passwordReapatField.state(.error("Password less than 8 char or not reapat"))
            }
        }
    }
    
    override func keyboardShow(height: Double) {
        var contentInset: UIEdgeInsets = self.contener.scrollView.contentInset
        
        contentInset.bottom = height / 2
        
        contener.scrollView.contentInset = contentInset
    }
    
    override func keyboardHide() {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        
        contener.scrollView.contentInset = contentInset
    }
}

extension FormController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let image = UIImage(data: img.jpegData(compressionQuality: 0.01) ?? Data())
            
            self.selectImage = image
            self.uploadImage.image = image
        }

        picker.dismiss(animated: true, completion: nil)
    }
}

extension FormController: FormDelegate {
    func showError(message: String) {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(controller, animated: true)
    }
    
    func passForm() {
        let controller = UIAlertController(title: "Form submitted", message: "The registration form has been sent, please wait for approval", preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.router?.back()
        }))
        
        present(controller, animated: true)
    }
    
    func showSelectGroup(group: [GroupModel]) {
        let controller = UIAlertController(title: "Select group", message: nil, preferredStyle: .actionSheet)
        
        group.forEach { item in
            controller.addAction(UIAlertAction(title: item.name, style: .default, handler: { action in
                self.courses.editField.text = action.title
                
                self.courses.state(.normal)
            }))
        }
        
        present(controller, animated: true)
    }
}
