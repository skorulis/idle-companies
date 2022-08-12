import SwiftUI


enum ThemeIcon: String {
	case atom = "atom"
	case checklist = "checklist"
	case clayBrick = "clay-brick"
	case cog = "cog"
	case computing = "computing"
	case concreteBag = "concrete-bag"
	case cutDiamond = "cut-diamond"
	case dunceCap = "dunce-cap"
	case emerald = "emerald"
	case gems = "gems"
	case graduateCap = "graduate-cap"
	case humanPyramid = "human-pyramid"
	case metalBar = "metal-bar"
	case moneyStack = "money-stack"
	case oilDrum = "oil-drum"
	case ore = "ore"
	case person = "person"
	case sandDust = "sand-dust"
	case saphir = "saphir"
	case stoneBlock = "stone-block"
	case stonePile = "stone-pile"
	case anvil = "anvil"
	case blockHouse = "block-house"
	case digDug = "dig-dug"
	case hammerNails = "hammer-nails"
	case targetArrows = "target-arrows"
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