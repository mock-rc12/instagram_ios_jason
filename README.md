# 인스타그램 클론 앱

## 💡 작업 개요

- 라이징 캠프의 마지막 과정으로, 서버와 협업을 통해 인스타그램 앱을 제작함
- 개발 기간: 2주 (22.12.31 ~ 223.1.13)
- 기술 스택
    - iOS: `Swift`, `UIKit`, `Storyboard`

## 💡 파트별 설명

### 1. 회원가입

<img width="700" alt="01" src="https://user-images.githubusercontent.com/108998071/215162935-2bb54298-053c-421d-b4cb-69feed6d7755.png">

- 약 5개의 뷰를 거쳐 모든 정보를 받게 되어 있음
- 1개의 회원가입 ViewController 클래스가 enum 타입을 통해 여러가지 뷰를 표시, 정보를 받도록 설계

### 2. 로그인

<img width="450" alt="02" src="https://user-images.githubusercontent.com/108998071/215162930-28a63fc0-fdbd-415e-8d57-127f8591dcab.png">

- 실제 인스타그램과 동일하게, 일반 로그인과 facebook 소셜 로그인 적용
- 모든 영역을 채워야 하는 조건문 적용

### 3. 홈 피드

<img width="700" alt="03" src="https://user-images.githubusercontent.com/108998071/215162925-6826c922-0164-49e6-a843-20e47d8ca1fc.png">

- 홈 피드뷰는 스토리와 피드뷰로 나뉘어짐
- 홈 피드 TableView
    - 스토리 Cell
        - 스토리 CollectionView / Cell
    - 피드 Cell

### 4. 좋아요 / 댓글 리스트 뷰

<img width="400" alt="04" src="https://user-images.githubusercontent.com/108998071/215162922-998cc407-ac43-4bf3-9021-0fde39f016da.png">

- 입력한 댓글 내용이 없을 경우, 게시 버튼 비활성화
- **🤔 고민 1. 유저 ID와 댓글 내용의 유동적인 레이아웃 적용(서로 다른 객체)**
    - 해결:  댓글 내용의 첫줄 들여쓰기 깊이를 유저ID의 width에 따라 조절되도록 함
- **🤔 고민 2. 댓글의 길이에 따라 댓글 Cell의 높이 동적 조절**
    - 왜 어려웠나요? : Cell의 높이가 먼저 결정되고, 그 다음 Cell 내부 레이아웃이 정해지게 되어있음
    - 해결: 댓글 내용과 동일한 내용의 dummy `UILabel`을 만들고, dummy `UILabel`의 높이에 따라 Cell의 높이 결정

### 5. 게시글 옵션 Bottom Sheet

<img width="400" alt="05" src="https://user-images.githubusercontent.com/108998071/215162918-9de6dcb4-c936-451b-b4e1-3acfff7be1f3.png">

- Apple의 UIKit에서 기본 제공하는 `Bottom Sheet`은 iOS15 부터 적용 가능 (현 프로젝트 타겟 iOS14)
- 따라서, 커스텀으로 제작된 Bottom Sheet을 사용함
- 선택한 메뉴의 피드가 ‘`본인`’의 피드인지 ‘`다른 사람`’의 피드인지 구분(enum)을 통한 UI 변경
    - 하나의 클래스에서 적용되도록 함
    - 상대방일때: 팔로우 취소, 신고, 공유 등의 기능을 가진 메뉴가 올라옴
    - 본인일때: 피드 수정, 삭제 등의 기능을 가진 메뉴가 올라옴

💡 추후, 라이브러리를 활용한 리팩토링 예정


### 6. 게시 / 수정 / 삭제

<img width="600" alt="06" src="https://user-images.githubusercontent.com/108998071/215162912-e59e2ee7-1747-451f-9a04-f730b17217f3.png">

- 카메라 앨범의 사진 선택(최대 10장으로 제한)
- 필터 적용 기능
- 내용을 입력하고 `완료`를 누를 경우 업로드 프로세스 진행

**🤔고민: 서버에는 이미지 url만 올릴 수 있음. 어떻게 이미지 url을 올릴까?**
해결: Firebase Storage 사용

- 이를 위해 다음 프로세스를 거침
    1. 선택한 사진들을 `Firebase Storage`에 올림
    2. `Firebase Storage`에 이미지가 업로드 완료되면, 이미지 url을 받음
    3. 이미지 url을 포함한 모델을 개발서버에 Post 요청

💡 포스트 게시 과정에는 `firebase`와 `Post` 두단계의 비동기 처리를 거침
escaping closure를 사용해 코드가 복잡함
→ 추후 `async / await` 을 활용한 리팩토링 예정(피드백 내용)

### 7. 프로필

<img width="600" alt="07" src="https://user-images.githubusercontent.com/108998071/215162896-975b6e38-a2f7-4dda-a410-8e99d8c0e445.png">

- 복잡한 UI의 구현을 위한 UICollectionViewCompositionalLayout (iOS13~) 을 사용
- 상단 탭바는 sticky header로 설정해 상단에 고정되도록 함
- `본인` 일 경우와 `다른사람` 일 경우 UI를 다르게 구성

<img width="300" alt="st" src="https://user-images.githubusercontent.com/108998071/215163800-30e00e12-d7fa-406a-840c-3b8af521c149.png">

Sticky Header 처리 된 상단 탭 바

- 본인일 경우
    - 프로필 편집 버튼으로 설정
- 상대방일 경우
    - 팔로우 / 팔로잉 버튼으로 설정

### 8. 팔로워 / 팔로잉 뷰

<img width="400" alt="08" src="https://user-images.githubusercontent.com/108998071/215162892-8701585c-995b-46f2-8e21-ec85ad0e9a38.png">

### 9. 검색 탭

<img width="600" alt="09" src="https://user-images.githubusercontent.com/108998071/215162885-30013f04-b8e0-49bb-9a62-fe742faa38e4.png">

- 검색 뷰 : 복잡한 UI 구현(1개 섹션 내 2개 그룹의 연속)을 위해 UICollectionViewCompositionalLayout 사용
- 유저 검색 : Search bar에 입력된 글자마다 검색 API 호출, 리스트로 뜨게 함

## 💡 배운 내용

### 🔥 API 명세서에 따른 네트워크 구현

- API 명세서를 기반으로 서버와 협업하는 방법 & 경험

### 🔥 앱이 구동되는 구조

- 인스타그램의 모든 기능 구현한 것은 아니지만, 하나의 앱이 굴러가는 흐름 파악, 자신감

### 🔥 디자인 패턴에 대한 고민

- MVC 패턴을 적용해 개발함
    - Model, View, Controller
- 앱의 규모가 커질수록 MVC 패턴 중 ViewController 가 너무 많은 책임을 지게 되며 규모가 너무 커지게 되는 구조임
- MVVM(Model, View, ViewModel) 패턴 적용의 필요성

## 💡 후속 공부 계획

- **UIKit → SwiftUI**
    - UIKit(명령형 UI) → SwiftUI(선언형 UI) 로의 변경
    - 최신 UI 구현의 트랜드는 선언형 UI임
    - 애플도 2019년에 SwiftUI를 발표, SwiftUI는 미래 애플의 모든 UI를 구현하게 될 것으로 보임
- **MVVM 디자인 패턴 적용**
- **RxSwift 적용 (Combine Framework)**
    - Reactive Programming: `반응형 프로그래밍` = 비동기 데이터 스트림을 이용한 프로그래밍
    - 데이터의 흐름을 먼저 정의하고, 데이터가 변경되었을 때 연관된 작업이 실행하도록 하는 방식




본 템플릿의 저작권은 (주)소프트스퀘어드에 있습니다. 무단 배포를 금합니다
