/*

  Copyright © 2020 ProgressiveMobile

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

import TinkoffASDKUI
import TinkoffASDKCore

class Utils {
    private static var language: String!
    private static let amountFormatter = NumberFormatter()
    
    static func formatAmount(_ value: NSDecimalNumber, fractionDigits: Int = 2, currency: String = "₽") -> String {
        amountFormatter.usesGroupingSeparator = true
        amountFormatter.groupingSize = 3
        amountFormatter.groupingSeparator = " "
        amountFormatter.alwaysShowsDecimalSeparator = false
        amountFormatter.decimalSeparator = ","
        amountFormatter.minimumFractionDigits = 0
        amountFormatter.maximumFractionDigits = fractionDigits
        
        return "\(amountFormatter.string(from: value) ?? "\(value)") \(currency)"
    }
    
    static func setLanguage(_ language: String!) {
        self.language = language
    }
    
    static func getLanguage() -> AcquiringViewConfiguration.LocalizableInfo! {
       return AcquiringViewConfiguration.LocalizableInfo.init(lang: self.language)
    }
    
    static func getView(_ navigator: Bool = false) -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        
        if navigator {
            let view = UINavigationController()
            view.navigationBar.backgroundColor = UIColor.white
            view.isNavigationBarHidden = true
            view.addChild(UIViewController())
            topController.present(view, animated: true, completion: nil)
            return view
        } else {
            return topController
        }
    }
    
    static func getViewConfiguration(
        title: String,
        description: String,
        amount: Int64,
        enableSPB: Bool = false,
        email: String? = nil,
        scanner: AcquiringScanerProtocol? = nil
    ) -> AcquiringViewConfiguration {
        //!TODO: Локализация экрана оплаты
        
        let viewConfigration = AcquiringViewConfiguration.init()

        viewConfigration.scaner = scanner

        viewConfigration.viewTitle = "Оплата"
        
        viewConfigration.fields = []
        // InfoFields.amount
        let paymentTitle = NSAttributedString.init(
            string: "Оплата",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 22)
            ]
        )
        let amountString = Utils.formatAmount(NSDecimalNumber.init(floatLiteral: Double(amount)/100))
        let amountTitle = NSAttributedString.init(
            string: "на сумму \(amountString)",
            attributes: [
                .font : UIFont.systemFont(ofSize: 17)
            ]
        )
        
        // Добавление заголовка
        viewConfigration.fields.append(
            AcquiringViewConfiguration.InfoFields.amount(
                title: paymentTitle,
                amount: amountTitle
            )
        )
        
        let productDetail = NSMutableAttributedString.init()
        let titleString = NSAttributedString.init(
            string: title + "\n",
            attributes: [
                .font : UIFont.systemFont(ofSize: 17)
            ]
        )
        let descriptionString = NSAttributedString.init(
            string: description,
            attributes: [
                .font : UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor(red: 0.573, green: 0.6, blue: 0.635, alpha: 1)
            ]
        )
        
        productDetail.append(titleString)
        productDetail.append(descriptionString)
        
        /// Добавление поля для описания покупки
        viewConfigration.fields.append(
            AcquiringViewConfiguration.InfoFields.detail(
                title: productDetail
            )
        )
        
        /// Добавление кнопки "Оплатить с помощью СПБ"
        if (enableSPB) {
            // viewConfigration.fields.append(AcquiringViewConfiguration.InfoFields.buttonPaySPB)
        }

        viewConfigration.localizableInfo = AcquiringViewConfiguration.LocalizableInfo.init(lang: language.lowercased())
        viewConfigration.alertViewHelper = nil
        
        return viewConfigration
    }
    
    static func prepareJson(_ dictionary: Dictionary<String, Any>) -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let json = String(data: jsonData!, encoding: .utf8)
        return json
    }
    
    static func parseTaxation(_ taxation: String?) -> Taxation {
        switch (taxation) {
        case "usn_income":
            return Taxation.usnIncome
        case "usn_income_outcome":
            return Taxation.usnIncomeOutcome
        case "patent":
            return Taxation.patent
        case "envd":
            return Taxation.envd
        case "esn":
            return Taxation.esn
        case "osn":
            return Taxation.osn
        default:
            return Taxation.osn
        }
    }
    
    static func parseTax(_ tax: String?) -> Tax {
        switch (tax) {
        case "non":
            return Tax.none
        case "vat0":
            return Tax.vat0
        case "vat10":
            return Tax.vat10
        case "vat18":
            return Tax.vat18
        case "vat20":
            return Tax.vat20
        case "vat110":
            return Tax.vat110
        case "vat118":
            return Tax.vat118
        case "vat120":
            return Tax.vat120
        default:
            return Tax.none
        }
    }
}
