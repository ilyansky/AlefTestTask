import UIKit

class ButtonView: UIButton {
    private let view = UIView()
    var imgView: UIImageView
    var labelText: String

    init(frame: CGRect = .zero, imgView: UIImageView, labelText: String) {
        self.imgView = imgView
        self.labelText = labelText
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ButtonView {
    private func setUI() {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        let label = LabelView(labelText: labelText, fontSize: 15)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.tintColor = .systemBlue
        view.addSubview(imgView)

        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            imgView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -10),
            imgView.heightAnchor.constraint(equalToConstant: 30),
            imgView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
