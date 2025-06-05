//
//  DeteiledCellSwiftUIView.swift
//  SwiftUICells
//
//  Created by Aleksandr on 04.06.2025.
//

import SwiftUI

struct DeteiledCellSwiftUIView: View {
    @ObservedObject var user: User
    var onSave: () -> Void
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Circle()
                    .fill( user.isPremium ?
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.4),
                                Color.blue.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing

                        ) :
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.4),
                                Color.gray.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 80)
                    .overlay {
                        Text(String(user.name.prefix(2)))
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                    }
                Text(user.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField("Enter name", text: $user.name)
                    .font(.headline)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                    )
                Text("Age: \(user.age)")
                DatePickerUIKit(age: $user.age)
                    .frame(height: 50)
                Toggle("Premium User", isOn: $user.isPremium)
                    .font(.headline)
                    .padding(.top, 8)
                Text(user.isPremium ? "🔥 Full Access to all features" : "👤 Limited Access mode")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
                Button(action: {
                    onSave()
                }) {
                    Text("Save")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor.systemBlue))
                        )
                }
                .padding(.top, 24)
            }
            .padding(20)
        }
    }
}

//#Preview {
//    let user = User(id: 1, name: "Alex", age: 22, isPremium: true)
//    DeteiledCellSwiftUIView(user: .constant(user), onSave: {})
//}
