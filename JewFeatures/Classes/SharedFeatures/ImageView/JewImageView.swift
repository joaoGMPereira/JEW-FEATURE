//
//  JewImageView.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 22/04/20.
//

import Foundation
import UIKit

public class JEWImageView: UIView {
    public typealias HasSelectedButton = ((UIButton) -> Void)
    public typealias HasSelectedImage = ((UIImage) -> Void)
    public var hasSelectedButtonCallback: HasSelectedButton?
    public var hasSelectedImageCallback: HasSelectedImage?
    public var imageButton = UIButton(frame: .zero)
    
    private var size = CGSize(width: 150, height: 150)
    private var autoSetupImage = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public func setup(with size: CGSize, cornerRadius: CGFloat = 8, autoSetupImage: Bool = true) {
        self.size = size
        self.autoSetupImage = autoSetupImage
        setupChallengeImage()
        setupView()
    }
    
    func setupChallengeImage() {
        imageButton.setImage(UIImage(named: "edit", in: JEWSession.bundle, compatibleWith: nil), for: .normal)
        imageButton.tintColor = .JEWDarkDefault()
        imageButton.addTarget(self, action: #selector(changeImage(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeImage(_ sender: Any) {
        self.imageButton.layer.animate()
        if let hasSelectedButtonCallback = hasSelectedButtonCallback {
            hasSelectedButtonCallback(imageButton)
        }
    }
    
    //Show alert
    public func showSelectImage(inViewController viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(inViewController: viewController, fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Album de Fotos", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(inViewController: viewController, fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))

        alert.view.tintColor = .JEWDefault()

        if let subview = (alert.view.subviews.first?.subviews.first?.subviews.first) {
             subview.backgroundColor = .JEWBackground()
        }

        viewController.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    public func getImage(inViewController viewController: UIViewController, fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
}

extension JEWImageView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            if autoSetupImage {
                imageButton.setImage(image, for: .normal)
            }
            imageButton.imageView?.clipsToBounds = false
            if let hasSelectedImageCallback = hasSelectedImageCallback {
                hasSelectedImageCallback(image)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension JEWImageView: JEWCodeView {
    public func buildViewHierarchy() {
        addSubview(imageButton)
        translatesAutoresizingMaskIntoConstraints = false
        imageButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            imageButton.widthAnchor.constraint(equalToConstant: size.width),
            imageButton.heightAnchor.constraint(equalToConstant: size.height),
            imageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        imageButton.backgroundColor = .clear
        imageButton.roundAllCorners(borderColor: .JEWDarkDefault(), cornerRadius: 8)
    }
    
    public func setupAdditionalConfiguration() {
        
    }
}
