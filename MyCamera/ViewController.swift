//
//  ViewController.swift
//  MyCamera
//
//  Created by Jun on 2021/09/12.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        //カメラかフォトライブラリーどちらから画像を取得するかを選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action) in
                //カメラを起動
                let imagePikckerController = UIImagePickerController()
                imagePikckerController.sourceType = .camera
                imagePikckerController.delegate = self
                self.present(imagePikckerController, animated: true, completion: nil)
        })
        alertController.addAction(cameraAction)
    }
       
       //フォトライブラリーが利用可能かチェック
       if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
          //フォトライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: {(action) in
             //フォトライブラリーを起動
               let imagePikckerController = UIImagePickerController()
               imagePikckerController.sourceType = .photoLibrary
               imagePikckerController.delegate = self
               self.present(imagePikckerController, animated: true, completion: nil)
        })
        alertController.addAction(photoLibraryAction)
    }
        
        //キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        
        //選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        if let shareImage = pictureImage.image {
            //UIActivityViewControllerにシェア画像を渡す
            let shareItems = [shareImage]
            //UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            //iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            //UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
        
        }
    //(1)撮影が終わった時に呼ばれるdelegateメソッド
    func  imagePickerController(_ picker:UIImagePickerController , didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //(2)撮影した画像を配置したcaptureImageに渡す
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //(3)モーダルビューを閉じる
        dismiss(animated: true, completion: {
            //(4)エフェクト画像に遷移
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    //次の画面に遷移するときに渡す画像を格納する場所
    var captureImage:UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? EffectViewController {
            //次の画面のインスタンスに取得した画像を渡す
            nextViewController.originalImage = captureImage
        }
    }
}

