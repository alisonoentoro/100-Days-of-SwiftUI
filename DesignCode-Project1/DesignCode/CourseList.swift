//
//  CourseList.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/14/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @ObservedObject var store = courseData()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    
    
    
    var body: some View{
        GeometryReader { bounds in
            ZStack {
                Color.black.opacity(Double(self.activeView.height/500))
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                    
                ScrollView {
                    VStack (spacing: 30) {
                        Text("Courses")
                            .font(.largeTitle).bold()
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            .blur(radius: self.active ? 20 : 0)
                        
                        ForEach(store.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                CourseView(
                                    show: self.$store.courses[index].show,
                                    Course: self.store.courses[index],
                                    active: self.$active,
                                    index: index,
                                    activeIndex: self.$activeIndex,
                                    activeView: self.$activeView,
                                    bounds: bounds,
                                    isScrollable: self.$isScrollable
                                )
                                .offset(y: self.store.courses[index].show ? -geometry.frame(in:.global).minY : 0)
                                    .opacity(self.activeIndex != index && self.active ? 0:1)
                                    .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)

                            }
                            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
                            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
                            .zIndex(self.store.courses[index].show ? 1 : 0)

                        }
                    }
                    .frame(width: bounds.size.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
                .statusBar(hidden: active ? true : false)
                .animation(.linear)
                .disabled(self.active && !self.isScrollable ? true : false)
            }
        }
    }
}
func getCardWidth(bounds: GeometryProxy) -> CGFloat{
    if bounds.size.width > 712 {
        return 712
    }
    return bounds.size.width - 60
}

func getCardCornerRadius (bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 {
        return 0
    }
    return 30
}
struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
       CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    var Course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    var bounds: GeometryProxy
    @Binding var isScrollable: Bool


    var body: some View {
        ZStack(alignment:.top) {
            VStack (alignment: .leading, spacing: 30.0){
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About This Course")
                    .font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                
                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
                
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment:.top)
            .offset(y: show ? 460 : 0 )
            .background(Color("background2"))
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2),radius: 20, x: 0, y:20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack (alignment:.top){
                    VStack(alignment: .leading, spacing:8) {
                        Text(Course.title)
                            .font(.system(size: 24, weight:.bold))
                            .foregroundColor(Color.white)
                        Text(Course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: Course.logo)
                            .opacity(show ? 0:1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        .offset(x: 2, y: -2)
                    }
                }
                Spacer ()
                
                WebImage(url: Course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(Course.color))
            .clipShape(RoundedRectangle( cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color(Course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(
                show ?
                DragGesture()
                    .onChanged { value in
                        guard value.translation.height > 0 else { return }
                        guard value.translation.height < 300 else { return }
                        
                     self.activeView = value.translation
                }
                .onEnded { value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                    }
                    self.activeView = .zero
                }
                :nil
            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                
                if self.show{
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.isScrollable = true
                }
            }
            if isScrollable{
                CourseDetail(course: Course, show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                        .background(Color("background1"))
                        .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
                        .animation(nil)
                        .transition(.identity)
            }
            
        }
        .frame(height: show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height)/10), axis: (x: 0, y: 10, z: 0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ?
            DragGesture().onChanged { value in
                guard value.translation.height < 300 else { return }
                guard value.translation.height > 50 else { return }
                
                self.activeView = value.translation
            }
            .onEnded { value in
                if self.activeView.height > 50 {
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                    self.isScrollable = false
                }
                self.activeView = .zero
            }
            : nil
        )
        .disabled(active && !isScrollable ? true : false)
        .edgesIgnoringSafeArea(.all)
    }
}
struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var CourseData = [
    Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/i08umta02pa09ns/Card3%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "UI Design for Developers", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/etdzsafqqeq0jjg/Card6%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
