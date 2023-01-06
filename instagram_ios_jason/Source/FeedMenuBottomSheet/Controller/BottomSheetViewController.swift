//
//  BottomSheetViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/06.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    var feedType: ProfileType!
    var menuData: [FeedMenuModel] = []
    var firstSectionData: [FeedMenuModel] = []
    var secondSectionData: [FeedMenuModel] = []
    // MARK: - Properties
    // 바텀 시트 높이
    var bottomHeight: CGFloat = 359
    var backgroundColor: UIColor = .systemBackground
    var defaultSpacing: CGFloat = 10
    var widthSpacing: CGFloat = 25
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    // 기존 화면을 흐려지게 만들기 위한 뷰
    private let dimmedBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
    
    // 바텀 시트 뷰
    var sheetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        return view
    }()
    
    // dismiss Indicator View UI 구성 부분
    private let dismissIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    // MARK: - Buttons
    var shareButton: CustomMenuButton = {
        let button = CustomMenuButton(image: UIImage(systemName: "square.and.arrow.up"), title: "공유")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var linkButton: CustomMenuButton = {
        let button = CustomMenuButton(image: UIImage(systemName: "link"), title: "링크")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var saveButton: CustomMenuButton = {
        let button = CustomMenuButton(image: UIImage(systemName: "bookmark"), title: "저장")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var qrButton: CustomMenuButton = {
        let button = CustomMenuButton(image: UIImage(systemName: "qrcode"), title: "QR 코드")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = defaultSpacing
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    // MARK: - 테이블 뷰
    var menuTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        setupButtons()
        setupGestureRecognizer()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }

    private func setupData() {
        if feedType == .myProfile {
            menuData = FeedMenuData.getMyMenuData()
        } else {
            menuData = FeedMenuData.getOtherMenuData()
        }
        
        let datas = FeedMenuData.getOtherMenuData()
        
        firstSectionData = datas.filter({ model in
            model.section == 0
        })
        secondSectionData = datas.filter({ model in
            model.section == 1
        })
        print("🔥🔥🔥FIRSTSECTION")
        dump(firstSectionData)
        print("🔥🔥🔥SECONDSECTION")
        dump(secondSectionData)
        
    }
    
    // MARK: - @Functions
    // UI 세팅 작업
    private func setupUI() {
        
        view.addSubview(dimmedBackView)
        view.addSubview(sheetView)
        view.addSubview(dismissIndicatorView)
        view.addSubview(menuTableView)
        
        dimmedBackView.alpha = 0.0
        setupLayout()
    }
    
    private func setupButtons() {
        sheetView.addSubview(buttonStack)
        _ = [shareButton, linkButton, saveButton, qrButton].map({
            buttonStack.addArrangedSubview($0)
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        })
        let inset = widthSpacing * 2 + defaultSpacing * 3
        let stackHeight = (self.view.frame.width - inset) / 4
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: widthSpacing),
            buttonStack.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -widthSpacing),
            buttonStack.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 50),
            buttonStack.heightAnchor.constraint(equalToConstant: stackHeight)
        ])
    }
    
    private func setupTableView() {
        let inset: CGFloat = 5
        NSLayoutConstraint.activate([
            menuTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            menuTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            menuTableView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: -10),
            menuTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        menuTableView.register(FeedMenuCell.self, forCellReuseIdentifier: "FeedMenuCell")
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.rowHeight = 55
        menuTableView.backgroundColor = .clear
        menuTableView.isScrollEnabled = false
        menuTableView.tableFooterView = UIView(frame: .zero)
        menuTableView.sectionFooterHeight = 5
        menuTableView.tableHeaderView = UIView(frame: .zero)
        menuTableView.sectionHeaderHeight = 5
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    // 레이아웃 세팅
    private func setupLayout() {
        dimmedBackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedBackView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = sheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint
        ])
        
        dismissIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissIndicatorView.widthAnchor.constraint(equalToConstant: 102),
            dismissIndicatorView.heightAnchor.constraint(equalToConstant: 7),
            dismissIndicatorView.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 12),
            dismissIndicatorView.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor)
        ])
        
    }
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
}

extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if feedType == .myProfile {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return firstSectionData.count
        case 1:
            return secondSectionData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedMenuCell", for: indexPath) as? FeedMenuCell else { return UITableViewCell() }
        
        if feedType == .myProfile {
            cell.menu = firstSectionData[indexPath.row]
        } else {
            switch indexPath.section {
            case 0:
                cell.menu = firstSectionData[indexPath.row]
            case 1:
                cell.menu = secondSectionData[indexPath.row]
            default:
                print("뭔가 잘못됨")
            }
        }
        cell.configure()
        return cell
    }
}
