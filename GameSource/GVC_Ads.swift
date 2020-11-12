/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2020 TapTapStudio. All rights reserved.

 ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▀▀█▀▀ ░█▀▀█ ▒█▀▀█
 ░▒█░░ ▒█▄▄█ ▒█▄▄█ ░▒█░░ ▒█▄▄█ ▒█▄▄█
 ░▒█░░ ▒█░▒█ ▒█░░░ ░▒█░░ ▒█░▒█ ▒█░░░

 ▒█▀▀▀█ ▀▀█▀▀ ▒█░▒█ ▒█▀▀▄ ▀█▀ ▒█▀▀▀█
 ░▀▀▀▄▄ ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░ ▒█░░▒█
 ▒█▄▄▄█ ░▒█░░ ░▀▄▄▀ ▒█▄▄▀ ▄█▄ ▒█▄▄▄█
 
 If you want reskin write me.
 Here you can see reskin examples 🌅: https://alicevinnik.wixsite.com/taptapstudio
 Subscribe to my instagram 📷: https://www.instagram.com/taptap_studio/
 Write to my mail 💌: taptap.main@gmail.com
 
*/

import GoogleMobileAds

extension GameViewController {
    
    //MARK: - Work with ads
    /**
     Call this for show interstitial.
     Recomment to use AdController class for calling ad's in game.
     */
    @objc func showInterstitial() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            
            Debugger.printNow(textToPrint: "Show interstitial")
            if UserDefaults.standard.bool(forKey: "PlayMusic") { Sound.sharedInstance().pauseMusic()}
        }
    }
    
    /**
     Call this for show banner.
     Recomment to use AdController class for calling ad's in game.
     */
    @objc func showBanner() {
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(banner)
        view.addConstraints(
          [NSLayoutConstraint(item: banner,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: banner,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
        banner.adUnitID = SettingsGlobal.Ad.idBanner
        banner.rootViewController = self
        banner.load(GADRequest())
        banner.delegate = self
        
        Debugger.printNow(textToPrint: "Show banner")
    }
    
    /** Call this for hide bannner.*/
    @objc func hideBanner() {
        banner.removeFromSuperview()
    }
    
    //MARK: - Work with AdMob sdk
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        intersitialRecievedAd = true
    }
    
    func createAndLoadAd() -> GADInterstitial {
        let ad = GADInterstitial(adUnitID: SettingsGlobal.Ad.idInterstitial)
        ad.delegate = self
        
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [SettingsGlobal.Ad.testDeviceID]
        
        return ad
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: SettingsGlobal.Ad.idInterstitial)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    //MARK: - AdMob Delegates
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        if UserDefaults.standard.bool(forKey: "PlayMusic") { Sound.sharedInstance().resumeMusic()}
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        if UserDefaults.standard.bool(forKey: "PlayMusic") { Sound.sharedInstance().resumeMusic()}
    }
}
