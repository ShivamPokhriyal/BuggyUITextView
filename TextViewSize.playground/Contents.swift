import UIKit
import PlaygroundSupport

/// Quick Guide
///
/// Using String's boundingRect doesn't give correct result in UITextView
/// while the same works for UILabel.
///
/// Run this playground, and see that the actual text's height is larger than the calculated height using bounding rect.
/// Now, comment use system font instead of custom font. Run again and check now the height are same and text appears great.
/// Repeat the same process with UILabel.
/// Just uncomment the UILabel part and comment UITextView. Run with system font and custom font.
/// Size returned by boundingRect works perfectly with UILabel.



class Demo: UIView {

    public static let font = UIFont(name: "Helvetica Neue", size: 14)

//    public static let font = UIFont.systemFont(ofSize: 14)

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setText(_ attributedString: NSAttributedString) {
        messageLabel.attributedText = attributedString
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


let str = "kahsjdajsdjasdjahdjhsa jgdhsagdgagdgagdhaghdgahgdhgagdgadsaydahvdhvadvadvsavdavsdvavsdavvdvsadvsajhhshshshshshhshshsshsshhshshshsshhshshshshhshshshshhshhsahshhsahashhhsaasa22kahsjdajsdjasdjahdjhsa jgdhsagdgagdgagdhaghdgahgdhgagdgadsaydahvdhvadvadvsavdavsdvavsdavvdvsadvsajhhshshshshshhshshsshsshhshshshsshhshshshshhshshshshhshhsahshhsahashhhsaasa223"

let attributedString = NSAttributedString(string: str, attributes: [.font : Demo.font])

let width: CGFloat = 237

let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

let boundingBox = attributedString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

let height = ceil(boundingBox.height)

let buggyView = Demo(frame: CGRect(x: 0, y: 0, width: width, height: height))
buggyView.setText(attributedString)

PlaygroundPage.current.liveView = buggyView
