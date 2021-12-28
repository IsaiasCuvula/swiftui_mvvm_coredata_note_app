//
//  AddNoteScreen.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 20.12.21.
//

import SwiftUI

struct AddNoteScreen: View {
    
    @StateObject private var notesVM = NoteViewModel()
    @State private var showingAlert = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    
    init(){
        
        //Usado so para poder trocar a cor defaulf TextEditor
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        Group{
            VStack (spacing: 0){
                TextField("Type your title", text: $notesVM.noteTitle)
                    .font(.system(size: 20, weight: .bold))
                    .disableAutocorrection(true)
                    .padding(.horizontal, 4)
                    .foregroundColor(.white)
                    
                    
                TextEditor(text: $notesVM.noteBody)
                    .foregroundColor(.white)
                    .font(Font.custom("Noteworthy", size: 20, relativeTo: .body))
                    .cornerRadius(20)
                    .background(Color("colorAccentDark"))
                  
                    
                }.padding(20)
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color("colorAccentDark"))
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink (destination: ContentView().navigationBarHidden(true), label: {
                        
                        Text("Save")
                        
                    }).padding(.horizontal)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .simultaneousGesture(TapGesture().onEnded{
                            if notesVM.noteTitle != "" || notesVM.noteBody != "" {
                                notesVM.saveNote()
                            }else {
                                self.showingAlert = true
                                self.errorTitle = "Invalid Title"
                                self.errorMessage = "Make sure to enter something at least for\nthe title or description!"
                                return
                            }
                        }).alert(isPresented: $showingAlert) {
                            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                        
                }
            }//TOOLBAR
    }
}

struct AddNoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteScreen()
            
    }
}
