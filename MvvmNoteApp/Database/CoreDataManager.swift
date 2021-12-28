//
//  CoreDataManager.swift
//  MvvmNoteApp
//
//  Created by Isaias Cuvula on 21.12.21.
//

import Foundation
import CoreData


class CoreDataManager {
    
    let container: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    
    //MARK: - INITIALIZE CORE DATA
    private init(){
        container = NSPersistentContainer(name: "Notedb")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack: \(error)")
            }
        }
    }
    
    //MARK: - GET CONTEXT
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    
    //MARK: - GET ALL DATA
    func getAllNotes() -> [NoteEntity] {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NoteEntity.noteDate, ascending: false)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    
    //MARK: - SAVE NOTE
    func saveNotes() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    
    //MARK: - DELETE NOTE
    func deleteNote(note: NoteEntity){
        viewContext.delete(note)
        saveNotes()
    }
    
    //MARK: - GET DATA BY ID
    func getNoteById(id: NSManagedObjectID) -> NoteEntity? {
        
        do {
            return try viewContext.existingObject(with: id) as? NoteEntity
            
        } catch {
            return nil
        }
    }
    
    
    //MARK: - UPDATE
    func updateNote() {
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    
}



