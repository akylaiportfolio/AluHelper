//
//  OrdersCell.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import UIKit
import SnapKit

class OrdersCell: BaseTableCell {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        
        view.showsHorizontalScrollIndicator = false
        
        view.dataSource = self
        view.delegate = self
        
        view.isPagingEnabled = true
        view.register(OrdersItem.self, forCellWithReuseIdentifier: "OrdersItem")
        
        return view
    }()
    
    private lazy var pagingIndecator = PagingIndecator()
    
    private var model: [OrderModel] = []
    
    func fill(model: [OrderModel]) {
        self.model = model
        
        pagingIndecator.fill(count: model.count)
        
        pagingIndecator.set(index: 0)
        
        collectionView.reloadData()
    }
    
    private var onSelectAction: (OrderModel) -> Void = { _ in }
    
    func onSelectItem(onSelectAction: @escaping (OrderModel) -> Void) {
        self.onSelectAction = onSelectAction
    }
    
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
    }
}

extension OrdersCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrdersItem", for: indexPath) as! OrdersItem
        let model = model[indexPath.row]

        cell.fill(model: model)
        
        cell.onTab { self.onSelectAction(model) }
                
        return cell
    }
}

class OrdersItem: BaseCollectionViewCell {
    
    private lazy var contener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero

        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var nameImage = BaseImage(image: UIImage(named: "Book"))
    
    private lazy var nameTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.text = "Equations Math Physics"
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var messageTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .thin)
        view.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley "
        view.numberOfLines = 5
        return view
    }()
    
    private lazy var timeImage = BaseImage(image: UIImage(named: "Calendar"))
    
    private lazy var timeTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.text = "Create 18.08.2023"
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
        
        contener.addSubview(nameImage)
        nameImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(13)
            
            make.width.height.equalTo(16)
        }
        
        contener.addSubview(nameTitle)
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(nameImage)
            make.left.equalTo(nameImage.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        contener.addSubview(messageTitle)
        messageTitle.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(timeImage)
        timeImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(13)
            
            make.width.height.equalTo(16)
        }
        
        contener.addSubview(timeTitle)
        timeTitle.snp.makeConstraints { make in
            make.top.equalTo(timeImage)
            make.left.equalTo(timeImage.snp.right).offset(6)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    private var model: OrderModel? = nil
    
    func fill(model: OrderModel) {
        self.model = model
        
        nameTitle.text = model.title
        messageTitle.text = model.decription
        timeTitle.text = "Create: \(model.create ?? "")"
    }
}
