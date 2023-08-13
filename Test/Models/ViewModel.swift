//
//  TestViewModel.swift
//  Test
//
//  Created by Adam Wareing on 11/8/2023.
//

import UIKit

/// Model for storing a section and its contents
struct SectionDTO<Section, Item> {
    
    var section: Section
    var content: [Item] = []
    
}

/// Generic view model that stores a list of sections and their data
class ViewModel<SectionIdentifierType: Hashable, ItemIdentifierType: Hashable> {
    
    typealias Section = SectionDTO<SectionIdentifierType, ItemIdentifierType>
    var sections: [Section] = []

    func build(@ViewModelBuilder<Section> _ builder: () -> [Section])  {
        self.sections = builder()
    }
    
    func section(_ section: SectionIdentifierType, @ViewModelBuilder<ItemIdentifierType> _ builder: () -> [ItemIdentifierType]) -> Section {
        Section(section: section, content: builder())
    }
    
    func snapshot() -> NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> {
        var snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>()
        
        // Add sections
        snapshot.appendSections(sections.map { $0.section })
        
        // Add items
        sections.forEach { model in
            snapshot.appendItems(model.content, toSection: model.section)
        }
        return snapshot
    }
    
    func debugString() -> String {
        sections.reduce("", {
            $0 + "\($1.section) section: \($1.content)"
        })
    }
}

/// Result builder for constructing section items
@resultBuilder
struct ViewModelBuilder<T> {
    
    static func buildEither(first component: [T]) -> [T] {
        return component
    }
    
    static func buildEither(second component: [T]) -> [T] {
        return component
    }
    
    static func buildOptional(_ component: [T]?) -> [T] {
        return component ?? []
    }
    
    static func buildExpression(_ expression: T) -> [T] {
        return [expression]
    }
    
    static func buildExpression(_ expression: ()) -> [T] {
        return []
    }
    
    static func buildBlock(_ components: [T]...) -> [T] {
        return components.flatMap { $0 }
    }
    
    static func buildArray(_ components: [[T]]) -> [T] {
        Array(components.joined())
    }
}
