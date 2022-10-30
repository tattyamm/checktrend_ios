import SwiftUI

struct DetailView: View {
    var urlString: String = "url default"

    var body: some View {
        WebView(urlString: urlString)
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        if let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Image(systemName: "safari")
                    }
                }
                
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
