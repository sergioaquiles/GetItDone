//
//  MainView.swift
//  MainView
//
//  Created by Sergio Cardoso on 14/09/21.
//  Photo by SUNBEAM PHOTOGRAPHY on Unsplash
//
//  Gaelle Marcel
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @StateObject var taskVM = TaskViewModel()
    @State private var isShowTaskView = false
    @StateObject var mapData = MapViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    HeaderView()
                    Spacer(minLength: 70)
                    NewTaskButton
                    List{
                        ForEach(taskVM.savedTasks) { task in
                            TaskRowView(task: task)
                        }
                        .onDelete(perform: taskVM.deleteTask)
                        .listRowBackground(Color.theme.background.opacity(0.7))
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
            }
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
                
            })
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
                    .blur(radius: isShowTaskView ? 8.0 : 0.0, opaque: false)
                    .ignoresSafeArea(.all)
            )
        }
        .environmentObject(taskVM)
        .environmentObject(mapData)
        .onAppear {
            NotificationManager.instance.requestAuthorization()
            mapData.locationManager.requestWhenInUseAuthorization()
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .preferredColorScheme(.dark)
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
