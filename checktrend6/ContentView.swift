import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            TabPage(sourceUrl: NSLocalizedString("LANG_VIEW1_URL", comment: ""), pageTitle: NSLocalizedString("LANG_VIEW1_TITLE", comment: ""))
                .tabItem {
                    Image(systemName: "g.circle")
                }
            TabPage(sourceUrl: NSLocalizedString("LANG_VIEW2_URL", comment: ""), pageTitle: NSLocalizedString("LANG_VIEW2_TITLE", comment: ""))
                .tabItem {
                    Image(systemName: "t.circle")
                }
            TabPage(sourceUrl: NSLocalizedString("LANG_VIEW3_URL", comment: ""), pageTitle: NSLocalizedString("LANG_VIEW3_TITLE", comment: ""))
                .tabItem {
                    Image(systemName: "r.circle")
                }
            TabPage(sourceUrl: NSLocalizedString("LANG_VIEW4_URL", comment: ""), pageTitle: NSLocalizedString("LANG_VIEW4_TITLE", comment: ""))
                .tabItem {
                    Image(systemName: "y.circle")
                }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

