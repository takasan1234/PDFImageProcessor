import Foundation
import PDFKit
import UIKit


/// PDFImageProcessorの使用例
/// ```
/// let processor = PDFImageProcessor()
/// let url = PDFファイルのURLを取得
/// let images = processor.exportPagesFromPDF(url: url)
/// ```

class PDFImageProcessor {
    
    /// PDFの各ページを画像データに変換して返す
    /// - Parameter url: PDFファイルのURL
    /// - Returns: 画像データの配列
    private func exportPagesFromPDF(url: URL) -> [Data] {
        guard let document = CGPDFDocument(url as CFURL) else {
            print("Failed to open PDF document.")
            return []
        }
        
        let pageCount = document.numberOfPages
        var images: [Data] = []

        for pageNumber in 1...pageCount {
            guard let page = document.page(at: pageNumber) else {
                print("Failed to get page \(pageNumber).")
                continue
            }
            
            let pageRect = page.getBoxRect(.mediaBox)
            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            
            let uiImage = renderer.image { ctx in
                UIColor.white.setFill()
                ctx.fill(pageRect)
                ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                ctx.cgContext.drawPDFPage(page)
            }
            
            if let imageData = convertUIImageToData(uiImage, compressionQuality: 0.6) {
                images.append(imageData)
            } else {
                print("Failed to convert UIImage from page \(pageNumber) to Data.")
            }
        }

        return images
    }
    
    /// UIImageをJPEG形式のDataに変換
    /// - Parameters:
    ///   - uiImage: 変換対象のUIImage
    ///   - compressionQuality: 圧縮率（0.0〜1.0）
    /// - Returns: JPEG形式の画像データ
    private func convertUIImageToData(_ uiImage: UIImage, compressionQuality: CGFloat) -> Data? {
        return uiImage.jpegData(compressionQuality: compressionQuality)
    }
    
    /// "一時保存しているファイル" のURLを、ファイル名で検索する関数
    private func getFilePathURL(fileName: String) -> URL? {
        let tempDir = FileManager.default.temporaryDirectory
        return tempDir.appendingPathComponent(fileName)
    }
}
