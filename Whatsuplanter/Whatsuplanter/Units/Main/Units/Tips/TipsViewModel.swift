//
//  TipsViewModel.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 04.02.2025.
//

import Foundation

extension TipsView {
    final class ViewModel: ObservableObject {
        let tips: [TipsView.TipModel] = [
            .init(title: "Hogyan válasszunk növényeket városi környezetbe?",
                  text: """
                    Válasszon olyan növényeket, amelyek kevésbé igényesek a talajra és az árnyékra, például levendulát, árnyékliliomot, borostyánt vagy muskátlit.
                  
                    Ezek jól alkalmazkodnak a szennyezett levegőhöz és a korlátozott térhez.
                  
                    A rendszeres öntözés és mulcsozás segít megőrizni a nedvességet.
                  """),
            
                .init(title: "Hogyan készítsük elő a talajt egy ökológiai kerthez?",
                      text: """
                        Használjon komposztot vagy szerves trágyát a talaj tápanyagokkal való gazdagítására.
                      
                        Ősszel forgassa meg a talajt, hogy biztosítsa a levegőzést és elpusztítsa a kártevőket.
                      
                        Ültessen talajtakaró növényeket (lóhere, csillagfürt) a talaj regenerálásához.
                      """),
            
                .init(title: "Hogyan gyűjtsük hatékonyan az esővizet?",
                      text: """
                        Helyezzen egy esővízgyűjtő hordót az ereszcsatorna alá.
                      
                        Használjon természetes árkokat vagy vízelvezető rendszereket az öntözéshez.
                      
                        Öntözze a növényeket kora reggel vagy este, hogy csökkentse a párolgást.
                      """),
            
                .init(title: "Hogyan védekezzünk a kártevők ellen vegyszerek nélkül?",
                      text: """
                        Ültessen riasztó növényeket a közelbe (bazsalikom, körömvirág, levendula).
                      
                        Használjon természetes oldatokat, például szappanos oldatot vagy fokhagymás permetet.
                      
                        Vonzza be a természetes ragadozókat (katica, békák, madarak).
                      """),
            
                .init(title: "Hogyan mulcsozzuk helyesen a talajt?",
                      text: """
                        Használjon szalmát, fakérget vagy leveleket a talaj kiszáradás elleni védelmére.
                      
                        A mulcs csökkenti a gyomok növekedését és megtartja a nedvességet.
                      
                        A mulcsréteg legyen 5–7 cm vastag, hogy hatékonyan tartsa meg a hőt és a vizet.
                      """),
            
                .init(title: "Hogyan hozzunk létre környezetbarát öntözőrendszert?",
                      text: """
                        Használjon csepegtető öntözést a víz megtakarítása érdekében.
                      
                        Telepítsen talajnedvesség-érzékelőket az automatikus szabályozáshoz.
                      
                        Ültessen növényeket csoportokban a vízigényük szerint.
                      """),
            
                .init(title: "Hogyan készítsünk saját komposztot?",
                      text: """
                        Használjon zöldség- és gyümölcsmaradékokat, kávézaccot és száraz leveleket.
                      
                        Kerülje a hús- és zsírtartalmú ételek hozzáadását.
                      
                        Keverje át a komposztot kéthetente az egyenletes bomlás érdekében.
                      """),
        ]
    }
}

extension TipsView {
    struct TipModel: Identifiable {
        private(set) var id = UUID().uuidString
        var title, text: String
    }
}
