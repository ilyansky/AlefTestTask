import UIKit

enum TextFieldViewSize {
    static let horizontalSpace: CGFloat = 15
    static let verticalSpace: CGFloat = 10
}

final class TextFieldView: UIView, UITextFieldDelegate {
    enum KeyboardType {
        case chars
        case numbers
    }

    let labelText: String
    let keyboardType: KeyboardType
    private let label = UILabel()
    private let textField = UITextField()

    init(labelText: String,
         keyboardType: KeyboardType,
         frame: CGRect = .zero) {
        self.labelText = labelText
        self.keyboardType = keyboardType
        super.init(frame: frame)
        textField.delegate = self
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

        if keyboardType == .numbers && (newText.hasPrefix("0") || newText.contains(",")) {
            return false
        }

        return true
    }
}

extension TextFieldView {
    private func setUI() {
        self.translatesAutoresizingMaskIntoConstraints = false

        setView()
        setLabel()
        setTextField()
    }

    private func setView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorPack.gray5
        self.layer.cornerRadius = 5
    }

    private func setLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = ColorPack.gray

        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: TextFieldViewSize.verticalSpace),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: TextFieldViewSize.horizontalSpace)
        ])
    }

    private func setTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false

        if keyboardType == .numbers {
            textField.keyboardType = .decimalPad
        }

        self.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                              constant: -TextFieldViewSize.verticalSpace),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                               constant: TextFieldViewSize.horizontalSpace),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                constant: -TextFieldViewSize.horizontalSpace)
        ])
    }
}
