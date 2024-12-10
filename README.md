# PDFImageProcessor

PDFImageProcessorは、PDFファイルの各ページを画像データに変換するためのSwiftクラスです。

## 使用例

```swift
let processor = PDFImageProcessor()
let url = PDFファイルのURLを取得
let images = processor.exportPagesFromPDF(url: url)
```

## メソッド

### `exportPagesFromPDF(url: URL) -> [Data]`

PDFの各ページを画像データに変換して返します。

- **パラメータ**
    - `url`: PDFファイルのURL
- **戻り値**
    - 画像データの配列

### `convertUIImageToData(_ uiImage: UIImage, compressionQuality: CGFloat) -> Data?`

UIImageをJPEG形式のDataに変換します。

- **パラメータ**
    - `uiImage`: 変換対象のUIImage
    - `compressionQuality`: 圧縮率（0.0〜1.0）
- **戻り値**
    - JPEG形式の画像データ

### `getFilePathURL(fileName: String) -> URL?`

一時保存しているファイルのURLを、ファイル名で検索する関数です。

- **パラメータ**
    - `fileName`: 検索するファイル名
- **戻り値**
    - ファイルのURL

## ライセンス

このプロジェクトはMITライセンスのもとで公開されています。詳細はLICENSEファイルを参照してください。