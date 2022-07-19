import SwiftUI


enum ThemeIcon: String {
	case metalBar = "metal-bar"
	case ore = "ore"
	case anvil = "anvil"
	case digDug = "dig-dug"
	case factory = "factory"
	case woodenCrate = "wooden-crate"
}

extension ThemeIcon: View {
	var body: some View {
		Image(self.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
	}
    func image(_ size: CGFloat) -> some View {
        Image(self.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
    }
}