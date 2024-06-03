//
//  ScheduleWeekdayView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

struct WeekdayModel {
    var name: String
    var date: String
}

class ScheduleWeekdayView: BaseView {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        
        view.showsHorizontalScrollIndicator = false
        
        view.dataSource = self
        view.delegate = self
        
        view.register(WeekdayItem.self, forCellWithReuseIdentifier: "WeekdayItem")
        
        return view
    }()
    
    private lazy var models: [WeekdayModel] = datesOfCurrentWeek()
        
    private lazy var currentDate: WeekdayModel? = nil
    
    override func setupSubViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            collectionView.scrollToItem(at: .init(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    private var currentIndex: Int = 0
    
    var action: (Weekday) -> Void = { _ in }
    
    func onSelect(action: @escaping (Weekday) -> Void) {
        self.action = action
    }
    
    func datesOfCurrentWeek() -> [WeekdayModel] {
        let calendar = Calendar.current
        var datesOfWeek: [WeekdayModel] = []
        
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let beginningOfWeek = calendar.date(byAdding: .day, value: -weekday + 1, to: today)!
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: beginningOfWeek) {
                let format = DateFormatter()
                format.dateFormat = "dd MMM"
                
                let model = WeekdayModel(name: Weekday(rawValue: i + 1)?.getName() ?? "", date: format.string(from: date))
                
                if date.isCurrent() {
                    currentIndex = i
                    
                    currentDate = model
                }
                
                datesOfWeek.append(model)
            }
        }
        
        return datesOfWeek
    }
}

extension ScheduleWeekdayView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 6) + 6, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekdayItem", for: indexPath) as! WeekdayItem
        let model = models[indexPath.row]
        
        cell.fill(model: model, isSelect: model.date == currentDate?.date)
        
        cell.onTab { [self] in
            currentDate = model
            
            action(Weekday.getWeekdayFromName(name: model.name))
            
            collectionView.reloadData()
        }
        
        return cell
    }
}

class WeekdayItem: BaseCollectionViewCell {
    
    private lazy var contener: BaseView = {
        let view = BaseView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var infoContener: BaseView = {
        return BaseView()
    }()
    
    private lazy var name: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12)
        view.text = "Mon"
        return view
    }()
    
    private lazy var number: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.text = "14 apr"
        return view
    }()
    
    override func setupSubViews() {
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            
            make.leading.trailing.equalToSuperview().inset(3)
        }
        
        contener.addSubview(infoContener)
        infoContener.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.leading.trailing.equalToSuperview()
        }
        
        infoContener.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        infoContener.addSubview(number)
        number.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(3)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    func fill(model: WeekdayModel, isSelect: Bool) {
        name.text = model.name
        number.text = model.date
        
        if isSelect {
            contener.backgroundColor = .init(hex: "#5068BD")
            name.textColor = .init(hex: "#FFFFFF")
            number.textColor = .init(hex: "#FFFFFF")
        } else {
            contener.backgroundColor = .clear
            name.textColor = .init(hex: "#000000")
            number.textColor = .init(hex: "#000000")
        }
    }
}
