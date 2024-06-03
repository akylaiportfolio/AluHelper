//
//  ProfileController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit

class ChangeProfileAlert: BaseView {
    
    public lazy var contener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#FFFFFF")
        view.layer.cornerRadius = 16
        view.onTab { self.endEditing(true) }
        return view
    }()
    
    public lazy var uploadImage: BaseImage = {
        let view = BaseImage(image: UIImage(named: "UploadAvatar"))
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var uploadLabel: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textColor = .init(hex: "#000000")
        view.text = "Upload your photo"
        return view
    }()
    
    public lazy var fullName: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Full name")
        
        view.editField.placeholder = "Full name"
        view.editField.left(.init(named: "Email"))
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    public lazy var dateOfBirth: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Date of Birth")
        
        view.editField.placeholder = "DD/MM/AAAA"
        view.editField.left(.init(named: "DateOfBirth"))
        view.editField.autocapitalizationType = .none
        view.editField.isUserInteractionEnabled = false
        return view
    }()
    
    public lazy var updateButton: BrandButton = {
        let view = BrandButton()
        view.setEnable(true)
        view.setTitle("Save")
        return view
    }()
    
    public var isShow = false
    
    override func setupView() {
        backgroundColor = .init(hex: "#4D000000")
        
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(330)
        }
        
        contener.addSubview(uploadLabel)
        uploadLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.top.equalToSuperview().offset(16)
        }
        
        contener.addSubview(uploadImage)
        uploadImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.width.equalTo(60)
            
            make.top.equalTo(uploadLabel.snp.bottom).offset(5)
        }
        
        contener.addSubview(fullName)
        fullName.snp.makeConstraints { make in
            make.top.equalTo(uploadImage.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
        }
        
        contener.addSubview(dateOfBirth)
        dateOfBirth.snp.makeConstraints { make in
            make.top.equalTo(fullName.snp.bottom).offset(15)
            
            make.leading.trailing.equalToSuperview().inset(16)
                        
            make.height.equalTo(64)
        }
        
        contener.addSubview(updateButton)
        updateButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            
            make.height.equalTo(45)
            
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    override func setupSubViews() {
        onTab {
            self.hide()
        }
        
        fullName.onChange { text in
            self.updateButton.setEnable(!text.isEmpty)
        }
    }
    
    func show(action: @escaping () -> Void) {
        self.isShow = true
        
        updateButton.onEnableTab {
            action()
        }
        
        let user = UserServices.shered.getUser()
        
        if let user = user {
            fullName.editField.text = user.fullName
            
            dateOfBirth.editField.text = user.dateOfBirth
            
            uploadImage.kf.setImage(with: URL(string: user.avatar))
        }
        
        let window = UIApplication.shared.windows.first
        
        alpha = 0
        
        window?.addSubview(self)
        snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1
        }
    }
    
    func hide() {
        self.isShow = false

        alpha = 1
        
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

class ProfileController: BaseController<ProfilePresenter> {
    
    private lazy var toolbarView: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Profile"
        return view
    }()
    
    private lazy var profileUserView = ProfileUserView()
    
    private lazy var alertProfile = ChangeProfileAlert()
    
    private lazy var exit: CardProfileItem = {
        let view = CardProfileItem()
        view.nextImage.image = nil
        view.imageView.image = .init(named: "Logout")
        view.textView.text = "Logout"
        return view
    }()
    
    private lazy var rental: CardProfileItem = {
        let view = CardProfileItem()
        view.imageView.image = .init(named: "Rental")
        view.textView.text = "Office rental"
        return view
    }()
    
    private lazy var userList: CardProfileItem = {
        let view = CardProfileItem()
        view.imageView.image = .init(named: "Users")
        view.textView.text = "User list"
        return view
    }()
    
    private lazy var group: CardProfileItem = {
        let view = CardProfileItem()
        view.imageView.image = .init(named: "Group")
        view.textView.text = "Group list"
        return view
    }()
    
    override func setupController() {
        exit.onTab { [self] in
            let controller = UIAlertController(title: "Do you really want to exit?", message: nil, preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                self.presenter?.logout()
                
                self.router?.new(SplashBuilder.create())
            }))
            
            controller.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            
            self.present(controller, animated: true)
        }
        
        profileUserView.changeView.onTab { [self] in
            alertProfile.show(action: { [self] in
                presenter?.updateProfile(
                    image: alertProfile.uploadImage.image ?? UIImage(),
                    fullname: alertProfile.fullName.editField.text ?? "",
                    dateOfBirth: alertProfile.dateOfBirth.editField.text ?? ""
                )
            })
        }
        
        alertProfile.dateOfBirth.onTab {
            self.showDatePicker()
        }
        
        alertProfile.uploadImage.onTab {
            self.showUploadImage()
        }
        
        presenter?.fetchData()
        
        rental.onTab { [self] in
            router?.open(RentBuilder.create())
        }
        
        userList.onTab { [self] in
            router?.open(UserListBuilder.create())
        }
        
        group.onTab { [self] in
            router?.open(GroupBuilder.create())
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
            
            self.alertProfile.dateOfBirth.state(.normal)

            self.alertProfile.dateOfBirth.editField.text = formatter.string(from: myDatePicker.date)
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
        view.addSubview(toolbarView)
        toolbarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(profileUserView)
        profileUserView.snp.makeConstraints { make in
            make.top.equalTo(toolbarView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(rental)
        rental.snp.makeConstraints { make in
            make.top.equalTo(profileUserView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        if UserServices.shered.getUser()?.status == "admin" {
            view.addSubview(userList)
            userList.snp.makeConstraints { make in
                make.top.equalTo(rental.snp.bottom).offset(16)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(45)
            }
            
            view.addSubview(group)
            group.snp.makeConstraints { make in
                make.top.equalTo(userList.snp.bottom).offset(16)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(45)
            }
        }
        
        view.addSubview(exit)
        exit.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeArea.bottom).offset(-46)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
    }
    
    override func keyboardShow(height: Double) {
        if alertProfile.isShow {
            alertProfile.contener.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset((height * 0.4) * -1)
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(330)
            }
        }
    }
    
    override func keyboardHide() {
        if alertProfile.isShow {
            alertProfile.contener.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(330)
            }
        }
    }
}

extension ProfileController: ProfileDelegate {
    func showProfile(model: UserModel) {
        alertProfile.hide()
        
        profileUserView.fill(model: model)
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let image = UIImage(data: img.jpegData(compressionQuality: 0.01) ?? Data())
            
            self.alertProfile.uploadImage.image = image
        }

        picker.dismiss(animated: true, completion: nil)
    }
}
