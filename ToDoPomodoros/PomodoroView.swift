//
//  PomodoroTimerView.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 08/01/2023.
//

import SwiftUI

struct PomodoroView: View {
    //MARK: Properties
    let toDoItem: ToDoItem
    let coreDM: CoreDataManager

    //TODO: Add a subtitle currentPomodoro/TotalTaskPomodoros e.g. 2/3 or 2 of 3
    // this requires to add another attribute in the core data model.
    // and a method to update current Pomodoro when a pomodoro is finished.
    // After A Task Total Pomodoros = Current Pomodoro and It finishes, Task is highlighted as finished.
    //    @State private var currentPomodoros: Int16 = 1
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var progress: CGFloat = CGFloat(25 * 60) / CGFloat(25 * 60)
    @State private var timeRemaining = 1500
    @State private var isRunning = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            //
            Spacer()
            //
            Text(toDoItem.title ?? "")
            Text("\(toDoItem.pomodoros)")
            //
            ZStack {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.red, lineWidth: 10)
                    .frame(width: 200, height: 200)
                Text("\(timeRemaining / 60):\(timeRemaining % 60)")
                    .font(.title)
            }
            .padding(100)
            //
            Spacer()
            //
            HStack {
                //
                Spacer()
                //
                HStack {
                    Button(action: {
                        self.isRunning.toggle()
                    }) {
                        Text(isRunning ? "Pause" : "Start")
                    }
                }
                //
                Spacer()
                //
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Back")
                    }
                }
                //
                Spacer()
                //
            }
            //
            Spacer()
            //
        }
//        .onAppear(perform: {
//            currentPomodoros = toDoItem.pomodoros
//        })
        .onReceive(timer) { _ in
            if self.isRunning {
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = CGFloat(self.timeRemaining) / CGFloat(25 * 60)
                } else {
                    // reset timer
                    self.isRunning = false
                    self.timeRemaining = 25 * 60
                }
            }
        }
    }
}

//
//struct PomodoroView_Previews: PreviewProvider {
//    static var previews: some View {
//        PomodoroView()
//    }
//}
