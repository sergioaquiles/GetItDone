//
//  MainView.swift
//  MainView
//
//  Created by Sergio Cardoso on 14/09/21.
//  api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
// 


import SwiftUI
import CoreData

struct HomeView: View {
    
    
    @StateObject var taskVM = TaskViewModel()
    @State private var isShowTaskView = false 
    @State private var showWeather = false
    
    
    var body: some View {
        NavigationView {
            ZStack() {
                VStack{
                    HeaderView(showWeather: $showWeather)
                    Spacer(minLength: 55)
                    
                    NewTaskButton
                    
                    List{
                        if taskVM.savedTasks.isEmpty && isShowTaskView == false {
                            Text("You haven't added any task yet. Click the + button to get started! 🧐")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.theme.accent)
                            
                        } else {
                            ForEach(taskVM.sortedTasks.keys.sorted(by: {$0 < $1}), id:\.self ) { key in
                                
                                Section(header: SectionHeaderView(title: "\(key)")) {
                                    ForEach(taskVM.sortedTasks[key]!) { task in
                                        TaskRowView(task: task)
                                    }
                                    .onDelete { indexSet in
                                        taskVM.deleteTask(key: key, indexSet: indexSet)
                                    }
                                }
                            }
                            .listRowBackground(Color.theme.background.opacity(0.7).blur(radius: 2.0))
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .padding(.vertical, 0)
                    
                }
                if isShowTaskView {
                    MaskView(bg: Color.theme.background, bgOpacity: 0.7)
                        .onTapGesture {
                            withAnimation {
                                isShowTaskView = false
                            }
                        }
                    
                    NewTaskView(showNewTaskView: $isShowTaskView)
                        .transition(AnyTransition.scale.animation(.easeIn))
                }
                if showWeather {
                    MaskView(bg: Color.theme.background, bgOpacity: 0.9)
                        .onTapGesture {
                            withAnimation {
                                showWeather = false
                            }
                        }
                    
                    WeatherDetailView()
                        .transition(AnyTransition.scale.animation(.easeIn))
                    
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
            })
            .background(
                BackgroundImageView()
                    .blur(radius: isShowTaskView || !taskVM.sortedTasks.isEmpty  ? 8.0 : 0.0, opaque: false)
            )
        }
        .environmentObject(taskVM)
        .onAppear {
            NotificationManager.instance.requestAuthorization()
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .preferredColorScheme(.dark)
                .environmentObject(NetworkingManager())
                .environmentObject(LocationManager())
            
        }
        .navigationBarHidden(true)
    }
}

extension HomeView {
    
    private var NewTaskButton: some View {
        Button {
            withAnimation {
                isShowTaskView = true
            }
        } label: {
            Image(systemName: "plus.circle")
                .font(.system(size: 30, weight: .semibold, design: .default ))
            Text("New Task")
                .font(.system(size: 24, weight: .semibold, design: .default))
        }
        .foregroundColor(Color.theme.accent)
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(
            LinearGradient(colors: [Color.theme.darkYellow, Color.theme.ligthYellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(Capsule())
        )
    }
}
