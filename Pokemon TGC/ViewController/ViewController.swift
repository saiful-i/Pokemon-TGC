//
//  ViewController.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import UIKit

class ViewController: BaseViewController {
    
    lazy var collectionViewLayput = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayput)
    lazy var textField = UITextField()
    
    private let viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextField()
        setupCollectionView()
        viewModel.getCards()
    }
    
    
    override func registerObserver() {
        super.registerObserver()
        
        viewModel.cards.driver.throttle(.microseconds(500), latest: true).drive(onNext: { [weak self] cards in
            guard let self = self else {
                return
            }
            
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension ViewController {
    private func setupTextField() {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.placeholder = "Search Pokemon"
        textField.delegate = self
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 36)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCollectionView() {
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        collectionViewLayput.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionViewLayput.minimumInteritemSpacing = 8
        collectionViewLayput.minimumLineSpacing = 8
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cards.value().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.imageUrl = viewModel.cards.value()[indexPath.row].images.small
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX >= (scrollView.contentSize.width - scrollView.bounds.width) - 20 /* Needed offset */ {
            guard !viewModel.isLoading.value() else { return }
            viewModel.loadMore()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width) / 3 - 16
        
        return CGSize(width: width, height: width * 1.4)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") + string
        viewModel.getCards(name: text)
        return true
    }
}
