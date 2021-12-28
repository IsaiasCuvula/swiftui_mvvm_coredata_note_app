//
//  ReadingNoteView.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 21.12.21.
//

import SwiftUI

struct ReadingNoteView: View {
    
    let note: NoteEntity
    @StateObject var noteVM = NoteViewModel()
    @State private var showingUpdateNote: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding
   
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(note.noteTitle ?? "")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .padding(.bottom, 10)
                .foregroundColor(.white)
                
            
            Text(note.noteBody ?? "")
                .font(Font.custom("Noteworthy", size: 20, relativeTo: .body))
                .padding(0)
                .foregroundColor(.white)
            Spacer()
            
            Text("Created at: \(note.noteDate!, formatter: itemFormatter)")
                .font(.system(size: 18, weight: .light, design: .rounded))
                .padding(.bottom, 10)
                .padding(.top, 10)
                .foregroundColor(.white)
            
        }//VSTACK
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color("colorAccentDark"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                
                Menu("More"){
                    
                    Button("Edit"){
                        self.showingUpdateNote = true
                    }

                    
                    Button("Share") {
                     //
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: $showingUpdateNote, onDismiss: {
            noteVM.getAllNotes()
        }) {
            UpdateNoteScreen(note: note)
        }.navigationBarTitleDisplayMode(.inline)
            .onDisappear() {
                if(self.presentationMode.wrappedValue.isPresented == false) {
                    self.noteVM.getAllNotes()
                    print("You click the back button")
                }

            }
        
    }
     
   
}


struct ReadingNoteView_Previews: PreviewProvider {
    static var previews: some View {
 
        let note = NoteEntity()
        ReadingNoteView(note: note)
    }
}

