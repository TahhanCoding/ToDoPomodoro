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

    @State private var title = ""
    @State private var pomodoros = 0
    @State private var completed = false

    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var progress: CGFloat = CGFloat(25 * 60) / CGFloat(25 * 60)
    @State private var timeRemaining = 1500
    @State private var isRunning = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
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
