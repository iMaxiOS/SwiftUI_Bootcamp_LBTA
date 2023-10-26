//
//  DownloadingImageRow.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import SwiftUI

struct DownloadingImageRow: View {
    var model: ImageResponse
    
    var body: some View {
        HStack {
            DownloadingImageView(url: model.urlString, imageKey: "\(model.id)")
                .frame(width: 70, height: 70)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                    .foregroundStyle(.black)
                Text(model.urlString)
                    .foregroundStyle(.gray)
                    .font(.system(size: 10))
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DownloadingImageRow(
        model: .init(
            albumId: 1, id: 1,
            title: "title",
            url: URL(string: "DownloadingImageView"),
            thumbnailUrl: URL(string: "www")
        )
    )
}
