//
//  MateVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class MateVC: BaseVC {
    
    // MARK: Properties
    
    // TODO: - 서버 통신 할 때 친구 수로 넘겨받는지 확인
    private var mateNum = 10
    private var selectedIndex: Int = 0
    
    private lazy var mateProfileCV = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .grey_0
    }
    
    private let mateTV = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .grey_0
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding = 0;
    }
    
    private let addMateNaviBar = PomeNaviBar().then {
        $0.setNaviStyle(state: .greyWithRightBtn)
        $0.configureRightCustomBtn(imgName: "icFriendAdd24")
    }
    
    private let titleHeaderLabel = UILabel().then {
        $0.setLabel(text: "친구 응원하기", color: .grey_9, size: 18, weight: .bold)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCell()
        setDelegate()
        setTVScroll()
    }
}

// MARK: - UI
extension MateVC {
    
    private func configureUI() {
        view.backgroundColor = .grey_0
        mateTV.separatorStyle = .none
        view.addSubviews([addMateNaviBar, mateTV, mateProfileCV, titleHeaderLabel])
    
        addMateNaviBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44.adjustedH)
        }
        
        titleHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(addMateNaviBar.snp.bottom).offset(4.adjustedH)
            $0.leading.equalTo(16.adjusted)
        }
        
        mateProfileCV.snp.makeConstraints {
            $0.top.equalTo(titleHeaderLabel.snp.bottom).offset(8.adjustedH)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(96)
        }
        
        mateTV.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(mateProfileCV.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Custom Methods
extension MateVC {
    
    private func registerCell(){
        HaveNoMateTVC.register(target: mateTV)
        HaveMateTVC.register(target: mateTV)
        MateHeaderCVC.register(target: mateProfileCV)
    }
    
    private func setDelegate() {
        mateTV.delegate = self
        mateTV.dataSource = self
        mateProfileCV.delegate = self
        mateProfileCV.dataSource = self
    }
    
    /// 친구가 없을때는 cell이 한개이므로 스크롤을 하지 않도록 막아둔다.
    private func setTVScroll() {
        mateTV.isScrollEnabled = (mateNum == 0) ? false : true
    }
}

// MARK: - UITableViewDelegate
extension MateVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (mateNum == 0) ? 516.adjustedH : 175.adjustedH
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mateNum == 0 {
            guard let haveNoMateTVC = mateTV.dequeueReusableCell(withIdentifier: Identifiers.HaveNoMateTVC, for: indexPath) as? HaveNoMateTVC else { return UITableViewCell() }
            return haveNoMateTVC
        } else {
            guard let haveMateTVC = mateTV.dequeueReusableCell(withIdentifier: Identifiers.HaveMateTVC, for: indexPath) as? HaveMateTVC else { return UITableViewCell() }
            return haveMateTVC
        }
    }
    
    /// CollectionView에서 전체보기 셀 1개 포함되어 있어서 + 1을 해주었습니다. 친구가 없을 경우 전체보기 셀 1개만 보이게 됩니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mateNum == 0) ? 1 : mateNum + 1
    }
}

// MARK: - UITableViewDataSource
extension MateVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension MateVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mateNum == 0) ? 1 : mateNum + 1
    }
}

// MARK: - UICollectionViewDelegate
extension MateVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mateProfileCV.dequeueReusableCell(withReuseIdentifier: Identifiers.MateHeaderCVC, for: indexPath) as? MateHeaderCVC else {
            return UICollectionViewCell()
        }
        
        /// 셀이 선택되었을때, 글씨체 설정
        cell.nameLabel.textColor = (indexPath.row == selectedIndex) ? .grey_9 : .grey_5
        cell.nameLabel.font = (indexPath.row == selectedIndex) ? UIFont.PretendardSB(size: 12) : UIFont.PretendardM(size: 12)
        
        /// 전체보기 버튼 이미지 설정
        if indexPath.row == 0 && selectedIndex == 0 {
            cell.profileImageView.image = UIImage(named: "btnAllViewProfileClicked")
        } else if indexPath.row == 0 && selectedIndex != 0 {
            cell.profileImageView.image = UIImage(named: "btnAllViewProfileNotClicked")
        } else {
            cell.profileImageView.image = UIImage(named: "userProfileFill32")
        }

        return cell
    }
    
    /// 셀이 선택되었을때의 값을 저장하고, 그에 맞게 collectionView이미지를 reload해 다시 보여줍니다.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MateVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 52, height: 76)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18.adjusted
    }
}
