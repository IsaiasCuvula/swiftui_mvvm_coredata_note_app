//
//  ContentView.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 20.12.21.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject var notesVM = NoteViewModel()
    @State private var showingAddScreen = false
    @State var dataInitiallyFetched = false
    @State private var refreshing: Bool = false
   
  
   
    
    private let gridLayout: [GridItem] = Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    
    
    
    var body: some View {
        
        NavigationView {
            
            Group{
                
                VStack {
                    HStack {
                        Text("Note App")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        NavigationLink{
                            AddNoteScreen()
                            
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }.frame(width: 30, height: 30)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        
                    }//HSTACK
                    
                    Spacer()
                    
                    if notesVM.notes.isEmpty {
                        
                        NoNotesView()
                        Spacer()
                        
                    }else{
                        List {
                            ForEach(notesVM.notes, id: \.id){ note in
                               
                                NavigationLink{
                                    ReadingNoteView(note: note.note)
                                } label: {
                                    NoteView(note: note.note)
                                }
                                
                            }.onDelete { index in
                                notesVM.deletenote(at: index)
                            }
                        }.refreshable{
                            self.notesVM.getAllNotes()
                        }
                        
                    }
                    
                }//VSTACK
                .frame(maxWidth: .infinity,  maxHeight: .infinity)
                .background(Color("colorAccentDark"))
                
            }//GROUP
            .navigationBarHidden(true)
            
           
        }//NAV
        .onAppear() {
            self.notesVM.getAllNotes()
            
        }.navigationViewStyle(.stack)
              
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
