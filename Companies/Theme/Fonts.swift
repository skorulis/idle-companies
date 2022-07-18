import SwiftUI

enum ThemeFont: String, CaseIterable {
    
    case fontello = "fontello"
    
    func font(_ size: CGFloat) -> Font {
        _ = Self.registerOnce
        return Font.custom(self.rawValue, size: size)
    }
    
}

private extension ThemeFont {
    
    static func load(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "ttf"),
              let data = try? Data(contentsOf: url),
              let ref = CGDataProvider(data: data as CFData),
              let font = CGFont(ref)
        else {
            return
        }
        
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
    
    static let registerOnce: () = {
        _ = UIFont.familyNames
        
        for font in ThemeFont.allCases {
            load(name: font.rawValue)
        }
        
    }()
    
}
