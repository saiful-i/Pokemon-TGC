//
//  DetailPhotoViewController.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 20/02/23.
//

import UIKit

class DetailPhotoViewController: BaseViewController<BaseViewModel> {
    lazy var scrollView = UIScrollView()
    lazy var imageView = UIImageView()
    lazy var dismissButton = UIButton(type: .close)
    
    let imageLoader = ImageLoader.shared
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupImageView()
        setupDismissButton()
    }
}

extension DetailPhotoViewController {
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.contentSize = UIScreen.main.bounds.size
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupImageView() {
        imageLoader.attachImage(url: url, into: imageView)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: view.frame.height)
        scrollView.addSubview(imageView)
    }
    
    private func setupDismissButton() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapDismissButton))
        dismissButton.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(dismissButton)
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            dismissButton.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapDismissButton() {
        dismiss(animated: true)
    }
    
    private func getX(newWidth: CGFloat) -> CGFloat {
        var x: CGFloat = 0
        if newWidth * scrollView.zoomScale > imageView.frame.width {
            x = newWidth - imageView.frame.width
        } else {
            x = scrollView.frame.width - scrollView.contentSize.width
        }
        
        return x * 0.5
    }
    
    private func getY(newHeight: CGFloat) -> CGFloat {
        var y: CGFloat = 0
        if newHeight * scrollView.zoomScale > imageView.frame.height {
            y = newHeight - imageView.frame.height
        } else {
            y = scrollView.frame.height - scrollView.contentSize.height
        }
        
        return y * 0.5
    }
}

extension DetailPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if let image = imageView.image, scrollView.zoomScale > 1 {
            let ratioW: CGFloat = imageView.frame.width / image.size.width
            let ratioH: CGFloat = imageView.frame.height / image.size.height
            var ratio: CGFloat = ratioH
            if ratioW < ratioH {
                ratio = ratioW
            }
            let newWidth: CGFloat = image.size.width * ratio
            let newHeight: CGFloat = image.size.height * ratio
            
            let x: CGFloat = getX(newWidth: newWidth)
            let y: CGFloat = getY(newHeight: newHeight)

            scrollView.contentInset = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
        } else {
            scrollView.contentInset = .zero
            scrollView.setZoomScale(1.0, animated: false)
        }
    }
}
