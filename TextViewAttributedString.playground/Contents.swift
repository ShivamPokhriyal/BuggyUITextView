import UIKit
import PlaygroundSupport

extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(
                data: self,
                options: [
                    NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html,
                    NSAttributedString.DocumentReadingOptionKey.characterEncoding:
                        String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            print(error)
        }
        return nil
    }
}

class Demo: UIView {

    public static let font = UIFont.systemFont(ofSize: 14)

    //    private let messageLabel: UILabel = {
    //        let label = UILabel(frame: .zero)
    //        label.isUserInteractionEnabled = true
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        label.numberOfLines = 0
    //        label.lineBreakMode = .byWordWrapping
    //        label.font = Demo.font
    //        return label
    //    }()

    let messageLabel: UITextView = {
        let label = UITextView(frame: .zero)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Demo.font
        label.backgroundColor = .clear
        label.textContainerInset = .zero
        label.textContainer.lineFragmentPadding = 0
        label.isScrollEnabled = false
        label.isSelectable = true
        label.isEditable = false
        label.dataDetectorTypes = .all
        label.linkTextAttributes = [.foregroundColor: UIColor.blue,
                                    .underlineStyle: NSUnderlineStyle.single.rawValue]
        label.isScrollEnabled = false
        label.delaysContentTouches = false
        return label
    }()

    let paragraphStyle: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle.init()
        style.lineBreakMode = .byWordWrapping
        style.headIndent = 0
        style.tailIndent = 0
        style.firstLineHeadIndent = 0
        style.minimumLineHeight = 17
        style.maximumLineHeight = 17
        return style
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAttributedText(_ text: String) {
        let attributes: [NSAttributedString.Key : Any] = [.paragraphStyle: paragraphStyle]
        let htmlText = text.data(using: .utf8, allowLossyConversion: false)!.attributedString!
        let mutableText = NSMutableAttributedString(attributedString: htmlText)
        mutableText.addAttributes(attributes, range: NSMakeRange(0, mutableText.length))
        messageLabel.attributedText = mutableText
    }

    func updateSize(with width: CGFloat) {
        let size = messageLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        self.frame = CGRect(x: 0, y: 0, width: width, height: size.height.rounded(.up))
        self.layoutIfNeeded()
    }

    private func setupConstraints() {
        self.backgroundColor = UIColor.lightGray
        self.addSubview(messageLabel)
        self.bringSubviewToFront(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }

}

let attt = "<html> <head><h1>hello</h1> </head> <body><h2> hello </h2> <br> <h3> hello </h3> <br> <p><h4> hello </h4><br> <h5> hello </h5></p><br> <h6> hello </h6></body></html><h2 style=background-color: #FC9CF9;>I am using a color name to assign a color to this background and text</h2><h2 style=background-color: steelblue; color: lightcyan;>I am using a color name to assign a color to this background and text</h2><br><h2 style=background-color: brown; color: bisque;>I am using a color name to assign a color to this background and text</h2>"

let width: CGFloat = 237

let buggyView = Demo(frame: .zero)
buggyView.setAttributedText(attt)
buggyView.updateSize(with: width)

PlaygroundPage.current.liveView = buggyView
