//
//  NoNotesView.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 20.12.21.
//

import SwiftUI

struct NoNotesView: View {
    var body: some View {
        VStack {
            Text("No notes Available!!!")
                .padding(50)
                .background(.white)
                .cornerRadius(20)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color("colorAccentDark"))
        }
    }
}

struct NoNotesView_Previews: PreviewProvider {
    static var previews: some View {
        NoNotesView()
            .previewLayout(.sizeThatFits)
    }
}
