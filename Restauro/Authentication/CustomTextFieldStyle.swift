//
//  CustomTextFieldStyle.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import Foundation
import SwiftUI

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.primary.opacity(0.5), lineWidth: 1))
    }
}
