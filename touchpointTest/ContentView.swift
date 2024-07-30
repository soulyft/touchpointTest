import SwiftUI


struct ContentView: View {
    @State var touchVM: TouchViewModel = TouchViewModel()

    var body: some View {
        MultiTouchView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environment(touchVM)
    }
}






#Preview {
    ContentView()
}
