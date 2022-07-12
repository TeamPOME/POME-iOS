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
- 은주
```
- 프로젝트 세팅
- 스플래시
- 회원가입, 로그인
- 마이페이지: 설정 관련
- 기록 탭: 목표 종료하기
- 공통 컴포넌트: PomeBtn, PomeNaviBar, PomeTextField, PomeMaskedImageView, PomeAlertVC
```

- 주현
```
- 기록 탭: 메인, 되돌아보기, 목표 CRUD, 기록 CRUD
- 공통 컴포넌트: SpendCVC, PomeHalfModalVC
```

- 유진
```
- 회고 탭
- 친구 탭
- 마이페이지: 메인, 완료한 목표
- 공통 컴포넌트: GoalCardCVC
```
