import UIKit

final class MainViewController: UIViewController {
    private let personalDataLabel = LabelView(labelText: "Персональные данные",
                                              fontSize: 17)
    private let nameTextField = TextFieldView(labelText: "Имя",
                                              keyboardType: .chars)
    private let ageTextField = TextFieldView(labelText: "Возраст",
                                             keyboardType: .numbers)
    private let childrenLabel = LabelView(labelText: "Дети (макс. 5)",
                                          fontSize: 17)
    private let addChildButton = UIButton()

    //= ButtonView(imgView: UIImageView(image: UIImage(named: "plus")),
    //                                      labelText: "Добавить ребенка")


    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setUI()
    }
}

extension MainViewController {
    private func setUI() {
        view.backgroundColor = .white

        setPersonalDataLabel()
        setNameTextField()
        setAgeTextField()
        setAddChildButton()
        //        setChildrenLabel()
    }

    private func setPersonalDataLabel() {
        view.addSubview(personalDataLabel)

        NSLayoutConstraint.activate([
            personalDataLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            personalDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    private func setNameTextField() {
        view.addSubview(nameTextField)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: personalDataLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setAgeTextField() {
        view.addSubview(ageTextField)

        NSLayoutConstraint.activate([
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ageTextField.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    /*
     private func setAddChildButton() {
     addChildButton.translatesAutoresizingMaskIntoConstraints = false
     //        addChildButton.setTitle(MainViewControllerConstant.addChildButtonText, for: .normal)
     //        addChildButton.setTitleColor(.systemBlue, for: .normal)
     //        addChildButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
     addChildButton.layer.borderWidth = 1
     addChildButton.layer.borderColor = UIColor.blue.cgColor
     //        addChildButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
     addChildButton.layer.cornerRadius = 25

     //        let plusImage = UIImage(named: "plus")
     //        plusImage.tintColor = .systemBlue
     //        plusImage.translatesAutoresizingMaskIntoConstraints = false

     //        addChildButton.setImage(plusImage, for: .normal)

     //        NSLayoutConstraint.activate([
     //            plusImage.leadingAnchor.constraint(equalTo: addChildButton.leadingAnchor, constant: 15),
     //            plusImage.centerYAnchor.constraint(equalTo: addChildButton.centerYAnchor),
     //            plusImage.widthAnchor.constraint(equalToConstant: 20),
     //            plusImage.heightAnchor.constraint(equalToConstant: 20)
     //        ])

     view.addSubview(addChildButton)

     NSLayoutConstraint.activate([
     addChildButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
     addChildButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MainViewControllerConstant.horizontalSpace),
     addChildButton.heightAnchor.constraint(equalToConstant: 50),
     addChildButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 180)

     ])
     }


     private func setAddChildButton() {
     addChildButton.translatesAutoresizingMaskIntoConstraints = false
     addChildButton.layer.borderWidth = 1
     addChildButton.layer.cornerRadius = 25
     //        addChildButton.setTitle("Добавить ребенка", for: .normal)
     //        addChildButton.setImage(UIImage(named: "plus"), for: .normal)


     let imageAttach =  NSTextAttachment()
     imageAttach.image = UIImage(named: "plus")
     imageAttach.bounds = CGRect(x: 0, y: -5,
     width: 100,
     height: 50)
     let stringAttach = NSAttributedString(attachment: imageAttach)
     let completeTitle = NSMutableAttributedString(string: "Добавить ребенка")
     completeTitle.insert(stringAttach, at: 1)
     addChildButton.setAttributedTitle(completeTitle, for: .normal)

     view.addSubview(addChildButton)

     NSLayoutConstraint.activate([
     addChildButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
     addChildButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MainViewControllerConstant.horizontalSpace),
     addChildButton.heightAnchor.constraint(equalToConstant: 50),
     addChildButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 180)

     ])
     }
     */
    func setAddChildButton() {
        let button = UIButton(type: .system)
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)

        // Устанавливаем изображение слева от текста
        let image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.systemBlue
        button.semanticContentAttribute = .forceLeftToRight

        // Настраиваем отступы текста и изображения
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)

        // Стилизация кнопки
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        // Устанавливаем ограничения для центрирования кнопки
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setChildrenLabel() {
        view.addSubview(childrenLabel)

        NSLayoutConstraint.activate([
            childrenLabel.centerYAnchor.constraint(equalTo: addChildButton.centerYAnchor),
            childrenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}

