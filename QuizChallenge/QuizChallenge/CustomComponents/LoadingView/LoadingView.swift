//
//  LoadingView.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var activityIndicatorBackgorundView: UIView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    static let tag = loadingViewTag
    var lView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    private func xibSetup() {
        lView = loadViewFromNib()
        lView.frame = bounds
        lView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lView.translatesAutoresizingMaskIntoConstraints = true
        tag = LoadingView.tag
        setup()
        addSubview(lView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first

        return nibView as! UIView
    }

    private func setup() {
        activityIndicatorBackgorundView.layer.cornerRadius = loadingViewCornerRadius
        loadingActivityIndicator.scale(factor: 3.0)
    }
    
    public func startAnimating() {
        loadingActivityIndicator.startAnimating()
    }

    public func stopAnimating() {
        loadingActivityIndicator.stopAnimating()
    }
}
