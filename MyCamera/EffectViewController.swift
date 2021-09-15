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
    
    //フィルタ名を列挙した配列（Array)
    //0.モノクロ
    //1.Chrome
    //2.Fade
    //3.Instant
    //4.Noir
    //5.Process
    //6.Tonal
    //7.Transfer
    //8.Sepia Tone
    
  
    //選択中のエフェクト添字
    var filterSelectNumber = 0
    
    @IBOutlet weak var effectImage: UIImageView!
    
    let filterArray = ["CIPhotoEffectMono",
                         "CIPhotoEffectChrome",
                         "CIPhotoEffectFade",
                         "CIPhotoEffectInstant",
                         "CIPhotoEffectNoir",
                         "CIPhotoEffectProcess",
                         "CIPhotoEffectTonal",
                         "CIPhotoEffectTransfer",
                         "CIPhotoEffectSepia Tone",
      ]
    
    @IBAction func effectButtonAction(_ sender: Any) {
        
    //エフェクト前画像をアンラップしてエフェクト用画像として取り出す
        if let image = originalImage {
            //フィルター名を指定
            let filterName = filterArray[filterSelectNumber]
            //次に選択するエフェクト添字に更新
            filterSelectNumber += 1
            //添字が配列の数と同じかをチェック
            if filterSelectNumber == filterArray.count {
                //同じ場合は最後まで選択されたので先頭に戻す
                filterSelectNumber = 0
            }
            //元々の画像の回転角度を取得
            let rotate = image.imageOrientation
            //UIImage形式の画像をCIImage形式に変換
            let inputImage = CIImage(image: image)
            //フィルターの種別を引数で指定された種類を指定してCIFilterのインスタンスを取得
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            
            //エフェクトのパラメータを初期化
            effectFilter.setDefaults()
            //インスタンスにエフェクトする元画像を指定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            //エフェクト後のCIImage形式の画像を取り出す
            guard let outputImage = effectFilter.outputImage else{
                return
            }
            //CIContextのインスタンスを取得
            let ciContext = CIContext(options: nil)
            //エフェクト後の画像をCIContext上に描画し、結果をcgImageとしてCGImage形式の画像を取得
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            //エフェクト後の画像をCGImage形式からUIImage形式に変更。その後に回転角度を指定。そしてImageViewに表示
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
           
            }
         }
    @IBAction func shareButtonAction(_ sender: Any) {
        //表示画像をアンラップしてシェア画像を取り出す
        if let shareImage = effectImage.image?.resize() {
            //UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            //UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            //iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            //UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        //画面を閉じて前の画像に戻る
        dismiss(animated: true, completion: nil)
    }
  }
