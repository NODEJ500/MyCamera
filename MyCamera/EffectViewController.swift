//
//  EffectViewController.swift
//  MyCamera
//
//  Created by Jun on 2021/09/13.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面遷移時に元の画像を表示
        effectImage.image = originalImage
    }
    
    //エフェクト前画像
    //前の画面より画像を設定
    var originalImage:UIImage?

    @IBOutlet weak var effectImage: UIImageView!
    
    @IBAction func effectButtonAction(_ sender: Any) {
    }
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        //画面を閉じて前の画像に戻る
        dismiss(animated: true, completion: nil)
    }
}
