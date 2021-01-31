//
//  CourseData.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/19/21.
//

import SwiftUI
import Contentful
import Combine

let client = Client (spaceId: "zpxy6yasa9nz", accessToken: "cJzu8CewhGV8WF1u2DvS0qnIjXdpK4f6wz-YbhAh4R0")

func getArray(id: String, completion: @escaping([Entry]) -> ())  {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query){ result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion (array.items)
            }
        case .failure(let failure):
            print(failure)
        }
    }
}

class courseData: ObservableObject {
    @Published var courses: [Course] = CourseData
    init(){
        let colors = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),]
        getArray(id: "course1") {(items) in
            items.forEach { (item) in
                self.courses.append(Course(
                                    title: item.fields["title"] as! String,
                                    subtitle: item.fields["subtitle"] as! String,
                                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                                    logo: #imageLiteral(resourceName: "Logo1"),
                                    color: colors.randomElement()!,
                                    show: false))
            
            }
        }
    }
}
