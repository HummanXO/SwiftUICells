//
//  SwiftUIView.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import SwiftUI

struct SwiftUICellView: View {
    @Binding var user: User
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.name)
                    .font(.headline)
                Spacer()
                Text(user.isPremium ? "🔥 Premium" : "👤 Free")
                    .padding(4)
                    .font(.caption)
                    .bold()
                    .foregroundStyle(user.isPremium ? .green : .gray)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(user.isPremium ? .green.opacity(0.2) : .gray.opacity(0.2))
                    )
            }
            Spacer()
            HStack{
                Spacer()
                Toggle("", isOn: $user.isPremium)
                    .labelsHidden()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 44)
        .padding()
    }
}

#Preview {
    let user = User(name: "Alex", isPremium: true)
    SwiftUICellView(user: .constant(user))
}
