import SwiftUI

extension View {
    func onSizeChange(perform action: @escaping (CGSize) -> ()) -> some View {
        modifier(SizeReader(onChange: action))
    }
}

private struct SizeReader: ViewModifier {
    var onChange: (CGSize) -> ()
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometry.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
