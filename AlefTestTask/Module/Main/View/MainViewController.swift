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

    private var activeTextField: UITextField?


    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setTableView()
        setUI()
    }
}

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
            viewModel.decrementChildrenCount()
            childrenTableView.beginUpdates()
            childrenTableView.deleteRows(at: [indexPath], with: .fade)
            childrenTableView.endUpdates()

            UIView.animate(withDuration: 0.3, animations: {
                self.addChildButton.isHidden = false
                self.addChildButton.alpha = 1
            })
        }

    }
}

extension MainViewController {
    @objc private func incrementChild() {
        let childrenCount = viewModel.getChildrenCount()

        let newIndexPath = IndexPath(row: childrenCount, section: 0)
        viewModel.incrementChildrenCount()

        childrenTableView.beginUpdates()
        childrenTableView.insertRows(at: [newIndexPath], with: .automatic)
        childrenTableView.endUpdates()

        childrenTableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)

        if childrenCount == 4 {
            UIView.animate(withDuration: 0.3, animations: {
                self.addChildButton.alpha = 0
            }, completion: { _ in
                self.addChildButton.isHidden = true
            })
        }
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
            childrenTableView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        ])
    }

}

