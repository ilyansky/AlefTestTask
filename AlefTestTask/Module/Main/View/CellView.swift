import UIKit

final class CellView: UITableViewCell {
    static let cellViewID = "cellViewID"
    private let nameTextField = TextFieldView(labelText: "Имя",
                                              keyboardType: .chars)
    private let ageTextField = TextFieldView(labelText: "Возраст",
                                             keyboardType: .numbers)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

extension CellView {
    private func setUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setNameTextField()
        setAgeTextField()
    }

    private func setNameTextField() {
        addSubview(nameTextField)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.widthAnchor.constraint(equalTo: widthAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setAgeTextField() {
        addSubview(ageTextField)

        NSLayoutConstraint.activate([
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            ageTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            ageTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: 100),
            ageTextField.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
