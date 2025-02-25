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
    private let addChildButton = UIButton(type: .system)

    private let childrenTableView = UITableView()

    private var childrenCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        childrenTableView.register(CellView.self, forCellReuseIdentifier: CellView.cellViewID)
        setUI()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = childrenTableView.dequeueReusableCell(withIdentifier: CellView.cellViewID, for: indexPath) as! CellView

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }

}

extension MainViewController {
    @objc private func incrementChild() {
        guard childrenCount < 5 else { return }

        let newIndexPath = IndexPath(row: childrenCount, section: 0)
        childrenCount += 1

        childrenTableView.beginUpdates()
        childrenTableView.insertRows(at: [newIndexPath], with: .fade)
        childrenTableView.endUpdates()

        childrenTableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
    }
}

extension MainViewController {
    private func setUI() {
        view.backgroundColor = .white

        setPersonalDataLabel()
        setNameTextField()
        setAgeTextField()
        setAddChildButton()
        setChildrenLabel()
        setChildrenTableView()
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

    private func setAddChildButton() {
        addChildButton.setTitle("Добавить ребенка", for: .normal)
        addChildButton.setTitleColor(UIColor.systemBlue, for: .normal)

        let image = UIImage(systemName: "plus")
        addChildButton.setImage(image, for: .normal)
        addChildButton.tintColor = UIColor.systemBlue

        addChildButton.layer.cornerRadius = 25
        addChildButton.layer.borderWidth = 2
        addChildButton.layer.borderColor = UIColor.systemBlue.cgColor
        addChildButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        addChildButton.translatesAutoresizingMaskIntoConstraints = false
        addChildButton.addTarget(self, action: #selector(incrementChild), for: .touchUpInside)
        view.addSubview(addChildButton)

        NSLayoutConstraint.activate([
            addChildButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addChildButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 10),
            addChildButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setChildrenLabel() {
        view.addSubview(childrenLabel)

        NSLayoutConstraint.activate([
            childrenLabel.centerYAnchor.constraint(equalTo: addChildButton.centerYAnchor),
            childrenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    private func setChildrenTableView() {
        childrenTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childrenTableView)

        NSLayoutConstraint.activate([
            childrenTableView.topAnchor.constraint(equalTo: addChildButton.bottomAnchor, constant: 10),
            childrenTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            childrenTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            childrenTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

