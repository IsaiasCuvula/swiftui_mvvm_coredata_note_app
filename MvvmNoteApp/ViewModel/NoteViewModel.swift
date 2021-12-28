//
//  NoteViewModel.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 21.12.21.
//

import Foundation
import CoreData
import SwiftUI


class NoteViewModel: ObservableObject {
    
    @Published var notes: [NoteViewModelData] = []
    
    var noteTitle: String = ""
    var noteBody: String = ""
    
    
    func getAllNotes(){
        notes = CoreDataManager.shared.getAllNotes().map(NoteViewModelData.init)
    }
   
    func saveNote() {
        
        let note = NoteEntity(context: CoreDataManager.shared.viewContext)
        note.id = UUID()
        note.noteDate = Date()
        note.noteTitle = noteTitle
        note.noteBody = noteBody
       
        
        CoreDataManager.shared.saveNotes()
        noteTitle = ""
        noteBody = ""
       
        
        //To update the view with new note
        getAllNotes()
    
    }
    
    
    //MARK:- DELETE NOTE
    private func deleteNote(_ note: NoteViewModelData){
        let existingNote = CoreDataManager.shared.getNoteById(id: note.id)
        
        if let existingNote = existingNote {
            CoreDataManager.shared.deleteNote(note: existingNote)
        
        }
    }
    
    
     func deletenote(at offsets: IndexSet){
         withAnimation {
             offsets.forEach{ index in
                 let note = notes[index]
                 deleteNote(note)
             }
              
             getAllNotes()
         }
    }
    
    
    
    //MARK: - UPADTE NOTE
    func updateNote(){
        CoreDataManager.shared.updateNote()
        getAllNotes()
    }
    

    
}

struct NoteViewModelData {
    
    let note: NoteEntity
    
    var id: NSManagedObjectID {
        return note.objectID
    }
    
    var noteTitle: String {
        return note.noteTitle ?? ""
    }
    
    
    var noteBody: String {
        return note.noteBody ?? ""
    }
    
    
    var noteDate: Date {
        return note.noteDate ?? Date()
    }
    
    
}
