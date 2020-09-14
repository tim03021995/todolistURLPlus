//
//  CardEditVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardEditVC: UIViewController {
    private var taskData = TaskModel(){
        didSet{
            refreshView(data: taskData)
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
        switch taskData.funtionType {
        case .create:
            createTask()
        case .edit:
            saveTask()
        case .none:
            break
        }
    }
    private func refreshView(data:TaskModel){
        self.cardEditView.setUserData(
            funtionType: taskData.funtionType ?? TaskModel.FuntionType.create,
            image: data.image ?? UIImage(systemName: "photo")!,
            title: data.title ?? "Please input Title",
            script: data.description ?? "Unknow",
            color: data.tag ?? ColorsButtonType.red)
        self.cardEditView.colorsCollectionView.delegate = self
        self.cardEditView.scrollView.delegate = self
        self.cardEditView.textView.delegate = self
        self.cardEditView.colorsCollectionView.reloadData()
        self.view = cardEditView
    }
    func setData(data:TaskModel){
        self.taskData.cardID = data.cardID
        self.taskData.taskID = data.taskID
        self.taskData.description = data.description
        self.taskData.image = data.image
        self.taskData.tag = data.tag
        self.taskData.title = data.title
        self.taskData.funtionType = data.funtionType
    }
    #warning("標記一下")
    private func saveTask(){
        guard let cardID = taskData.cardID else {return}
        let headers = ["userToken":UserToken.shared.userToken]
        let parameters = [
            "title" : taskData.title ?? "",
            "card_id" : cardID,
            "tag" : taskData.tag ?? ColorsButtonType.red,
            "description" : taskData.description ?? "",
            ] as [String : Any]
        let request = HTTPRequest(endpoint: .task, method: .PUT, parameters: parameters, headers: headers, id: taskData.taskID)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<PostTaskResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("edit success")
                print(a)
            case .failure(let err):
                print(err)
            }
        }
    }
    private func createTask(){
        guard let cardID = taskData.cardID else {return}
        let headers = ["userToken":UserToken.shared.userToken]
        let parameters = [
            "title" : taskData.title ?? "",
            "card_id" : cardID,
            "tag" : taskData.tag ?? ColorsButtonType.red,
            "description" : taskData.description ?? "",
            ] as [String : Any]
        let request = HTTPRequest(endpoint: .task, method: .POST, parameters: parameters , headers: headers)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<PostTaskResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("create success")
                print(a)
            case .failure(let err):
                print(err)
            }
        }
    }
    @objc func takeImage() {
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        present(photoController, animated: true, completion: nil)
    }
    @objc func deleteTask(){
        dismiss(animated: true, completion: nil)
    }
    
}
extension CardEditVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorType = ColorsButtonType.allCases[indexPath.row]
        self.taskData.tag = colorType
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
            taskData.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
