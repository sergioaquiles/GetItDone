//
//  WeatherView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 27/11/21.
//

//import SwiftUI
//import SpriteKit
//
//struct WeatherView: View {
//    
//    
//    @EnvironmentObject var nm: NetworkingManager
//    @EnvironmentObject var lm: LocationManager
//    
//    var body: some View {
//        ZStack{
//            
//            if #available(iOS 15.0, *) {
//                GeometryReader { proxi in
//                    Image("cloudySky")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: proxi.size.width, height: proxi.size.height)
//                }
//                .ignoresSafeArea()
//                .overlay(.ultraThinMaterial)
//            }
//             VStack(alignment: .center, spacing: 10) {
//                HStack {
//                    Image(systemName: "location.circle.fill")
//                    Text(lm.location)
//                }
//                .padding(.top, 35)
//                Spacer()
//                if #available(iOS 15.0, *) {
//                    Image(systemName: nm.weather.conditionName)
//                        .symbolRenderingMode(.palette)
//                        .foregroundStyle(Color.theme.accent, .yellow)
//                        .font(.system(size: 75))
//                    Text(nm.weather.description)
//                }
//                HStack(spacing: 2){
//                    Image(systemName: "arrow.up")
//                    Text("\(nm.weather.maximum)º")
//                    Spacer()
//                    Image(systemName: "arrow.down")
//                    Text("\(nm.weather.minimum)º")
//                }
//                .frame(width: 105)
//                .font(.system(size: 16, weight: .semibold, design: .rounded))
//                 Text("\(nm.weather.temperatureString)º")
//                    .font(.system(size: 85, weight: .semibold, design: .rounded))
//                Spacer()
//            }
//            
//            SpriteView(scene: RainFall(), options: [.allowsTransparency])
//            
//        }
//    }
//}
//
//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
//
//class RainFall: SKScene {
//    
//    override func sceneDidLoad() {
//        
//        
//        size = UIScreen.main.bounds.size
//        scaleMode = .resizeFill
//        
//        anchorPoint = CGPoint(x: 0.5, y: 1)
//        
//        backgroundColor = .clear
//        
//        let node = SKEmitterNode(fileNamed: "RainFall.sks")!
//        addChild(node)
//        
//        node.particlePositionRange.dx = UIScreen.main.bounds.width
//        
//    }
//    
//    
//}
