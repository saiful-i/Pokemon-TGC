//
//  DetailCardViewController.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 18/02/23.
//

import UIKit

class DetailCardViewController: BaseViewController<DetailCardViewModel> {
    lazy var scrollView = UIScrollView()
    lazy var imageView = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var hpAndTypesLabel = UILabel()
    lazy var superTypeAndSubTypeLabel = UILabel()
    lazy var flavorTitleLabel = UILabel()
    lazy var flavorDescriptionLabel = UILabel()
    lazy var otherCardLabel = UILabel()
    lazy var collectionViewLayput = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayput)
    
    let imageLoader = ImageLoader.shared
    var id = ""
    var otherCardId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bringLoadingViewsToFront()
        viewModel?.getDetailCard(id: id)
        viewModel?.getOtherCards(id: otherCardId)
    }
    
    override func registerObserver() {
        super.registerObserver()
        
        viewModel?.card.driver.throttle(.microseconds(500), latest: true).drive(onNext: { [weak self] card in
            guard let self = self, let card = card else {
                return
            }
            
            self.bindData(card: card)
        }).disposed(by: disposeBag)
        
        viewModel?.otherCards.driver.throttle(.microseconds(500), latest: true).drive(onNext: { [weak self] otherCard in
            guard let self = self else {
                return
            }
            
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension DetailCardViewController {
    private func setupView() {
        setupScrollView()
        setupImageView()
        setupNameLabel()
        setupHpAndTypesLabel()
        setupSuperTypeAndSubTypeLabel()
        setupFlavorTitleLabel()
        setupFlavorDescriptionLabel()
        setupOtherCardLabel()
        setupCollectionView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width / 3),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.width / 3 * 1.4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNameLabel() {
        scrollView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupHpAndTypesLabel() {
        scrollView.addSubview(hpAndTypesLabel)
        hpAndTypesLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hpAndTypesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            hpAndTypesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            hpAndTypesLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupSuperTypeAndSubTypeLabel() {
        scrollView.addSubview(superTypeAndSubTypeLabel)
        superTypeAndSubTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            superTypeAndSubTypeLabel.leadingAnchor.constraint(equalTo: hpAndTypesLabel.leadingAnchor),
            superTypeAndSubTypeLabel.topAnchor.constraint(equalTo: hpAndTypesLabel.bottomAnchor, constant: 2),
            superTypeAndSubTypeLabel.trailingAnchor.constraint(equalTo: hpAndTypesLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFlavorTitleLabel() {
        scrollView.addSubview(flavorTitleLabel)
        flavorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            flavorTitleLabel.leadingAnchor.constraint(equalTo: superTypeAndSubTypeLabel.leadingAnchor),
            flavorTitleLabel.topAnchor.constraint(equalTo: superTypeAndSubTypeLabel.bottomAnchor, constant: 8),
            flavorTitleLabel.trailingAnchor.constraint(equalTo: superTypeAndSubTypeLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFlavorDescriptionLabel() {
        scrollView.addSubview(flavorDescriptionLabel)
        flavorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            flavorDescriptionLabel.leadingAnchor.constraint(equalTo: flavorTitleLabel.leadingAnchor),
            flavorDescriptionLabel.topAnchor.constraint(equalTo: flavorTitleLabel.bottomAnchor, constant: 8),
            flavorDescriptionLabel.trailingAnchor.constraint(equalTo: flavorTitleLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupOtherCardLabel() {
        scrollView.addSubview(otherCardLabel)
        otherCardLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            otherCardLabel.leadingAnchor.constraint(equalTo: flavorDescriptionLabel.leadingAnchor),
            otherCardLabel.topAnchor.constraint(equalTo: flavorDescriptionLabel.bottomAnchor, constant: 8),
            otherCardLabel.trailingAnchor.constraint(equalTo: flavorDescriptionLabel.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCollectionView() {
        scrollView.addSubview(collectionView)
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        collectionViewLayput.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionViewLayput.minimumInteritemSpacing = 8
        collectionViewLayput.minimumLineSpacing = 8
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: otherCardLabel.bottomAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func bindData(card: CardModel) {
        imageLoader.attachImage(url: card.images?.small ?? "", into: imageView)
        nameLabel.applyStyle(stringText: card.name ?? "", fontName: .medium, size: 16, lines: 1)
        let typesString: String = card.types?.joined(separator: ", ") ?? ""
        
        hpAndTypesLabel.applyStyle(stringText: "\(typesString) (\(card.hp ?? ""))", fontName: .regular, size: 12, lines: 0)
        
        let subtypeString: String = card.subtypes?.joined(separator: ", ") ?? ""
        superTypeAndSubTypeLabel.applyStyle(stringText: "\(subtypeString) - \(subtypeString)", fontName: .regular, size: 12, lines: 0)
        flavorTitleLabel.applyStyle(stringText: "Flavor:", fontName: .medium, size: 16, lines: 1)
        flavorDescriptionLabel.applyStyle(stringText: card.flavorText ?? "-", fontName: .regular, size: 12, lines: 0)
        otherCardLabel.applyStyle(stringText: "Other Cards", fontName: .medium, size: 16, lines: 1)
        
    
    }
    
    private func openDetailCard(id: String, otherCardId: String) {
        let controller = DetailCardViewController()
        controller.id = id
        controller.otherCardId = otherCardId
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func onImageTapped() {
        let controller = DetailPhotoViewController()
        controller.url = viewModel?.card.value()?.images?.large ?? ""
        present(controller, animated: true)
    }
}

extension DetailCardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.otherCards.value().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.imageUrl = viewModel?.otherCards.value()[indexPath.row].images?.small
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel?.otherCards.value()[indexPath.row].id,
              let otherCardId = viewModel?.otherCards.value()[indexPath.row].setModel?.id  else {
            return
        }

        openDetailCard(id: id, otherCardId: otherCardId)
    }
}

extension DetailCardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width) / 3 - 16
        
        return CGSize(width: width, height: width * 1.4)
    }
}
