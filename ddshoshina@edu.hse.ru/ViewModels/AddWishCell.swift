//
//  AddWishCell.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 10/11/2025.
//


import UIKit

// sector with wish adding
final class AddWishCell: UITableViewCell {

    static let reuseId: String = "AddWishCell"
    
    var addWish: ((String) -> Void)?

    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let innerOffset: CGFloat = 8
        static let textViewHeight: CGFloat = 80
    }

    private let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.systemGray4.cgColor
        tv.layer.cornerRadius = 8
        tv.isScrollEnabled = false
        tv.isEditable = true
        tv.backgroundColor = .white
        return tv
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add wish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 12
        return button
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        let wrap = UIView()
        contentView.addSubview(wrap)
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: contentView, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: contentView, Constants.wrapOffsetH)
        wrap.addSubview(textView)
        wrap.addSubview(addButton)

        // textView
        textView.pinTop(to: wrap, Constants.innerOffset)
        textView.pinHorizontal(to: wrap, Constants.innerOffset)
        textView.setHeight(Constants.textViewHeight)

        // button
        addButton.pinBelow(textView, Constants.innerOffset)
        addButton.pinHorizontal(to: wrap, Constants.innerOffset)
        addButton.pinBottom(to: wrap, Constants.innerOffset)

        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )
    }

    // MARK: - Actions

    @objc private func addButtonTapped() {
        let rawText = textView.text ?? ""
        let text = rawText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !text.isEmpty else { return }

        addWish?(text)

        textView.text = ""
        textView.resignFirstResponder()
    }
}
