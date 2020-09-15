//
//  CardEditVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardEditVC: UIViewController {
     let headers = ["userToken":UserToken.shared.userToken]
    //private var taskData = TaskModel()
    private var funtionType:TaskModel.FuntionType?
    private var cardID:Int = 0
    private var taskID:Int?
    private var color:ColorsButtonType = .red {
        didSet{
            refreshColor(color: color)
        }
    }
    private let cardEditView = CardEditView()
    override func loadView() {
        super.loadView()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print(#function)
        switch funtionType {
        case .create:
            print("create")
            createTask()
        case .edit:
            print("save")
            saveTask()
        case .delete:
            print("delete")
            break
        case .none:
            break
        }
    }
    private func refreshColor(color:ColorsButtonType){
        self.cardEditView.refreshColor(color: color)
        self.cardEditView.colorsCollectionView.delegate = self
        self.cardEditView.scrollView.delegate = self
        self.cardEditView.textView.delegate = self
        self.cardEditView.colorsCollectionView.reloadData()
        self.view = cardEditView
    }
    func setData(data:TaskModel){
        let viewData:TaskModel = {
            var viewData = TaskModel()
            switch data.funtionType {
            case .create:
                self.color = .red
                self.funtionType = .create
                viewData.description = "Please input"
                viewData.image = UIImage(systemName: "photo")!
                viewData.title = "Please input Title"
            case .edit:
                self.color = data.tag!
                self.funtionType = .edit
                viewData.description = data.description
                viewData.image = data.image
                viewData.title = data.title
            case .none:
                break
            case .delete:
                break
            }
            self.cardID = data.cardID!
            self.taskID = data.taskID
            viewData.funtionType = data.funtionType
            return viewData
        }()
        
        self.cardEditView.colorsCollectionView.delegate = self
        self.cardEditView.scrollView.delegate = self
        self.cardEditView.textView.delegate = self
        self.cardEditView.colorsCollectionView.reloadData()
        self.cardEditView.setUserData(data: viewData)
        self.view = cardEditView
    }
    

    #warning("標記一下")
    private func saveTask(){
        let parameters = TaskModelManerger.makeParameters(cardID,self.color,self.cardEditView)
        TaskModelManerger.edit(parameters,taskID!)
    }
    private func createTask(){
        let parameters = TaskModelManerger.makeParameters(cardID,self.color,self.cardEditView)
        TaskModelManerger.create(parameters)
    }
    @objc func deleteTask(){
        self.funtionType = .delete
        TaskModelManerger.delete(taskID!)
        dismiss(animated: true, completion: nil)
    }
    @objc func takeImage() {
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        present(photoController, animated: true, completion: nil)
    }

    
}
extension CardEditVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorType = ColorsButtonType.allCases[indexPath.row]
        self.color = colorType
    }
}
extension CardEditVC:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
extension CardEditVC:UITextViewDelegate{
    func textViewDidChange(_ textView:UITextView) {
        
        resetHight(textView)
        
    }
    func resetHight(_ textView:UITextView){
        let maxHeight:CGFloat = ScreenSize.height.value * 0.4
        let frame = textView.frame
        let constrainSize=CGSize(width:frame.size.width,height:CGFloat(MAXFLOAT))
        var size = textView.sizeThatFits(constrainSize)
        if size.height >= maxHeight{
            size.height = maxHeight
            textView.isScrollEnabled=true
        }else{
            textView.isScrollEnabled=false
        }
        textView.frame.size.height=size.height
    }
}
extension CardEditVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            cardEditView.imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
