//
//  UpdateNoteScreen.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 20.12.21.
//

import SwiftUI

struct UpdateNoteScreen: View {
    
    let note: NoteEntity
    @StateObject var notesVM = NoteViewModel()
    @State private var showingAlert = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var newTitle = ""
    @State private var newBody = ""
    @Environment(\.presentationMode) var presentationMode
    
   
    
    var body: some View {
        Group{
            VStack (spacing: 0){
                TextField(note.noteTitle ?? " ", text: $newTitle)
                    .font(.system(size: 20, weight: .bold))
                    .disableAutocorrection(true)
                    .padding(.horizontal, 4)
                    .foregroundColor(.white)
                    .onAppear {
                        self.newTitle = self.note.noteTitle != nil ? "\(self.note.noteTitle!)" : ""
                    }
                    
                TextEditor(text: $newBody)
                    .foregroundColor(.white)
                    .font(Font.custom("Noteworthy", size: 20, relativeTo: .body))
                    .cornerRadius(20)
                    .background(Color("colorAccentDark"))
                    .onAppear {
                        self.newBody = self.note.noteBody != nil ? "\(self.note.noteBody!)" : ""
                    }
                  
            }.padding(20)
            
                    
            Button("Save"){
                
                if newTitle != "" || newBody != "" {
                    self.note.noteTitle = newTitle
                    self.note.noteBody = newBody
                    self.notesVM.updateNote()
                    presentationMode.wrappedValue.dismiss()
                    
                }else {
                    self.showingAlert = true
                    self.errorTitle = "Invalid Title"
                    self.errorMessage = "Make sure to enter something at least for\nthe title or description!"
                    return
                }
                
                
            }.frame(width: 150, height: 50, alignment: .center)
            .padding(0)
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(Color("colorAccentDark"))
            .background(.white)
            .cornerRadius(20)
            .padding(.bottom, 20)
                 
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("colorAccentDark"))
        .navigationTitle("Add Note")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
       
           
    }
}


struct UpdateNoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let note = NoteEntity()
        
        
        UpdateNoteScreen(note: note)
    }
}
