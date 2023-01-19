//
//  PomodoroTimerView.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 08/01/2023.
//

import SwiftUI
//import AVFoundation

struct PomodoroView: View {
//    @Binding var PomodorosRemaining: Int
    @State private var timeRemaining = 1500
    @State private var isRunning = false
    @State private var progress: CGFloat = CGFloat(1500) / CGFloat(25 * 60)
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.presentationMode) var presentationMode

    
// @State var audioPlayer = AVAudioPlayer()
// let tikSound = URL(fileURLWithPath: Bundle.main.path(forResource: "tik", ofType: "wav")!)

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
//                    Text("PomodorosRemaining: \(PomodorosRemaining)")
                        
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
                  //self.playSound()
                } else {
                    self.isRunning = false
                    self.timeRemaining = 25 * 60
//                    self.PomodorosRemaining -= 1
                    
                    
                }
            }
        }
    }
    
//     func playSound() {
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: tikSound)
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
//        } catch {
//            print(error)
//        }
//    }
    
}

//
//struct PomodoroView_Previews: PreviewProvider {
//    static var previews: some View {
//        PomodoroView(PomodorosRemaining: TodoLis)
//    }
//}
