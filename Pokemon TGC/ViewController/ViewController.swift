//
//  ViewController.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import UIKit

class ViewController: BaseViewController<ViewModel> {
    
    lazy var collectionViewLayput = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayput)
    lazy var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupCollectionView()
        bringLoadingViewsToFront()
        viewModel?.getCards()
    }
    
    override func registerObserver() {
        super.registerObserver()
        
        viewModel?.cards.driver.throttle(.microseconds(500), latest: true).drive(onNext: { [weak self] cards in
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
        textField.returnKeyType = .done
        textField.textContentType = .name
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingChanged)
        textField.delegate = self
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 36)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCollectionView() {
        collectionView.registerCell(withClass: CardCollectionViewCell.self)
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        collectionView.backgroundColor = .white
        collectionViewLayput.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionViewLayput.minimumInteritemSpacing = 8
        collectionViewLayput.minimumLineSpacing = 8
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
    
    private func openDetailCard(id: String, otherCardId: String) {
        let controller = DetailCardViewController()
        controller.id = id
        controller.otherCardId = otherCardId
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        guard let viewModel = viewModel,
              let name = textField.text else {
                  return
              }
        viewModel.getCards(name: name)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.cards.value()?.count).ifNil(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: CardCollectionViewCell.self, for: indexPath)
        cell.imageUrl = viewModel?.cards.value()?[indexPath.row].images?.small
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel?.cards.value()?[indexPath.row].id,
              let otherCardId = viewModel?.cards.value()?[indexPath.row].setModel?.id else {
            return
        }
        
        openDetailCard(id: id, otherCardId: otherCardId)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height && !(viewModel?.isLoading.value()).ifNil(true) {
            viewModel?.loadMore()
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
