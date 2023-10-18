//
//  ContentView.swift
//  practice_app
//
//  Created by Koguchi on 2023/09/26.
//

import SwiftUI

struct ContentView: View {
    private let appTitle = "シンプルメモ"
    private let maxLength = 500
    @AppStorage("memo") private var storedMemo: String = ""
    @State private var memo = ""
    @State private var isShowAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 70)
                Text("\(memo.count) / \(maxLength)")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $memo)
                    .onAppear {
                        memo = String(storedMemo.prefix(maxLength))
                    }
                    .onChange(of: memo) { newValue in
                        if newValue.count > maxLength {
                            memo = String(newValue.prefix(maxLength))
                        }
                        storedMemo = newValue
                    }
                    .padding()
                    .scrollContentBackground(.hidden)
                    .frame(height: 400)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary.opacity(1), lineWidth: 0.5)
                    }
                Button {
                    isShowAlert = true
                } label: {
                    Text("全て削除")
                }
                .alert("メモの削除", isPresented: $isShowAlert) {
                    Button("キャンセル", role: .cancel){}
                    Button("削除する", role: .destructive){
                        memo = ""
                        storedMemo = ""
                    }
                } message: {
                    Text("メモ欄が全て削除されます")
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text(appTitle))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
