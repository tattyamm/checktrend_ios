import SwiftUI

struct ApiJson: Decodable {
    var value: ApiJsonValues
}
struct ApiJsonValues: Decodable {
    var title: String
    var link: String
    var description: String
    var items:[TrendItems]
}
struct TrendItems: Decodable, Identifiable {
    var id: String
    let title: String
    let link: String
    let pubDate: String
    let description: String?
}


struct TabPage: View {
    var sourceUrl: String = "https://checktrend-rails.onrender.com/api/trend/google.json"
    var pageTitle: String = "ページ上部のタイトル"
    @State private var articles = [TrendItems(id:"loading", title:NSLocalizedString("MESSAGE_LOADING", comment: ""), link:"", pubDate:"", description: "")]
    
    var body: some View {
        
        NavigationView {
            List(articles) { article in
                VStack(alignment: .leading) {
                    NavigationLink(destination: DetailView(urlString: article.link)) {
                        VStack(alignment: .leading) {
                            Text(article.title)
                                .font(.headline)
                            Text(article.description ?? "")
                                .font(.body)
                                .lineLimit(1)
                        }
                    }
                }
            }
            .navigationTitle(pageTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        articles = [TrendItems(id:"loading", title:NSLocalizedString("MESSAGE_LOADING", comment: ""), link:"", pubDate:"", description: "")]
                        Task {
                            await getArticles()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise") //https://hotpot.ai/free-icons?s=sfSymbols
                    }
                }
                
            }
        }
        .task {
            await getArticles()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getArticles() async {
        do {
            guard let url = URL(string: sourceUrl) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let apiall = try JSONDecoder().decode(ApiJson.self, from: data)
            articles = apiall.value.items
        } catch {
            print("ERROR: \(error)")
            articles = [TrendItems(id:"loading", title:NSLocalizedString("MESSAGE_ERROR", comment: ""), link:"", pubDate:"", description: "")]
        }
    }

}

