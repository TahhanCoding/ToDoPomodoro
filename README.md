# ToDoPomodoro

## A todoList iOS Application that keeps track of number of pomodoros sessions required for each task.

## Main Skills Used: 
SwiftUI - Core Data - Timer - SheetView - API - OOP - MVVM 

## Code Highlight
```     
List {
                ForEach($toDoItems, id: \.self) { $toDoItem in
                    HStack {
                        Button(action: {
                            self.showPomodoroView = true
                            self.toDoItem = toDoItem
                        }) {
                            Text(toDoItem.title ?? "").foregroundColor(toDoItem.completed ? .green : .gray)
                        }
                        Spacer()
                        Text("\(toDoItem.pomodoros)")
                        Image(systemName: "digitalcrown.horizontal.arrow.counterclockwise.fill")
                            .foregroundColor(.red)
                    }.sheet(isPresented: $showPomodoroView) {
                        PomodoroView(coreDM: coreDM, toDoItem: self.$toDoItem)
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let toDoItem = toDoItems[index]
                        coreDM.delete(toDoItem: toDoItem)
                        toDoItems = coreDM.loadData()
                    }
                })
                .padding()
            }
```
## ScreenShots 
![Sheet](https://user-images.githubusercontent.com/97001250/215166788-37d33dd0-bf8e-426e-a841-11924d65a48e.png)
![delete-task](https://user-images.githubusercontent.com/97001250/215166800-3cd3f261-4efb-440d-bcc3-9d802d38dfe0.png)
![Main](https://user-images.githubusercontent.com/97001250/215166802-6cfc1a47-d049-46e5-9dc1-cfb5e4df07ea.png)
