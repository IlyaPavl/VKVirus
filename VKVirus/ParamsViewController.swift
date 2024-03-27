//
//  ParamsViewController.swift
//  VKVirus
//
//  Created by ily.pavlov on 26.03.2024.
//

import UIKit


final class ParamsViewController: UIViewController {
    
    private let groupSizeTF = UITextField()
    private let infectionFactorTF = UITextField()
    private let updatePeriodTF = UITextField()
    private let groupSizeLabel = UILabel()
    private let infectionFactorLabel = UILabel()
    private let updatePeriodLabel = UILabel()
    private let startButton = UIButton(type: .system)
    private let fontSizeLabels: CGFloat = 17
    private let buttonWidth: CGFloat = 270
    private let buttonHeight: CGFloat = 45

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupParamsUI()
        hideKeyboardOnTap()
        groupSizeTF.delegate = self
        infectionFactorTF.delegate = self
        updatePeriodTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupSizeTF.text = ""
        infectionFactorTF.text = ""
        updatePeriodTF.text = ""
    }
}

// MARK: - UITextFieldDelegate
extension ParamsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
    }
    
    private func checkTextField(_ textField: UITextField) {
        if textField.text == "" {
            textField.backgroundColor = #colorLiteral(red: 0.9355837703, green: 0.7218409777, blue: 0.7291261554, alpha: 1)
        } else {
            textField.backgroundColor = .white
        }
    }
}
// MARK: - setupParamsUI
extension ParamsViewController {
    private func setupParamsUI() {
        view.addSubview(groupSizeLabel)
        view.addSubview(infectionFactorLabel)
        view.addSubview(updatePeriodLabel)
        view.addSubview(groupSizeTF)
        view.addSubview(infectionFactorTF)
        view.addSubview(updatePeriodTF)
        view.addSubview(startButton)
        
        setupAllConstraints()
        setupNavBar()
        setupGroupSizeUI()
        setupInfectionFactorUI()
        setupUpdatePeriodUI()
        setupButton()

    }
    
    private func setupNavBar() {
        navigationItem.title = "Параметры моделирования"
    }
    
    private func setupGroupSizeUI() {
        configureTextFields(textField: groupSizeTF, placeholder: "100", borderStyle: .roundedRect, keyboardType: .numberPad)
        configureTextLabels(label: groupSizeLabel, text: "Размер популяции людей", textColor: .black, fontSize: fontSizeLabels, fontWeight: .heavy)
    }
    
    private func setupInfectionFactorUI() {
        configureTextFields(textField: infectionFactorTF, placeholder: "6", borderStyle: .roundedRect, keyboardType: .numberPad)
        configureTextLabels(label: infectionFactorLabel, text: "Фактор распространения вируса", textColor: .black, fontSize: fontSizeLabels, fontWeight: .heavy)
    }
    
    private func setupUpdatePeriodUI() {
        configureTextFields(textField: updatePeriodTF, placeholder: "1", borderStyle: .roundedRect, keyboardType: .numberPad)
        configureTextLabels(label: updatePeriodLabel, text: "Интервал обновления зараженных", textColor: .black, fontSize: fontSizeLabels, fontWeight: .heavy)

    }
    
    private func setupButton() {
        startButton.setTitle("Запустить моделирование", for: .normal)
        startButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        startButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.layer.cornerRadius = 15
    }
    
    @objc func goToNextScreen() {
        checkTextField(groupSizeTF)
        checkTextField(infectionFactorTF)
        checkTextField(updatePeriodTF)
        
        if groupSizeTF.text != "" && infectionFactorTF.text != "" && updatePeriodTF.text != "" {
            if let groupSize = Int(groupSizeTF.text ?? ""),
               let infectionFactor = Int(infectionFactorTF.text ?? ""),
               let updatePeriod = Int(updatePeriodTF.text ?? "") {
                let simulatorVC = SimulatorViewController(groupSize: groupSize, infectionFactor: infectionFactor, updatePeriod: updatePeriod)
                navigationController?.pushViewController(simulatorVC, animated: true)
            }
        }
    }
    
    private func setupAllConstraints() {
        groupSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        groupSizeTF.translatesAutoresizingMaskIntoConstraints = false
        infectionFactorLabel.translatesAutoresizingMaskIntoConstraints = false
        infectionFactorTF.translatesAutoresizingMaskIntoConstraints = false
        updatePeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        updatePeriodTF.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            groupSizeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            groupSizeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            groupSizeTF.topAnchor.constraint(equalTo: groupSizeLabel.bottomAnchor, constant: 10),
            groupSizeTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            groupSizeTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            infectionFactorLabel.topAnchor.constraint(equalTo: groupSizeTF.bottomAnchor, constant: 20),
            infectionFactorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infectionFactorTF.topAnchor.constraint(equalTo: infectionFactorLabel.bottomAnchor, constant: 10),
            infectionFactorTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infectionFactorTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            updatePeriodLabel.topAnchor.constraint(equalTo: infectionFactorTF.bottomAnchor, constant: 20),
            updatePeriodLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            updatePeriodTF.topAnchor.constraint(equalTo: updatePeriodLabel.bottomAnchor, constant: 10),
            updatePeriodTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            updatePeriodTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            startButton.heightAnchor.constraint(equalToConstant: buttonHeight)

        ])
    }
    
    private func configureTextFields(textField: UITextField, placeholder: String, borderStyle: UITextField.BorderStyle, keyboardType: UIKeyboardType) {
        textField.placeholder = placeholder
        textField.borderStyle = borderStyle
        textField.keyboardType = keyboardType
    }
    
    private func configureTextLabels(label: UILabel, text: String?, textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
}

extension ParamsViewController{
    func hideKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}
