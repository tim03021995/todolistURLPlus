//
//  CardEditVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardEditVC: CanGetImageViewController, LoadAnimationAble {
    private var funtionType: TaskModel.FuntionType?
    private var cardID: Int = 0
    private var taskID: Int?
    private let cardEditView = CardEditView()
    
    private let photoController : UIImagePickerController = {
        let photoController = UIImagePickerController()
        photoController.sourceType = .photoLibrary
        return photoController
    }()

    override func loadView() {
        super.loadView()
        view = cardEditView
    }

    override func viewWillAppear(_: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        photoController.delegate = self
        setNC()
    }

    func setNC() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(save)
        )
    }

    @objc func save() {
        view.endEditing(true)
        switch funtionType {
        case .create:
            print("create")
            createTask()
        case .edit:
            print("save")
            editTask()
        case .delete:
            print("delete")
        case .none:
            print("none")
        }
    }

    private func refreshColor(color: ColorsButtonType) {
        cardEditView.refreshColor(color: color)
        cardEditView.colorsCollectionView.delegate = self
        cardEditView.scrollView.delegate = self
        cardEditView.textView.delegate = self
        cardEditView.colorsCollectionView.reloadData()
        //        self.view = cardEditView
    }

    func createPage(cardID: Int) {
        let viewData: TaskModel = {
            var viewData = TaskModel()

            viewData.tag = .red
            self.funtionType = .create
            viewData.description = "Please input text"
            viewData.title = ""

            self.cardID = cardID
            return viewData
        }()
        cardEditView.colorsCollectionView.delegate = self
        cardEditView.scrollView.delegate = self
        cardEditView.textView.delegate = self
        cardEditView.colorsCollectionView.reloadData()
        cardEditView.setUserData(data: viewData)
        cardEditView.textView.textColor = .white
        resetHight(cardEditView.textView)
        navigationItem.title = "Create"
        funtionType = .create
    }

    func editPage(cardID: Int, taskID: Int, title: String?, description: String?, image: String?, tag: ColorsButtonType?) {
        let viewData: TaskModel = {
            var viewData = TaskModel()
            viewData.taskID = taskID
            viewData.title = title ?? ""
            viewData.description = description ?? ""
            viewData.funtionType = .edit
            if let image = image {
                print(image)
                getImage(type: .gill, imageURL: image, completion: { image in
                    viewData.image = image
                })
            }
            viewData.tag = tag ?? ColorsButtonType.red
            return viewData
        }()
        self.taskID = taskID
        cardEditView.colorsCollectionView.delegate = self
        cardEditView.scrollView.delegate = self
        cardEditView.textView.delegate = self
        cardEditView.colorsCollectionView.reloadData()
        cardEditView.setUserData(data: viewData)
        resetHight(cardEditView.textView)
        navigationItem.title = "Edit"
        self.cardID = cardID
        funtionType = .edit
    }

    private func editTask() {
        startLoading(self)
        TaskModelManager.edit(cardID, taskID!, cardEditView, {
            self.popView()
        }) {
            self.shouldRefreshToken()
        }
    }

    private func createTask() {
        startLoading(self)
        TaskModelManager.create(cardID, cardEditView) {
            self.popView()
        }
    }

    @objc func deleteTask() {
        startLoading(self)
        TaskModelManager.delete(taskID!) {
            self.popView()
        }
    }

    @objc func takeImage() {
        startLoading(self)
        presentImageController{ [unowned self] in
            stopLoading()
        }
        
    }
    
    private func presentImageController(_ completion: (()-> Void)?){
        DispatchQueue.main.async { [unowned self] in
            present(photoController, animated: true, completion: nil)
            completion?()
        }
    }

    private func popView() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CardEditVC: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorType = ColorsButtonType.allCases[indexPath.row]
        cardEditView.refreshColor(color: colorType)
        cardEditView.colorsCollectionView.reloadData()
    }
}

extension CardEditVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_: UIScrollView) {
        view.endEditing(true)
    }
}

extension CardEditVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.white {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please input text"
            textView.textColor = UIColor.white
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        resetHight(textView)
        //     cardEditView.resetHight(cardEditView.scrollView)
    }

    func resetHight(_ textView: UITextView) {
        let maxHeight: CGFloat = ScreenSize.height.value * 0.35
        let minHeight: CGFloat = ScreenSize.height.value * 0.2
        let frame = textView.frame
        let constrainSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        var size = textView.sizeThatFits(constrainSize)
        if size.height >= maxHeight {
            size.height = maxHeight
            textView.isScrollEnabled = true
        } else if size.height < maxHeight, size.height >= minHeight {
            textView.isScrollEnabled = false
        } else {
            size.height = minHeight
            textView.isScrollEnabled = false
        }
        textView.frame.size.height = size.height
    }

    func leaveAC() {
        let ac = UIViewController.makeAlert("確定要離開？", "你已編輯此卡片，若離開資料會全部消失。") {}
        present(ac, animated: true, completion: nil)
    }
}

extension CardEditVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            let _image = UIImage(data: image.jpegData(compressionQuality: 0.05)!)
            cardEditView.setImageView(image: _image)
        }

        dismiss(animated: true, completion: nil)
    }
}
