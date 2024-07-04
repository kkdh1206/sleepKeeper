//
//  ContentView.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/4/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query var item:[WakeUpTime]
    @Query var sleepStartTime:[SleepStartTime]
    @Query var remain:[RemainTime]
    @Environment(\.modelContext) private var modelContext
    @State private var showTimePicker = false
    @State private var selectedTime = Date()
    @State private var pressed = false
    var body: some View {
        if(!pressed){
            NavigationView{
                VStack {
                    
                    if let currentItem = item.first {
                        Text("기상시간: \(formattedTime(currentItem.timestamp))")
                            .font(.largeTitle)
                            .padding()
                    } else {
                        Text("선택된 시간이 없습니다")
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Button(action: {
                        showTimePicker.toggle()
                    }) {
                        Label("시간변경", systemImage: "clock")
                            .font(.title)
                    }
                    .padding()
                    .sheet(isPresented: $showTimePicker) { // sheet형식으로 팝업창 띄움
                        TimePickerView(selectedTime: $selectedTime)
                    }
                    if(!pressed){
                        CircleButton(buttonText: "수면시작!"){
                            // 여기다가 누르면 시간 흘러가게 구현하면 될듯
                            if let old = sleepStartTime.first{ // 기존 기록 날려줘버림
                                for oldItem in sleepStartTime{
                                    modelContext.delete(oldItem)
                                }
                            }
                        
                            var startTime = SleepStartTime(timestamp: addHoursToCurrentTime(hours: 0, currentTime: Date())) // 현재 시간 기록
                            modelContext.insert(startTime)
                            print(startTime.timestamp)
                            
                            if let wakeupTime = item.first{
                                pressed=true
                                var remainTime = RemainTime(leftMin: timeDifference(from: startTime.timestamp, to: wakeupTime.timestamp))
                                while(remainTime.leftMin<0){
                                    remainTime.leftMin = remainTime.leftMin + 1440 // 1440분 = 하루 를 더해줌 다음날 그 시간이 되게
                                }
                                modelContext.insert(remainTime)
                                print(remainTime.leftMin)
                                print(remainTime.leftMin/60,"시간")
                                print(remainTime.leftMin%60, "분")
                            }else{
                                
                            }
                            
                            
                        
                        }
                    }
                    
                }.navigationBarTitle("시간 지킴이", displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                        }
                    }
            }
            
        } else{
            SleepModePage(pressed: $pressed)
        }
        
    }
    
    func addHoursToCurrentTime(hours: Int, currentTime: Date) -> Date {
            return Calendar.current.date(byAdding: .hour, value: hours, to: currentTime) ?? currentTime
        }
    
    private func formattedTime(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH : mm"  // 시:분 형식 설정
            return formatter.string(from: date)
        }
    
    
}

struct CircleButton: View {
    var buttonText: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding().frame(width: 200, height: 100)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 10)))  // 동그란 모양으로 클리핑
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WakeUpTime.self, inMemory: true)
}
