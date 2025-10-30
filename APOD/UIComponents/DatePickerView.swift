//
//  DatePickerView.swift
//  APOD
//
//  Created by Anie Parameswaran on 27/10/2025.
//

import SwiftUI

// MARK: - DatePickerView

struct DatePickerView: View {
    @Binding var selectedDate: Date
    var title: String = "Select Date"
    var action: (() -> Void)? = nil
    var dateFormat: String = "dd MMM yyyy"

    @State private var showPicker = false

    var body: some View {
        self.button
        .sheet(isPresented: $showPicker, onDismiss: {
            action?()
        }) {
            self.content
        }
    }
    
    private var button: some View {
        Button {
            showPicker = true
        } label: {
            HStack {
                Text("\(title): \(selectedDate.formatted(dateFormat))")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "calendar")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5))
            )
        }
    }
    
    private var content: some View {
        VStack {
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .labelsHidden()

            Button("Done") {
                showPicker = false
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
