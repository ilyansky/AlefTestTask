import UIKit

protocol CellViewDelegate: AnyObject {
    func deleteButtonTapped(in cell: CellView)
}

final class MainViewController: UIViewController {
    private let viewModel = ViewModel()

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
    private let clearButton = UIButton(type: .system)


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Utility
extension MainViewController {
    private func clearTableView() {
        let count = viewModel.getChildrenCount()

        var indexPaths: [IndexPath] = []
        for row in 0..<count {
            indexPaths.append(IndexPath(row: row, section: 0))
        }

        viewModel.clear()

        childrenTableView.beginUpdates()
        childrenTableView.deleteRows(at: indexPaths, with: .fade)
        childrenTableView.endUpdates()
    }

    private func presonalData() {
        nameTextField.textField.text = ""
        ageTextField.textField.text = ""
    }

    private func showAddChildButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addChildButton.alpha = 1
        })
    }

    private func hideAddChildButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addChildButton.alpha = 0
        })
    }
}

// MARK: - Delegates
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    private func setTableView() {
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        childrenTableView.register(CellView.self, forCellReuseIdentifier: CellView.cellViewID)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getChildrenCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = childrenTableView.dequeueReusableCell(withIdentifier: CellView.cellViewID, for: indexPath) as! CellView
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
}

extension MainViewController: CellViewDelegate {
    func deleteButtonTapped(in cell: CellView) {
        if let indexPath = childrenTableView.indexPath(for: cell) {
            let count = viewModel.getChildrenCount()
            viewModel.decrementChildrenCount()
            childrenTableView.beginUpdates()
            childrenTableView.deleteRows(at: [indexPath], with: .fade)
            childrenTableView.endUpdates()

            if count == 5 {
                showAddChildButton()
            }
        }
    }
}

// MARK: - Actions
extension MainViewController: UIActionSheetDelegate {
    @objc private func incrementChild() {
        let childrenCount = viewModel.getChildrenCount()

        let newIndexPath = IndexPath(row: childrenCount, section: 0)
        viewModel.incrementChildrenCount()

        childrenTableView.beginUpdates()
        childrenTableView.insertRows(at: [newIndexPath], with: .fade)
        childrenTableView.endUpdates()

        childrenTableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)

        if childrenCount == 4 {
            hideAddChildButton()
        }
    }

    @objc private func tapClearButton() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let resetAction = UIAlertAction(title: "Сбросить данные", style: .default) { _ in
            self.clearTableView()
            self.presonalData()
            self.showAddChildButton()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)

        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

// MARK: - Setup
extension MainViewController {
    private func setup() {
        view.backgroundColor = .white

        hideKeyboardWhenTappedAround()
        setTableView()

        setPersonalDataLabel()
        setNameTextField()
        setAgeTextField()
        setAddChildButton()
        setChildrenLabel()
        setClearButton()
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
        addChildButton.setTitleColor(ColorPack.blue, for: .normal)

        let image = UIImage(systemName: "plus")
        addChildButton.setImage(image, for: .normal)
        addChildButton.tintColor = ColorPack.blue

        addChildButton.layer.cornerRadius = 25
        addChildButton.layer.borderWidth = 2
        addChildButton.layer.borderColor = ColorPack.blue.cgColor
        addChildButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        addChildButton.translatesAutoresizingMaskIntoConstraints = false
        addChildButton.addTarget(self, action: #selector(incrementChild), for: .touchUpInside)
        view.addSubview(addChildButton)

        NSLayoutConstraint.activate([
            addChildButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addChildButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 10),
            addChildButton.heightAnchor.constraint(equalToConstant: 50),
            addChildButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 180)
        ])
    }

    private func setChildrenLabel() {
        view.addSubview(childrenLabel)

        NSLayoutConstraint.activate([
            childrenLabel.centerYAnchor.constraint(equalTo: addChildButton.centerYAnchor),
            childrenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    private func setClearButton() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("Очистить", for: .normal)
        clearButton.tintColor = ColorPack.red
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = ColorPack.red.cgColor
        clearButton.layer.cornerRadius = 25
        clearButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        clearButton.addTarget(self, action: #selector(tapClearButton), for: .touchUpInside)

        view.addSubview(clearButton)


        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -15),
            clearButton.heightAnchor.constraint(equalToConstant: 50),
            clearButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 180)
        ])
    }

    private func setChildrenTableView() {
        childrenTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childrenTableView)

        NSLayoutConstraint.activate([
            childrenTableView.topAnchor.constraint(equalTo: addChildButton.bottomAnchor, constant: 10),
            childrenTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            childrenTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            childrenTableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20)
        ])
    }
}
