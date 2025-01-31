import SwiftUI

enum TabBarTab {
    case home
    case tv
}

struct TabBarItem: Identifiable {
    var id: TabBarTab { tab }
    let title: LocalizedStringKey
    let tab: TabBarTab
    let systemImage: String
}

struct TabBar: View {
    @Binding var currentTab: TabBarTab

    private let items = [
        TabBarItem(title: "Home", tab: .home, systemImage: "house.fill"),
        TabBarItem(title: "TV", tab: .tv, systemImage: "tv.fill")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { item in
                TabBarButton(
                    item: item,
                    active: currentTab == item.tab,
                    action: {
                        currentTab = item.tab
                    }
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.tabBarBackground))
    }
}

private struct TabBarButton: View {
    let item: TabBarItem
    let active: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: item.systemImage)
                Text(item.title).textStyle(.cardTitle)
            }
        }
        .foregroundColor(Color(active ? .activeTab : .inactiveTab))
        .frame(maxWidth: .infinity)
    }
}
