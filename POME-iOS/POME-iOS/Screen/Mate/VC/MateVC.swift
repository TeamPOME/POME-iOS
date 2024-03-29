//
//  MateVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit
import SnapKit
import Then

class MateVC: BaseVC {
    
    // MARK: Properties
    private var emojiSelectViewTopConstraint: Constraint?
    private var mateDataList: [MateResModel] = []
    private var mateRecordList: [GetMateRecordResModel] = []
    private var selectedIndex: Int = 0
    private var cellFrame: CGFloat = 0
    private var scrollPosition: CGFloat = 0
    private var recordID: Int = -1
    private var mateID: Int = -1
    
    
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
    
    private let emojiSelectView = UIView().then {
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 25.adjusted)
        $0.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 4)
    }
    
    private let firstEmoji = UIButton().then {
        $0.setImage(UIImage(named: "emojiMintHappyFiter54"), for: .normal)
    }
    
    private let secondEmoji = UIButton().then {
        $0.setImage(UIImage(named: "emojiMint38"), for: .normal)
    }
    
    private let thirdEmoji = UIButton().then {
        $0.setImage(UIImage(named: "emojiMint3"), for: .normal)
    }
    
    private let fourthEmoji = UIButton().then {
        $0.setImage(UIImage(named: "emojiMint4"), for: .normal)
    }
    
    private let fifthEmoji = UIButton().then {
        $0.setImage(UIImage(named: "emojiMintNotSureFiter54"), for: .normal)
    }
    
    private let sixthEmoji = UIButton().then {
        $0.setImage(UIImage(named: "emojiMintRegretFiter54"), for: .normal)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCell()
        setDelegate()
        setTapRightNaviBtn()
        
        /// 처음 띄울 때는 전체보기
        getMateRecord(mateId: 0)
        setTapEmojiBtn()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbar()
        requestGetMateAPI()
        setTVScroll()
        setTVOffset()
    }
}

// MARK: - UI
extension MateVC {
    
    private func configureUI() {
        emojiSelectView.isHidden = true
        view.backgroundColor = .grey_0
        mateTV.backgroundColor = .grey_0
        mateProfileCV.backgroundColor = .grey_0
        mateTV.separatorStyle = .none
        
        /// TableView 하단 space 지정
        mateTV.contentInset.bottom = 55
        
        view.addSubviews([addMateNaviBar, mateTV, mateProfileCV, titleHeaderLabel, emojiSelectView])
        emojiSelectView.addSubviews([firstEmoji, secondEmoji, thirdEmoji, fourthEmoji, fifthEmoji, sixthEmoji])
        
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
        
        emojiSelectView.snp.makeConstraints {
            
            /// 첫번째 셀의 버튼 클릭 시 나타나야할 포지션을 디폴트로 설정 해둠
            self.emojiSelectViewTopConstraint = $0.top.equalTo(390).constraint
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(330)
            $0.height.equalTo(54)
        }
        
        firstEmoji.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(38)
        }
        
        secondEmoji.snp.makeConstraints {
            $0.leading.equalTo(firstEmoji.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(38)
        }
        
        thirdEmoji.snp.makeConstraints {
            $0.leading.equalTo(secondEmoji.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(38)
        }
        
        fourthEmoji.snp.makeConstraints {
            $0.leading.equalTo(thirdEmoji.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(38)
        }
        
        fifthEmoji.snp.makeConstraints {
            $0.leading.equalTo(fourthEmoji.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(38)
        }
        
        sixthEmoji.snp.makeConstraints {
            $0.leading.equalTo(fifthEmoji.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(38)
            $0.trailing.equalToSuperview().inset(16)
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
    
    /// 친구의 기록이 없을 때는 엠티뷰 스크롤을 막는다.
    private func setTVScroll() {
        mateTV.isScrollEnabled = (mateRecordList.count == 0) ? false : true
    }
    
    /// 네비바 오른쪽 버튼 tap Action 설정 메서드
    private func setTapRightNaviBtn() {
        addMateNaviBar.rightCustomBtn.press { [weak self] in
            guard let addFriendVC = UIStoryboard.init(name: Identifiers.AddFriendSB, bundle: nil).instantiateViewController(withIdentifier: Identifiers.AddFriendVC) as? AddFriendVC else { return }
            
            addFriendVC.naviBar.setNaviStyle(state: .whiteBackWithTitle)
            addFriendVC.hasBackView = true
            self?.navigationController?.pushViewController(addFriendVC, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollPosition = scrollView.contentOffset.y
        emojiSelectView.isHidden = true
    }
    
    /// 테이블뷰 가장 위로 올림
    private func setTVOffset() {
        mateTV.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    /// 감정 이모지 버튼 tap Action 설정 메서드
    private func setTapEmojiBtn() {
        firstEmoji.press { [weak self] in
            guard let self = self else { return }
            self.postMateRecordEmoji(emotion: 1, targetId: self.recordID)
        }
        secondEmoji.press { [weak self] in
            guard let self = self else { return }
            self.postMateRecordEmoji(emotion: 2, targetId: self.recordID)
        }
        thirdEmoji.press { [weak self] in
            guard let self = self else { return }
            self.postMateRecordEmoji(emotion: 3, targetId: self.recordID)
        }
        fourthEmoji.press { [weak self] in
            guard let self = self else { return }
            self.postMateRecordEmoji(emotion: 4, targetId: self.recordID)
        }
        fifthEmoji.press { [weak self] in
            guard let self = self else { return }
            self.postMateRecordEmoji(emotion: 5, targetId: self.recordID)
        }
        sixthEmoji.press { [weak self] in
            guard let self = self else { return }
            self.postMateRecordEmoji(emotion: 6, targetId: self.recordID)
        }
    }
}

// MARK: - @objc
extension MateVC {
    
    /// 만들어 둔 HalfModalVC 보여주는 함수
    @objc func showHalfModalVC() {
        let halfModalVC = MateEmojiBottomSheetVC()
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        self.present(halfModalVC, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension MateVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let halfModalVC = PomeHalfModalVC(presentedViewController: presented, presenting: presenting)
        
        /// HalfModalView의 높이 지정
        halfModalVC.modalHeight = 342.adjustedH
        return halfModalVC
    }
}

// MARK: - UITableViewDelegate
extension MateVC: UITableViewDelegate {
    
    /// 친구 유무에 따른 셀별 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (mateDataList.count == 0) ? 516.adjustedH : 175.adjustedH
    }
    
    /// 친구 유무에 따른 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let haveNoMateTVC = mateTV.dequeueReusableCell(withIdentifier: Identifiers.HaveNoMateTVC) as? HaveNoMateTVC,
              let haveMateTVC = mateTV.dequeueReusableCell(withIdentifier: Identifiers.HaveMateTVC) as? HaveMateTVC else { return UITableViewCell() }
        
        if mateDataList.count == 0{
            haveNoMateTVC.descriptionLabel.text = "아직 추가한 친구가 없어요"
            return haveNoMateTVC
        }
        else if mateRecordList.count == 0 {
            haveNoMateTVC.descriptionLabel.text = "친구의 기록이 없어요"
            return haveNoMateTVC
        } else {
            haveMateTVC.tapMateEmojiBtnAction = {
                self.showHalfModalVC()
            }
            haveMateTVC.tapPlusBtnAction = {
                self.recordID = self.mateRecordList[indexPath.row].id
                let cell = tableView.cellForRow(at: indexPath)
                let frame = cell?.layer.frame
                self.cellFrame = (frame?.maxY ?? 0) + 205
                self.emojiSelectViewTopConstraint?.update(offset: self.cellFrame - self.scrollPosition)
                self.view.layoutIfNeeded()
                self.emojiSelectView.isHidden = false
            }
            haveMateTVC.setData(data: mateRecordList[indexPath.row])
            return haveMateTVC
        }
    }
    
    /// 레코드가 없으면 엠티뷰 1개
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mateRecordList.count == 0) ? 1 : mateRecordList.count
    }
}

// MARK: - UITableViewDataSource
extension MateVC: UITableViewDataSource {
    
    /// tableview section 개수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension MateVC: UICollectionViewDataSource {
    
    /// 전체보기 셀 포함 친구 셀 개수 지정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mateDataList.count == 0) ? 1 : mateDataList.count + 1
    }
}

// MARK: - UICollectionViewDelegate
extension MateVC: UICollectionViewDelegate {
    
    /// 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mateProfileCV.dequeueReusableCell(withReuseIdentifier: Identifiers.MateHeaderCVC, for: indexPath) as? MateHeaderCVC else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 && selectedIndex == 0 {
            cell.profileImageView.image = UIImage(named: "btnAllViewProfileClicked")
            cell.nameLabel.text = "전체보기"
        } else if indexPath.row == 0 && selectedIndex != 0 {
            cell.profileImageView.image = UIImage(named: "btnAllViewProfileNotClicked")
            cell.nameLabel.text = "전체보기"
        } else {
            let url = URL(string: mateDataList[indexPath.row - 1].profileImage)
            cell.profileImageView.kf.setImage(with: url)
            cell.nameLabel.text = mateDataList[indexPath.row - 1].nickname
        }
        
        /// 셀이 선택되었을때, 글씨체 설정
        cell.nameLabel.textColor = (indexPath.row == selectedIndex) ? .grey_9 : .grey_5
        cell.nameLabel.font = (indexPath.row == selectedIndex) ? UIFont.PretendardSB(size: 12) : UIFont.PretendardM(size: 12)
        return cell
    }
    
    /// 셀이 선택되었을때의 값을 저장하고, 그에 맞게 collectionView이미지를 reload해 다시 보여줍니다.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
        if indexPath.row > 0 {
            getMateRecord(mateId: mateDataList[indexPath.row - 1].id)
            mateID = mateDataList[indexPath.row - 1].id
        } else {
            getMateRecord(mateId: 0)
            mateID = 0
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MateVC: UICollectionViewDelegateFlowLayout {
    
    /// collectionviewCell 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 52, height: 76)
    }
    
    /// collectionview의 inset 값 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    /// 셀별 사이 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}

// MARK: - Network
extension MateVC {
    
    /// 상단의 친구 목록 요청
    private func requestGetMateAPI() {
        self.activityIndicator.startAnimating()
        MateAPI.shared.requestGetMateAPI() {
            networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? [MateResModel] {
                    DispatchQueue.main.async {
                        self.mateDataList = data
                        self.mateProfileCV.reloadData()
                    }
                    self.activityIndicator.stopAnimating()
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
                self.activityIndicator.stopAnimating()
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
                self.activityIndicator.stopAnimating()
            }
            self.mateProfileCV.reloadData()
        }
    }
    
    /// 친구 기록 조회 요청 메서드
    private func getMateRecord(mateId: Int) {
        self.activityIndicator.startAnimating()
        MateAPI.shared.getMateRecordAPI(userId: mateId) { networkResult in
            self.activityIndicator.startAnimating()
            switch networkResult {
            case .success(let data):
                if let data = data as? [GetMateRecordResModel] {
                    DispatchQueue.main.async {
                        self.mateRecordList = data
                        self.setTVScroll()
                        self.mateTV.reloadData()
                    }
                    self.activityIndicator.stopAnimating()
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
                self.activityIndicator.stopAnimating()
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    /// 친구 기록 감정 등록 메서드
    private func postMateRecordEmoji(emotion: Int, targetId: Int) {
        self.activityIndicator.startAnimating()
        MateAPI.shared.postMateRecordEmojiAPI(emotion: emotion, targetId: targetId) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _ = data as? PostEmojiResModel {
                    self.activityIndicator.stopAnimating()
                    DispatchQueue.main.async {
                        self.getMateRecord(mateId: self.mateID)
                    }
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}
