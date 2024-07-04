//
//  SleepModePage.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/5/24.
//

import SwiftUI
import SwiftData

struct SleepModePage: View {
    @Binding var pressed:Bool
    @Query var remain:[RemainTime]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        // ZStack{
        
        VStack {
            if let left = remain.first?.leftMin{
                let hour = left/60
                let min = left%60
                Text("수면가능 시간").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold()).foregroundColor(.white)
                Spacer().frame(height: 10)
                Text("\(hour)시간 \(min)분").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                Spacer().frame(height: 30)
                if(left>480){
                    Image(systemName: "battery.100percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Spacer().frame(height: 10)
                    
                    
                    Text("꿀잠 가능!!!").font(.title).foregroundColor(.white)
                    Image("sleeping").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding()
                }
                else if(left>360){
                    Image(systemName: "battery.50percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Text("피곤하다 자자~").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.yellow)
                    Image("tired").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding()
                }
                else if(left>240){
                    Image(systemName: "battery.25percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Spacer().frame(height: 20)
                    Text("내일아침 감당 가능..?").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                    Image("possible").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 170)
                        .padding()
                }
                else {
                    Image(systemName: "battery.0percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Text("ㅈ됐다 밤새자 ㅎㅎ").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    Image("notSleep").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 200)
                        .padding()
                }
                
                
                //            Spacer().frame(height: 140)
            }
            CircleButton(buttonText: "수면모드 해제"){
                pressed=false
                // 기존 기록 날려줘버림
                for oldItem in remain{
                    modelContext.delete(oldItem)
                }
                
            }
            
    //    }
    }.frame(width: 1000000, height: 10000000)
            .background(Color.black)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
        
    }
}
