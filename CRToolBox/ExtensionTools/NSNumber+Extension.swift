//
//  NSNumber+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/28.
//  Copyright © 2018 CR. All rights reserved.
//

import Foundation

extension NSNumber {
    
    /// 国际化格式输出 保留三位小数,第四位小数四舍五入
    public func getFinanceDecimal() -> String {
        return NumberFormatter.localizedString(from: self, number: .decimal)
    }
    
    /// 四舍五入的整数, 例如传1234.5678, 返回1235
    public func getNone() -> String {
        return NumberFormatter.localizedString(from: self, number: .none)
    }
    
    /// 百分数形式, 例如传1234.5678, 返回123,457%
    public func getPercent() -> String {
        return NumberFormatter.localizedString(from: self, number: .percent)
    }
    
    /// 科学计数, 例如传1234.5678, 返回1.2345678E3
    public func getScientific() -> String {
        return NumberFormatter.localizedString(from: self, number: .scientific)
    }
    
    /** 朗读形式（英文表示）
     * 例如传1234.5678
     * 返回 one thousand two hundred thirty-four point five six sever eigth
     */
    public func getSpellOut() -> String {
        return NumberFormatter.localizedString(from: self, number: .spellOut)
    }
    
    /// 序数形式, 例如传1234.5678, 返回1,235th
    public func getOrdinal() -> String {
        return NumberFormatter.localizedString(from: self, number: .ordinal)
    }
    
    /** 货币形式
     * 保留2位小数,第2位小数四舍五入,在前面添加货币符号
     * 例如传1234.5678, 返回 CN¥1,234.57
     */
    public func getCurrency() -> String {
        return NumberFormatter.localizedString(from: self, number: .currency)
    }
    
    /// 货币形式, 例如传1234.5678, 返回CNY1,234.57
    public func getCurrencyISOCode() -> String {
        return NumberFormatter.localizedString(from: self,
                                               number: .currencyISOCode)
    }
    
    /// 货币形式, 例如传1234.5678, 返回 1,234.57 Chinese yuan
    public func getCurrencyPlural() -> String {
        return NumberFormatter.localizedString(from: self,
                                               number: .currencyPlural)
    }
    
    /// 会计计数, 例如传1234.5678, 返回CN¥1,234.57
    public func getCurrencyAccounting() -> String {
        return NumberFormatter.localizedString(from: self,
                                               number: .currencyAccounting)
    }
    
}
