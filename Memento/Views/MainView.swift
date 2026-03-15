import SwiftUI

struct MainView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) private var colorScheme
    @State private var navigationState = NavigationState()
    @State private var selectedTab: Int = 0

    var body: some View {
        ZStack {
            themeManager.currentBackground(for: colorScheme)
                .ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                NavigationStack(path: $navigationState.todayPath) {
                    TodayView()
                        .environment(navigationState)
                }
                .toolbarBackground(themeManager.currentBackground(for: colorScheme), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .tabItem {
                    Label("Today", systemImage: "\(Date.today).calendar")
                }
                .tag(0)
                
                NavigationStack(path: $navigationState.allPath) {
                    AllView()
                        .environment(navigationState)
                }
                .toolbarBackground(themeManager.currentBackground(for: colorScheme), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }
                .tag(1)
                
                NavigationStack {
                    SettingsView()
                }
                .toolbarBackground(themeManager.currentBackground(for: colorScheme), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
            }
            .toolbarBackground(themeManager.currentBackground(for: colorScheme), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .onChange(of: selectedTab) {
                navigationState.todayPath = NavigationPath()
                navigationState.allPath = NavigationPath()
            }
            .onChange(of: selectedTab) {
                navigationState.todayPath = NavigationPath()
                navigationState.allPath = NavigationPath()
            }
            .toolbarBackground(themeManager.currentBackground(for: colorScheme), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .preferredColorScheme(
            themeManager.appTheme == AppTheme.light.rawValue ? .light :
            themeManager.appTheme == AppTheme.dark.rawValue ? .dark : nil
        )
    }
}

#Preview {
    MainView()
        .environmentObject(ThemeManager())
}
