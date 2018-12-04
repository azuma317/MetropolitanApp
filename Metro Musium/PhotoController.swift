//
//  PhotoController.swift
//  Metro Musium
//
//  Created by Azuma on 2018/11/20.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    var imagePath: String?

    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden ?? false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.maximumZoomScale = 8.0
        scrollView.minimumZoomScale = 1.0
        guard let imagePath = imagePath else { return }
        imageView.kf.setImage(with: URL(string: imagePath))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.hidesBarsOnTap = false
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
