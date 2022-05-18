//
//  PremiumBoardingHeaderItem.swift
//  Telegram
//
//  Created by Mike Renoir on 11.05.2022.
//  Copyright © 2022 Telegram. All rights reserved.
//

import Foundation
import TGUIKit


final class PremiumBoardingHeaderItem : GeneralRowItem {
    fileprivate let titleLayout: TextViewLayout
    fileprivate let infoLayout: TextViewLayout
    init(_ initialSize: NSSize, stableId: AnyHashable, viewType: GeneralViewType) {
        self.titleLayout = .init(.initialize(string: strings().premiumBoardingTitle, color: theme.colors.text, font: .medium(.header)))
        let info = NSMutableAttributedString()
        _ = info.append(string: strings().premiumBoardingInfo, color: theme.colors.text, font: .normal(.text))
        info.detectBoldColorInString(with: .medium(.text))
        self.infoLayout = .init(info, alignment: .center)
        super.init(initialSize, stableId: stableId)
        _ = makeSize(initialSize.width)
    }
    
    override func makeSize(_ width: CGFloat, oldWidth: CGFloat = 0) -> Bool {
        _ = super.makeSize(width, oldWidth: oldWidth)
        
        titleLayout.measure(width: width - 60)
        infoLayout.measure(width: width - 60)

        return true
    }
    
    override var height: CGFloat {
        return 100 + 10 + titleLayout.layoutSize.height + 10 + infoLayout.layoutSize.height + 10
    }
    
    
    override func viewClass() -> AnyClass {
        return PremiumBoardingHeaderView.self
    }
}


private final class PremiumBoardingHeaderView : TableRowView {
    private let premiumView = PremiumStarSceneView(frame: NSMakeRect(0, 0, 150, 150))
    private let titleView = TextView()
    private let infoView = TextView()
    private let borderView = View()
    required init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(titleView)
        addSubview(infoView)
        addSubview(premiumView)
        addSubview(borderView)
        
        
        titleView.userInteractionEnabled = false
        titleView.isSelectable = false
        
        infoView.userInteractionEnabled = false
        infoView.isSelectable = false
        
        premiumView.updateLayout(size: premiumView.frame.size, transition: .immediate)
    }
    
    
    override func layout() {
        super.layout()
        premiumView.centerX(y: -30)
        titleView.centerX(y: premiumView.frame.maxY - 30 + 10)
        infoView.centerX(y: titleView.frame.maxY + 10)
        borderView.frame = NSMakeRect(0, frame.height - .borderSize, frame.width, .borderSize)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func set(item: TableRowItem, animated: Bool = false) {
        super.set(item: item, animated: animated)
        
        guard let item = item as? PremiumBoardingHeaderItem else {
            return
        }
        titleView.update(item.titleLayout)
        infoView.update(item.infoLayout)
        
        borderView.backgroundColor = theme.colors.border
        
        needsLayout = true
        
    }
}