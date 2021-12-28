//
//  NoteView.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 20.12.21.
//

import SwiftUI

struct NoteView: View {
    
    let note: NoteEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("")
                    .frame(width: 6, height: 6)
                    .background(Color("colorAccentDark"))
                    .cornerRadius(20)
                
                //Spacer()
                
                Text(note.noteTitle ?? "")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("colorAccentDark"))
                
                
            }//HSTACK
            
            Text(note.noteBody ?? "" )
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(Color("colorAccentDark"))
                .font(Font.custom("Noteworthy", size: 16))
        }.padding(10)
            .background(.white)
            .cornerRadius(16)
    }
}

/*
struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        
        let noteVM = NoteViewModel().notes[0]
        
        NoteView(note: noteVM.note)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}*/
