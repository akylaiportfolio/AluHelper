//
//  ScheduleCell.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import UIKit
import SnapKit

class ScheduleCell: BaseTableCell {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        
        view.showsHorizontalScrollIndicator = false
        
        view.dataSource = self
        view.delegate = self
        
        view.isPagingEnabled = true
        view.register(ScheduleItem.self, forCellWithReuseIdentifier: "ScheduleCell")
        
        return view
    }()
    
    private lazy var label: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.isHidden = true
        view.text = "Schedule empty"
        return view
    }()
    
    private lazy var pagingIndecator = PagingIndecator()
    
    override func setupSubViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(156)
            
            make.left.top.right.equalToSuperview()
        }
        
        addSubview(pagingIndecator)
        pagingIndecator.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(8)
            
            make.leading.trailing.equalToSuperview()
            
            make.height.equalTo(8)
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private var model: [Lesson] = []
    
    func fill(model: [Lesson]) {
        if model.isEmpty {
            self.model = []
            
            collectionView.reloadData()
            
            label.isHidden = false
            
            pagingIndecator.fill(count: 0)
        } else {
            label.isHidden = true
            
            self.model = model
            
            collectionView.reloadData()
            
            pagingIndecator.fill(count: model.count)
            
            pagingIndecator.set(index: 0)
        }
    }
    
    private var onSelectAction: (Lesson) -> Void = { _ in }
    
    func onSelectItem(onSelectAction: @escaping (Lesson) -> Void) {
        self.onSelectAction = onSelectAction
    }
}

extension ScheduleCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)

        pagingIndecator.set(index: page)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleCell", for: indexPath) as! ScheduleItem
        let model = model[indexPath.row]
        
        cell.fill(model: model)
                
        cell.onTab { self.onSelectAction(model) }
        
        return cell
    }
}

class ScheduleItem: BaseCollectionViewCell {
    
    private lazy var contener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero

        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var startTime: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 15)
        view.text = "08:30"
        return view
    }()
    
    private lazy var endTime: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 15)
        view.text = "10:00"
        return view
    }()
    
    private lazy var line: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#5BB269")
        view.layer.cornerRadius = 1
        return view
    }()
    
    private lazy var startDod: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#5BB269")
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var endDod: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#5BB269")
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var lessionImage = BaseImage(image: UIImage(named: "Book"))
    
    private lazy var lessionTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.text = "Equations\nMath Physics"
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var cabinetImage = BaseImage(image: UIImage(named: "Door"))
    
    private lazy var cabinetTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14)
        view.text = "504 - cabinet"
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var userImage = BaseImage(image: UIImage(named: "User"))
    
    private lazy var userTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 1
        return view
    }()
    
    override func setupView() {
        
    }
    
    override func setupSubViews() {
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(startTime)
        startTime.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        contener.addSubview(endTime)
        endTime.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.centerY.equalTo(startTime)
            
            make.leading.equalTo(startTime.snp.trailing).inset(-10)
            make.trailing.equalTo(endTime.snp.leading).inset(-10)
        }
        
        contener.addSubview(startDod)
        startDod.snp.makeConstraints { make in
            make.height.width.equalTo(6)
            make.centerY.equalTo(line)
            make.leading.equalTo(line)
        }
        
        contener.addSubview(endDod)
        endDod.snp.makeConstraints { make in
            make.height.width.equalTo(6)
            make.centerY.equalTo(line)
            make.trailing.equalTo(line)
        }
        
        contener.addSubview(lessionImage)
        lessionImage.snp.makeConstraints { make in
            make.top.equalTo(startTime.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(13)
            
            make.width.height.equalTo(16)
        }
        
        contener.addSubview(lessionTitle)
        lessionTitle.snp.makeConstraints { make in
            make.top.equalTo(lessionImage)
            make.left.equalTo(lessionImage.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        contener.addSubview(cabinetImage)
        cabinetImage.snp.makeConstraints { make in
            make.centerX.equalTo(lessionImage)
            make.width.equalTo(10)
            make.height.equalTo(14.2)
            make.top.equalTo(lessionTitle.snp.bottom).offset(10)
        }
        
        contener.addSubview(cabinetTitle)
        cabinetTitle.snp.makeConstraints { make in
            make.top.equalTo(cabinetImage)
            make.left.equalTo(lessionImage.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        contener.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.centerX.equalTo(cabinetImage)
            make.width.equalTo(17)
            make.height.equalTo(17)
            make.top.equalTo(cabinetTitle.snp.bottom).offset(10)
        }
        
        contener.addSubview(userTitle)
        userTitle.snp.makeConstraints { make in
            make.top.equalTo(userImage)
            make.left.equalTo(lessionImage.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    private var model: Lesson? = nil
    
    func fill(model: Lesson) {
        self.model = model
        
        startTime.text = model.start
        endTime.text = model.end
        
        lessionTitle.text = model.title
        
        cabinetTitle.text = "\(model.cabinet ?? "not set") - cabinet"
        
        if let user = model.teacher {
            UserServices.shered.findUser(user) { user in
                self.userTitle.text = "Mr. \(user?.fullName ?? "")"
            }
        }
    }
}
