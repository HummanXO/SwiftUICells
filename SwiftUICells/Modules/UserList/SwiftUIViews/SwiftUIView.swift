//
//  SwiftUIView.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import SwiftUI

struct SwiftUIView: View {
    @ObservedObject var user: User
    var body: some View {
        HStack {
            Group {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.4),
                                Color.blue.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        Text(String(user.name.prefix(2)))
                            .font(.headline)
                            .font(.system(size: 16, weight: .bold))
                    )
                    .frame(width: 60)
                    .padding(.leading, 16)
                    .padding(.trailing, 12)
                VStack(spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text("Age: \(user.age)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(user.isPremium ? "🔥 Premium" : "👤 Free")
                        .frame(width: 80)
                        .font(user.isPremium ? .caption : .footnote)
                        .foregroundStyle(user.isPremium ? .green : .gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(user.isPremium ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
                        )
                }
            }
            Spacer()
            Text(Image(systemName: "chevron.right"))
                .padding(.trailing, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: 72)
    }
}

//#Preview {
//    let user = User(id: 1, name: "Alex", age: 22, isPremium: true)
//    SwiftUIView(user: .constant(user))
//}
