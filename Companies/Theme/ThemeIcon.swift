import SwiftUI


enum ThemeIcon: String {
	case atom = "atom"
	case clayBrick = "clay-brick"
	case concreteBag = "concrete-bag"
	case metalBar = "metal-bar"
	case moneyStack = "money-stack"
	case oilDrum = "oil-drum"
	case ore = "ore"
	case sandDust = "sand-dust"
	case stoneBlock = "stone-block"
	case stonePile = "stone-pile"
	case anvil = "anvil"
	case digDug = "dig-dug"
	case virtualMarker = "virtual-marker"
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