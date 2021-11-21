//
//  MVVMSwiftUI.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 20/11/2564 BE.
//



import SwiftUI

struct MMVMSWiftUI: View {

    @ObservedObject var viewModel: MVVMAdapter

    var body: some View {
        VStack {
            List(viewModel.models.indices, id: \.self) { index in
                HStack {
                    Text("Hello, \(viewModel.models[index].name) -- \(viewModel.models[index].counter)")
                        .redHeadline()
                    Spacer()
                    Button("Update") {
                        viewModel.update(at: index)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}

extension View {
    func redHeadline() -> some View {
        self
            .modifier(RedHeadlineModifer())
    }
}

struct RedHeadlineModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.red)
    }
}

//
//struct MVVMSwiftUI_Previews: PreviewProvider {
//    static var previews: some View {
//        MMVMSWiftUI()
//    }
//}


/*import SwiftUI

class MVVMSVM: ObservableObject {
    private let database = Database()

    @Published var models: [MVVMModel] = []

    func fetch() {
        let data = database.retrieve()

        self.models = data.compactMap {
            MVVMModel(name: $0.name, counter: 0)
        }
    }

    func update(at index: Int) {
        models[index].counter += 1
    }
}

struct MVVMSwiftUI: View {

    @StateObject var viewModel = MVVMSVM()

    var body: some View {
        VStack {
            List(viewModel.models.indices, id: \.self) { index in
                HStack {
                    Text("Hello, \(viewModel.models[index].name) -- \(viewModel.models[index].counter)")
                    Spacer()
                    Button("Update") {
                        viewModel.update(at: index)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct MVVMSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        MVVMSwiftUI()
    }
}
*/
