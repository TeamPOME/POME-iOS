![포미 많관부](https://user-images.githubusercontent.com/58043306/178574834-271eda6f-04f9-471f-b6e8-ee611e07f479.png)

> **돈 쓸 때 무슨 생각해? 나를 위한 소비기록, Pay fOr ME**
> <br> <br> 소비에 정답이 있을까요?
> <br> 무조건 절약하는 것도 아니고 넘치게 사용하는 것도 아닌, 나의 기준에 만족스러울 때 행복한 소비가 된다고 믿습니다.
> <br> <br> 목표에 따른 소비 기록, 나의 소비 감정 기록, 회고, 친구의 소비 공감, 마시멜로 모으기, 푸시 알림을 통해
> <br> `#감정 기록을 통한 성장` `#주도적인 소비` `#함께 성장하는 소비`를 경험 해보세요.
>
> 30th THE SOPT APPJAM <br>
> 프로젝트 기간 : 2022.07.02 ~ 2022.07.23

<br>

## 🍎 POME iOS Developers
| <img src="https://user-images.githubusercontent.com/58043306/178588471-1023b857-e317-47bc-8434-52e0c072dbf4.jpg" width="200"> | <img src="https://user-images.githubusercontent.com/58043306/178588973-42d67e9d-2fc9-400b-896b-5425998b16f7.jpg" width="200"> | <img src="https://user-images.githubusercontent.com/58043306/178588958-53a24567-3815-49af-84c7-1faadb74166b.jpg" width="200"> |
| :---------:|:----------:|:---------:|
| 은주 | 주현  | 유진 |
| [@jane1choi](https://github.com/jane1choi)  |  [@wngus4296](https://github.com/wngus4296)  |  [@yujindonut](https://github.com/yujindonut) | 

<br>

## 💻 Coding Convention
<details markdown="1">
<summary>네이밍</summary>

---

### Class & Struct
- 클래스/구조체 이름은 **UpperCamelCase**를 사용합니다.

<br>

### 함수, 변수, 상수
- 함수와 변수에는 **lowerCamelCase**를 사용합니다.
- 버튼명에는 **Btn 약자**를 사용합니다.
- 모든 IBOutlet에는 해당 클래스명을 뒤에 붙입니다.  
- 기본 클래스 파일을 생성하거나 컴포넌트를 생성할 때는 약어 규칙에 따라 네이밍합니다.  

  - 예시
     
    `TV` `TVC` `CV` `CVC` `VC` `NVC` `TBC`
    
    ```Swift
    TableView -> TV
    TableViewCell -> TVC
    CollectionView -> CV
    CollectionView Cell -> CVC
    ViewController -> VC
    NavigationController -> NVC
    TabbarController -> TBC
    ```

  <kbd>좋은 예</kbd>
  ```swift
  @IBOutlet weak var pomeBtn: UIButton!
  @IBOutlet weak var pomeBackMainView: UIView!
  @IBOutlet weak var writeMainCV: UICollectionView!
  ```
  
  <kbd>나쁜 예</kbd>
  ```swift
  @IBOutlet weak var ScrollView: UIScrollView!
  @IBOutlet weak var pomeCollectionView: UICollectionView!
  @IBOutlet weak var tagCollectionView: UICollectionView!
  @IBOutlet weak var tableview: UITableView!
  ```
  
<br>

### 함수 네이밍
- `set` → setDelegate (기능관련 함수)
- `configure` → configureUI (UI관련 함수)   
- `IBAction`→ **tap**DismissBtn() : 단순 클릭, **present**ResultVC() : 화면전환 메소드(push, present, pop, dismiss)

<br>

</details>

<details markdown="2">
<summary>주석</summary>

---

```

// MARK: Properties

// MARK: IBOutlet

// MARK: IBAction

// MARK: Life Cycle

- Extension Part
// MARK: - UI

// MARK: - Custom Methods

// MARK: - @objc

// MARK: - Delegate

// MARK: - Protocol

// MARK: - Network

- ETC
/// ~ 하는 메서드 (함수는 항상 문서화)

// TODO: - 앞으로 할 일을 TODO로 적어두기
 
```
	
</details>

<details markdown="3">
<summary>공백</summary>

---
	
- 탭 사이즈는 4로 사용합니다.
- 한 줄의 최대 길이는 80자로 제한합니다.
- 불필요한 공백은 사용하지 않습니다.
- 최대 tab depth 제한
  - tab의 최대 depth는 4로 제한합니다.
  - 이 이상으로 depth가 길어지면 함수를 통해 나눌 수 있도록 합니다.
  - 그 이상으로 개선할 수 없다고 판단되는 경우, 팀원들과의 코드리뷰를 통해 개선합니다.  
   
- 괄호 사용
  - (if, while, for)문 괄호 뒤에 한칸을 띄우고 사용합니다.
 
  ```Swift
     if (left == true) {
	   // logic
     }
     ```
  
- 띄어쓰기
 
  ```Swift
  let a = 5; // 양쪽 사이로 띄어쓰기 하기
  if (a == 3) {
	// logic
  } else {
  }
  ```
  ```Swift
  dictionary [Key: Value]
  ```

<br>

</details>

<details markdown="4">
<summary>기타 규칙</summary>  

---
 
 - 외부에서 사용되지 않을 변수나 함수는 `private`으로 선언합니다.
 - **viewDidLoad()** 와 같은 생명주기 함수들에는 `function`만 위치시킵니다.
 - 불필요한 self는 지양합니다.
     <kbd>예외</kbd> 클로저를 사용할 때는 자체 함수에 self를 붙여줍니다.
 - **extension** 을 사용해 기능 단위로 코드를 더 가독성있게 구분합니다. 
   - 기본 클래스에 배치되는 것: `IBOutlet`, `Properties`, `Life Cycle`, `IBAction`
   - 이외의 코드는 extension에 배치합니다.
    
</details>

<br>
	

## 🗂 Foldering Convention
<details>
<summary> 💸 POME-iOS Foldering Convention 💸 </summary>
<div markdown="1"> 

```
 POME-iOS
    │
    ├── Global
    │   ├── PublicData
    │   │    └── AppModel
    │   ├── Factory
    │   ├── Class
    │   ├── Struct
    │   ├── Protocol
    │   ├── UIComponent
    │   ├── Extension
    │   ├── Font
    │   └── LaunchScreen.storyboard
    │       
    ├── Network
    │   ├── Bases
    │   │   ├── TargetType.swift
    │   │   └── NetworkResult.swift
    │   ├── APIEssentials
    │   │   ├── APIConstants.swift
    │   │   ├── NetworkConstants.swift
    │   │   └── GenericResponse.swift
    │   ├── Services
    │   ├── APIModels
    │   └── APIManagers
    ├── Screen
    │   └── Write
    │       ├── SB
    │       ├── VC
    │       ├── Cell
    │       │   ├── TVC
    │       │   └── CVC
    │       └── Xib
    └── Support
        ├── Info.plist
        ├── AppDelegate.swift
        ├── SceneDelegate.swift
        ├── Assets.xcassets
        └── Colorsets.xcassets
``` 
</details>
	
<br>

## ✉️ Commit Convention

```
[CHORE] 코드 수정, 내부 파일 수정 
[FEAT] 새로운 기능 구현 
[ADD] Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시, 에셋 추가
[HOTFIX] issue나, QA에서 급한 버그 수정에 사용
[FIX] 버그, 오류 해결
[REMOVE] 쓸모없는 코드 삭제 
[DOCS] README나 WIKI 등의 문서 개정
[MOVE] 프로젝트 내 파일이나 코드의 이동 
[RENAME] 파일 이름, 변수명, 함수명 변경이 있을 때 사용합니다. 
[REFACTOR] 전면 수정이 있을 때 사용합니다 
```

<br>

## ✨Github Management
<details>
<summary> 💸 POME-iOS Gitflow 💸 </summary>
<div markdown="1">  

```
1. Issue를 생성한다.
2. 깃 컨벤션에 맞게 Branch를 생성한다.
3. Add - Commit - Push - Pull Request 의 과정을 거친다.
4. Pull Request가 작성되면 작성자 이외의 다른 팀원이 Code Review를 한다.
5. Code Review가 완료되면 Pull Request 작성자가 develop Branch로 merge 한다.
6. merge된 Branch는 삭제한다.
7. 종료된 Issue와 Pull Request의 Label과 Project를 관리한다.
```
	
### 🌴 브랜치
---
#### 📌 브랜치 단위
- 브랜치 단위 = 이슈 단위 = PR단위

#### 📌 브랜치명
- 브랜치는 뷰 단위로 생성합니다.
- 브랜치 규칙 → feature/#이슈번호-(UI/Func)-탭-기능간략설명
- `ex) feature/#1-UI-home-navibar`
- 탭이름 - Write, Remind, Mate, Mypage
- 공통적인 것 작업 - Global
    - feature/chore/fix/network

<br>
	
### 💡 이슈, PR 규칙
---
#### 📌 Issue명 = PR명
- ✨ [FEAT] - 기능 구현
- 🔨 [FIX] - 버그 수정
- ♻️ [REFACTOR] - 코드 리팩토링(결과물은 같지만 코드의 향상)
- ✅ [CHORE] - 수정
- ➕ [ADD] - 세팅 및 라이브러리 추가

</details>
<br>
 
## 💸 역할 분담
### 은주
- 프로젝트 세팅
- 공통 컴포넌트: `PomeBtn`, `PomeNaviBar`, `PomeTextField`, `PomeMaskedImageView`, `PomeAlertVC` 
  - `구현방법` Custom Class로 생성해두고 컴포넌트 스타일 적용
- 카카오 로그인, 회원가입
  - `구현방법` 카카오에 로그인 요청 후 소셜 토큰을 발급받아 서버에 전달, 서버에서 소셜 토큰을 이용해 기존 유저 인지 판단해 회원가입 or 로그인으로 넘길지 판단
- 친구 검색 및 추가
  - `구현방법` 검색하기 버튼 클릭 시 서버통신. res를 이용해 tableview에 결과 뿌려줌
- 친구 감정 남기기 플로팅 뷰
  - `구현방법` 셀마다의 offset.y 값을 받아와 원하는 좌표에 이모지 선택 뷰 보여줌

### 주현
- 공통 컴포넌트: `SpendCVC`, `PomeHalfModalVC`
  - `구현방법` 바텀시트 UIPresentationController를 사용해서 화면 전환으로 구현
- 기록탭 메인
  - `구현방법` 상단 카테고리 CV, 카테고리 제외한 부분 CV 총 2개로 구성, 상단 카테고리 CV에서 선택한 목표에 따라 아래의 데이터 서버 통신
- 기록탭 되돌아보기
  - `구현방법` 1개의 CV로 구성
- 기록탭 목표 추가
  - `구현방법` FSCalendar 라이브러리 사용
- 기록 글쓰기
  - `구현방법` viewWillAppear에서 목표 카테고리 리스트를 가져와서 저장해두고 목표 선택 바텀시트에 데이터를 뿌려줌

### 유진
- 공통 컴포넌트: `GoalCardCVC`
  - `구현방법` UICollectionView 이용
- 회고 탭  
  `구현방법`
  - 위에 title부분을 제외하고 스크롤이 가능하게 하기 위해서 section별로 셀을 작성
  - 감정 필터링 기능을 위한 분기처리 - delegate 이용하기
  - 바텀네비게이션 띄워서 클로저를 이용해 데이터를 받아오기
- 친구 탭    
  `구현방법` 
  - 위에 title부분을 제외하고 스크롤이 가능하게 하기 위해서 section별로 셀을 작성
  - 감정 필터링 기능을 위한 분기처리 - delegate 이용하기
  - 바텀네비게이션 띄워서 클로저를 이용해 데이터를 받아오기
- 마이페이지: 메인, 완료한 목표     
  `구현방법`
  - percentage값에 따른 progressbar 분기처리
  - 기본 progressbar를 이용하지 않고 UIView를 두개 만들어서, progressbar값이 들어올때마다 constraint값 다시 불러오기

## 🛠 Development Environment
<p align="left">
<img src ="https://img.shields.io/badge/Swift-5.0-ff69b4">
<img src ="https://img.shields.io/badge/Xcode-13.3-blue">
<img src ="https://img.shields.io/badge/iOS-15.0-blue">

<br>
<br>

## 📚 Library
| 라이브러리(Library) | 목적(Purpose) | 버전(Version) |
|:---|:----------|----|
| Alamofire | 네트워크 통신 | 5.6.1 |
| SnapKit | autolayout 표현 | 5.0.0 |
| Then | 클로저를 이용한 인스턴스 생성 | 3.0.0 |
| FSCalendar | 캘린더 구현 | 2.8.4 |
| KingFisher | 이미지 불러오기 | 7.3.0 |
| Lottie | 애니메이션 구현 | 3.4.0 |

## 💚 프로젝트 회고

### 은주  
기술적으로 가장 어려웠던 부분은 multipart/form-data를 통한 회원가입 서버통신 부분이었다. Alamofire 네트워크 통신 라이브러리를 이용해 서버 통신을 진행했었는데 회원가입 통신부에서만 원인을 파악하기 힘든 에러가 생겼고, 서버 로그를 확인해보니 ‘boundary not found’, ‘unexpected end of form’ 등의 에러 메시지가 있었다. 그래서 boundary에 대해 찾아보았는데, 바운더리는 멀티파트 데이터의 시작과 끝을 알리는 문자열로, 원래 Alamofire 라이브러리 내에서 처리해서 서버로 보내주는데, 이에 대한 내부적인 처리가 제대로 안되는 것 같았다. 그래서 회원가입 통신부만 iOS의 기본적인 통신방법인 URLSession을 이용해서 해주었더니 API연결이 되었다. 결과적으로 문제를 해결하긴 했지만 이번 trouble shooting 과정에서 URLSession을 이용해 처음 통신을 해보는 것이라 통신에 성공하기까지의 과정이 쉽지 않았던 것 같다. 이번을 계기로 라이브러리를 사용해 통신을 하더라도 네트워크 통신의 기본 원리에 대해 제대로 파악하고 있어야  원인을 빠르게 파악하여 예상치 못한 이슈에 빠르게 대응할 수 있음을 깨달았다. 어떤 기술을 사용하던지 항상 기본을 충실히 공부하고 개발해야겠다고 생각하는 계기가 되었던 것 같다.

### 주현  
목표 생성에서 두 개의 캘린더가 사용되었다. 하나의 캘린더 VC로 사용하다보니 활성화되는 날짜, 이전 달이나 다음 달로 이동하는 버튼 활성화 분기처리 하는 과정이 어려웠다. 그리고 이미 선택된 날을 default 값으로 띄워줘야 했기 때문에 캘린더를 띄우는 VC에서 현재 선택된 날짜를 보내주고, 다시 캘린더에서 선택된 날짜로 변경해주는 작업도 쉽지 않았다. 목표를 생성할 때는 오늘부터 한 달 간 선택이 가능한 시작 날짜 캘린더, 선택한 시작 날짜로부터 한 달 간 선택이 가능한 종료 날짜 캘린더 중 어느 캘린더를 선택했는지에 따라 isStartCalendar(bool)값을 전달했다. 캘린더 VC에서는 isStartCalendar값에 따라 minimumDate, maximumDate를 정해주었다. 또한 현재 선택되어있는 날짜의 유무에 따라 default값도 정해주었다. 버튼 활성화도 isStartCalendar 값에 따라 정해주었다.
프로젝트 시작 전에 캘린더 연습을 했었는데, 캘린더를 사용해야하는 곳이 여러 개일 경우를 고려하지 않아서 실제 프로젝트에서 로직 처리를 하는 데 시간이 걸렸다. 그리고 이후에 또 캘린더를 쓰는 VC가 있을 경우 확장성을 위해 코드 리팩토링이 필요할 것 같다.
**알고리즘 공부를 열심히 하자**

### 유진   
기술적인 면에서는, 친구 탭에서 이모지가 balloon 창처럼 떠야 한다는 점이었다. 안드로이드는 그에 대한 라이브러리가 있었지만, is에서는 벌룬창을 작성하는 것이 쉽지 않았다. 검색해보았지만, 따로 좋은 생각이 나지 않았다. 이 부분은 최고의 리드 은주가 해결해주었다. 그리고 내가 기록한 감정 필터링 기능이 어려웠다. 버튼을 추가할수록 분기 처리해줘야 하는 부분이 많아졌고, 이상한 데이터가 띄어지기 시작했다. 이 부분에서는 서버 통신을 하면서 더 고쳐야 할 점이 많아지겠지만 좋은 경험을 했다고 생각했다. 또한, 서버 통신을 하면서 데이터가 번쩍임이 생긴다는 것이었다. 특히 이미지를 넣는 부분에서 사진이 통통 튀게 되었다. 이 부분은 라이브러리 킹피셔를 이용해 데이터를 호출하니 해결이 되었다. 킹피셔가 캐시 처리를 대신해주어서 사진이 통통 튀는 것이 사라지게 되었다. 라이브러리는 좋다 ~

프로젝트를 하면서 어려웠던 점은 소통이다. 기획에 대한 기능이 헷갈리기 시작하니까, 개발하는 것에 대해서 어려움을 느꼈다. 기획에 대한 궁금증이 사라져야, 개발을 잘 진행할 수 있다는 사실을 깨달았다. 기획이 탄탄해야 함을 알았고, 궁금증이 생기는 부분에 대해서 질문을 바로 해야 한다는 것을 깨달았다. 질문을 절대 미루지 않아야 한다고 생각했다.

그리고 또한, 깃 컨벤션을 지키는 것이 어려웠다. 변수명 등은 규칙을 정해 정하는 것이 몸에 배지 않아서, 주석도 잘 작성하지 않았고 변수명도 계속해서 틀렸다. 하지만, 내가 짠 코드를 다른 동료들이 사용하기 때문에, 주석이나 변수 등을 제대로 작성하지 않으면 협업이 어려워진다는 것을 정말 많이 깨닫게 되었다. 통일된 규칙이 있어야, 수정, 협업이 쉬워진다는 것을 깨닫고 나니, 어떤 협업 프로젝트를 진행하던 규칙을 꼭 정할 것이다!

또한, 서로 작업시간이 달라 처음에는 어려움을 겪었다. 하지만, 그 프로젝트 기간에는, 다수와 작업시간을 통일해, 서로 궁금증이 생길 때마다 바로 묻고 대답함이 중요함을 깨달았다. 이후엔, 최대한 작업시간을 통일해 프로젝트를 진행하는 방안으로 극복하였다.

앱잼 끝나고도 코드 리팩토링 할 것이다~
