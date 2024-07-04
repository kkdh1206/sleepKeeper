//
//  PopupPage.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/4/24.
//
import SwiftUI
import SwiftData

struct TimePickerView: View {
    @Query var items:[WakeUpTime]
    var item = WakeUpTime(timestamp: Date())
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedTime:Date
    
    var body: some View {
        VStack {
            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()

            Button("Done") {
                if let old = items.first{
                    for oldItem in items{
                        modelContext.delete(oldItem)
                    }
                        
                    
                }
                item.timestamp = selectedTime
                print("wakeupTime =", selectedTime)
                modelContext.insert(item)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .frame(minWidth: 300, minHeight: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}
