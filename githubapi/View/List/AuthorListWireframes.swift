//
//  AuthorListWireframes.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation
protocol GitAuthorView: class {
    
}

protocol GitAuthorViewModel {
    var delegate: GitAuthorView? { get set }
}
