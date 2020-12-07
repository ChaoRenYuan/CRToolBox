//
//  ZLPhotoConfiguration.swift
//  ZLPhotoBrowser
//
//  Created by long on 2020/8/11.
//
//  Copyright (c) 2020 Long Zhang <longitachi@163.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import Photos

public typealias Second = Int

public class ZLPhotoConfiguration: NSObject {

    private static let single = ZLPhotoConfiguration()
    
    @objc public class func `default`() -> ZLPhotoConfiguration {
        return ZLPhotoConfiguration.single
    }
    
    /// Framework style.
    @objc public var style: ZLPhotoBrowserStyle = .embedAlbumList
    
    @objc public var statusBarStyle: UIStatusBarStyle = .lightContent
    
    /// Photo sorting method, the preview interface is not affected by this parameter.
    @objc public var sortAscending = true
    
    private var pri_maxSelectCount = 9
    /// Anything superior than 1 will enable the multiple selection feature. Default is 9.
    @objc public var maxSelectCount: Int {
        set {
            pri_maxSelectCount = max(1, newValue)
        }
        get {
            return pri_maxSelectCount
        }
    }
    
    /// Whether photos and videos can be selected together. Default is true.
    @objc public var allowMixSelect = true
    
    /// Preview selection max preview count, if the value is zero, only show `Camera`, `Album`, `Cancel` buttons.
    @objc public var maxPreviewCount = 20
    
    @objc public var cellCornerRadio: CGFloat = 0
    
    /// If set to false, gif and livephoto cannot be selected either.
    @objc public var allowSelectImage = true
    
    @objc public var allowSelectVideo = true
    
    /// Allow select Gif, it only controls whether it is displayed in Gif form.
    /// If value is false, the Gif logo is not displayed.
    @objc public var allowSelectGif = true
    
    /// Allow select LivePhoto, it only controls whether it is displayed in LivePhoto form.
    /// If value is false, the LivePhoto logo is not displayed.
    @objc public var allowSelectLivePhoto = false
    
    private var pri_allowTakePhotoInLibrary = true
    /// Allow take photos in the album.
    /// - warning: If allowTakePhoto and allowRecordVideo are both false, it will not be displayed.
    @objc public var allowTakePhotoInLibrary: Bool {
        set {
            pri_allowTakePhotoInLibrary = newValue
        }
        get {
            return pri_allowTakePhotoInLibrary && (allowTakePhoto || allowRecordVideo)
        }
    }
    
    @objc public var allowEditImage = true
    
    /// - warning: The video can only be edited when no photos are selected, or only one video is selected, and the selection callback is executed immediately after editing is completed.
    @objc public var allowEditVideo = false
    
    /// If true, you can slide select photos in album. Default is true.
    @objc public var allowSlideSelect = true
    
    /// If true, you can drag select photo when preview selection style. Default is false.
    @objc public var allowDragSelect = false
    
    /// Allow select full image. Default is true.
    @objc public var allowSelectOriginal = true
    
    /// Allow access to the preview large image interface (That is, whether to allow access to the large image interface after clicking the thumbnail image).
    @objc public var allowPreviewPhotos = true
    
    /// When iOS14 limited permission, whether to display more pictures.
    /// (PHPhotoLibrary.shared().presentLimitedLibraryPicker(:) method).
    @objc public var allowSelectMorePhotoWhenAuthIsLismited = true
    
    /// Whether to display the preview button (i.e. the preview button in the lower left corner of the thumbnail interface).
    @objc public var showPreviewButtonInAlbum = true
    
    private var pri_columnCount: Int = 4
    /// The column count when iPhone is in portait mode. Minimum is 2, maximum is 6. Default is 4.
    /// ```
    /// iPhone landscape mode: columnCount += 2.
    /// iPad portait mode: columnCount += 2.
    /// iPad landscape mode: columnCount += 4.
    /// ```
    @objc public var columnCount: Int {
        set {
            pri_columnCount = min(6, max(newValue, 2))
        }
        get {
            return pri_columnCount
        }
    }
    
    /// Maximum cropping time when editing video, unit: second. Default is 10.
    @objc public var maxEditVideoTime: Second = 10
    
    /// Allow to choose the maximum duration of the video.
    @objc public var maxSelectVideoDuration: Second = 120
    
    /// Allow to choose the minimum duration of the video.
    @objc public var minSelectVideoDuration: Second = 0
    
    private var pri_editImageTools: ZLEditImageViewController.EditImageTool = [.draw, .clip, .mosaic, .filter]
    /// Edit image tools. (Because swift OptionSet does not support @objc mark, this attribute oc is not available)
    public var editImageTools: ZLEditImageViewController.EditImageTool {
        set {
            pri_editImageTools = newValue
        }
        get {
            if pri_editImageTools.isEmpty {
                return [.draw, .clip, .mosaic, .filter]
            } else {
                return pri_editImageTools
            }
        }
    }
    
    private var pri_editImageDrawColors: [UIColor] = [.white, .black, zlRGB(241, 79, 79), zlRGB(243, 170, 78), zlRGB(80, 169, 56), zlRGB(30, 183, 243), zlRGB(139, 105, 234)]
    /// Draw colors for image editor.
    @objc public var editImageDrawColors: [UIColor] {
        set {
            pri_editImageDrawColors = newValue
        }
        get {
            if pri_editImageDrawColors.isEmpty {
                return [.white, .black, zlRGB(241, 79, 79), zlRGB(243, 170, 78), zlRGB(80, 169, 56), zlRGB(30, 183, 243), zlRGB(139, 105, 234)]
            } else {
                return pri_editImageDrawColors
            }
        }
    }
    
    /// The default draw color. If this color not in editImageDrawColors, will pick the first color in editImageDrawColors as the default.
    @objc public var editImageDefaultDrawColor = zlRGB(241, 79, 79)
    
    private var pri_editImageClipRatios: [ZLImageClipRatio] = [.custom]
    /// Edit ratios for image editor.
    @objc public var editImageClipRatios: [ZLImageClipRatio] {
        set {
            pri_editImageClipRatios = newValue
        }
        get {
            if pri_editImageClipRatios.isEmpty {
                return [.custom]
            } else {
                return pri_editImageClipRatios
            }
        }
    }
    
    private var pri_filters: [ZLFilter] = ZLFilter.all
    /// Filters for image editor.
    @objc public var filters: [ZLFilter] {
        set {
            pri_filters = newValue
        }
        get {
            if pri_filters.isEmpty {
                return ZLFilter.all
            } else {
                return pri_filters
            }
        }
    }
    
    /// After selecting a image/video in the thumbnail interface, enter the editing interface directly.
    /// - discussion: Editing image is only valid when allowEditImage is true and maxSelectCount is 1.
    /// Editing video is only valid when allowEditVideo is true and maxSelectCount is 1.
    @objc public var editAfterSelectThumbnailImage = false
    
    /// If image edit tools only has clip and this property is true. When you click edit, the cropping interface (i.e. ZLClipImageViewController) will be displayed. Default is false
    @objc public var showClipDirectlyIfOnlyHasClipTool = false
    
    /// Save the edited image to the album after editing.
    @objc public var saveNewImageAfterEdit = true
    
    /// Show the image captured by the camera is displayed on the camera button inside the album.
    @objc public var showCaptureImageOnTakePhotoBtn = false
    
    /// In single selection mode, whether to display the selection button.
    @objc public var showSelectBtnWhenSingleSelect = false
    
    /// Overlay a mask layer on top of the selected photos.
    @objc public var showSelectedMask = true
    
    /// Display a border on the selected photos cell.
    @objc public var showSelectedBorder = false
    
    /// Overlay a mask layer above the cells that cannot be selected.
    @objc public var showInvalidMask = true
    
    /// Display the index of the selected photos.
    @objc public var showSelectedIndex = true
    
    /// Display the selected photos at the bottom of the preview large photos interface.
    @objc public var showSelectedPhotoPreview = true
    
    /// Developers can customize iamges, but the name of the custom image resource must be consistent with the image name in the replaced bundle.
    /// - example: Developers need to replace the selected and unselected image resources, and the array that needs to be passed in is
    /// ["zl_btn_selected", "zl_btn_unselected"].
    @objc public var customImageNames: [String] = [] {
        didSet {
            ZLCustomImageDeploy.deploy = self.customImageNames
        }
    }
    
    /// Allow framework fetch photos when callback. Default is true.
    @objc public var shouldAnialysisAsset = true
    
    /// Timeout for image parsing.
    @objc public var timeout: TimeInterval = 20
    
    /// Language for framework.
    @objc public var languageType: ZLLanguageType = .system {
        didSet {
            ZLCustomLanguageDeploy.language = self.languageType
            Bundle.resetLanguage()
        }
    }
    
    /// Developers can customize languages (This property is only for objc).
    /// - example: If you needs to replace
    /// key: @"loading", value: @"loading, waiting please" language,
    /// The dictionary that needs to be passed in is @[@"loading": @"text to be replaced"].
    /// - warning: Please pay attention to the placeholders contained in languages when changing, such as %ld, %@.
    @objc public var customLanguageKeyValue_objc: [String: String] = [:] {
        didSet {
            var swiftParams: [ZLLocalLanguageKey: String] = [:]
            customLanguageKeyValue_objc.forEach { (key, value) in
                swiftParams[ZLLocalLanguageKey(rawValue: key)] = value
            }
            self.customLanguageKeyValue = swiftParams
        }
    }
    
    /// Developers can customize languages.
    /// - example: If you needs to replace
    /// key: .loading, value: "loading, waiting please" language,
    /// The dictionary that needs to be passed in is [.loading: "text to be replaced"].
    /// - warning: Please pay attention to the placeholders contained in languages when changing, such as %ld, %@.
    public var customLanguageKeyValue: [ZLLocalLanguageKey: String] = [:] {
        didSet {
            ZLCustomLanguageDeploy.deploy = self.customLanguageKeyValue
        }
    }
    
    /// Whether to use custom camera.
    @objc public var useCustomCamera = true
    
    private var pri_allowTakePhoto = true
    /// Allow taking photos in the camera (Need allowSelectImage to be true).
    @objc public var allowTakePhoto: Bool {
        set {
            pri_allowTakePhoto = newValue
        }
        get {
            return pri_allowTakePhoto && allowSelectImage
        }
    }
    
    private var pri_allowRecordVideo = true
    /// Allow recording in the camera (Need allowSelectVideo to be true).
    @objc public var allowRecordVideo: Bool {
        set {
            pri_allowRecordVideo = newValue
        }
        get {
            return pri_allowRecordVideo && allowSelectVideo
        }
    }
    
    private var pri_minRecordDuration: Second = 0
    /// Minimum recording duration. Default is 0.
    @objc public var minRecordDuration: Second {
        set {
            pri_minRecordDuration = max(0, newValue)
        }
        get {
            return pri_minRecordDuration
        }
    }
    
    private var pri_maxRecordDuration: Second = 10
    /// Maximum recording duration. Default is 10, minimum is 1.
    @objc public var maxRecordDuration: Second {
        set {
            pri_maxRecordDuration = max(1, newValue)
        }
        get {
            return pri_maxRecordDuration
        }
    }
    
    /// Video resolution.
    @objc public var sessionPreset: ZLCustomCamera.CaptureSessionPreset = .hd1280x720
    
    /// Video export format for recording video and editing video.
    @objc public var videoExportType: ZLCustomCamera.VideoExportType = .mov
    
    /// Camera flahs mode. Default is off.
    @objc public var cameraFlashMode: ZLCustomCamera.CameraFlashMode = .off
    
    /// Hud style. Default is lightBlur.
    @objc public var hudStyle: ZLProgressHUD.HUDStyle = .lightBlur
    
    /// Navigation bar blur effect.
    @objc public var navViewBlurEffect: UIBlurEffect? = UIBlurEffect(style: .dark)
    
    /// Bottom too bar blur effect.
    @objc public var bottomToolViewBlurEffect: UIBlurEffect? = UIBlurEffect(style: .dark)
    
    /// Color configuration for framework.
    @objc public var themeColorDeploy: ZLPhotoThemeColorDeploy = .default()
    
    /// Font name.
    @objc public var themeFontName: String? = nil {
        didSet {
            ZLCustomFontDeploy.fontName = self.themeFontName
        }
    }
    
    /// This block will be called before selecting an image, the developer can first determine whether the asset is allowed to be selected.
    /// Only control whether it is allowed to be selected, and will not affect the selection logic in the framework.
    /// - Tips: If the choice is not allowed, the developer can toast prompt the user for relevant information.
    @objc public var canSelectAsset: ( (PHAsset) -> Bool )?
    
}


@objc public enum ZLPhotoBrowserStyle: Int {
    
    /// The album list is embedded in the navigation of the thumbnail interface, click the drop-down display.
    case embedAlbumList
    
    /// The display relationship between the album list and the thumbnail interface is push.
    case externalAlbumList
    
}


/// Color deploy
public class ZLPhotoThemeColorDeploy: NSObject {
    
    @objc public class func `default`() -> ZLPhotoThemeColorDeploy {
        return ZLPhotoThemeColorDeploy()
    }
    
    /// Preview selection mode, transparent background color above.
    @objc public var previewBgColor = UIColor.black.withAlphaComponent(0.1)
    
    /// Preview selection mode, a background color for `Camera`, `Album`, `Cancel` buttons.
    @objc public var previewBtnBgColor = UIColor.white
    
    /// Preview selection mode, a text color for `Camera`, `Album`, `Cancel` buttons.
    @objc public var previewBtnTitleColor = UIColor.black
    
    /// Preview selection mode, cancel button title color when the selection amount is superior than 0.
    @objc public var previewBtnHighlightTitleColor = zlRGB(80, 169, 56)
    
    /// A color for navigation bar spinner.
    @objc public var navBarColor = zlRGB(160, 160, 160).withAlphaComponent(0.65)
    
    /// A color for Navigation bar text.
    @objc public var navTitleColor = UIColor.white
    
    /// The background color of the title view when the frame style is embedAlbumList.
    @objc public var navEmbedTitleViewBgColor = zlRGB(80, 80, 80)
    
    /// A color for background in album list.
    @objc public var albumListBgColor = zlRGB(45, 45, 45)
    
    /// A color for album list title label.
    @objc public var albumListTitleColor = UIColor.white
    
    /// A color for album list count label.
    @objc public var albumListCountColor = zlRGB(180, 180, 180)
    
    /// A color for album list separator.
    @objc public var separatorColor = zlRGB(60, 60, 60)
    
    /// A color for background in thumbnail interface.
    @objc public var thumbnailBgColor = zlRGB(50, 50, 50)
    
    /// A color for background in bottom tool view.
    @objc public var bottomToolViewBgColor = zlRGB(35, 35, 35).withAlphaComponent(0.3)
    
    /// The normal state title color of bottom tool view buttons.
    @objc public var bottomToolViewBtnNormalTitleColor = UIColor.white
    
    /// The disable state title color of bottom tool view buttons.
    @objc public var bottomToolViewBtnDisableTitleColor = zlRGB(168, 168, 168)
    
    /// The normal state background color of bottom tool view buttons.
    @objc public var bottomToolViewBtnNormalBgColor = zlRGB(80, 169, 56)
    
    /// The disable state background color of bottom tool view buttons.
    @objc public var bottomToolViewBtnDisableBgColor = zlRGB(50, 50, 50)
    
    /// With iOS14 limited authority, a color for select more photos at the bottom of the thumbnail interface.
    @objc public var selectMorePhotoWhenAuthIsLismitedTitleColor = UIColor.white
    
    /// The record progress color of custom camera.
    @objc public var cameraRecodeProgressColor = zlRGB(80, 169, 56)
    
    /// Mask layer color of selected cell.
    @objc public var selectedMaskColor = UIColor.black.withAlphaComponent(0.2)
    
    /// Border color of selected cell.
    @objc public var selectedBorderColor = zlRGB(80, 169, 56)
    
    /// Mask layer color of the cell that cannot be selected.
    @objc public var invalidMaskColor = UIColor.white.withAlphaComponent(0.5)
    
    /// The background color of selected cell index label.
    @objc public var indexLabelBgColor = zlRGB(80, 169, 56)
    
    /// The background color of camera cell inside album.
    @objc public var cameraCellBgColor = UIColor(white: 0.3, alpha: 1)
    
}


/// Font deply
struct ZLCustomFontDeploy {
    
    static var fontName: String? = nil
    
}


/// Language deploy
struct ZLCustomLanguageDeploy {
    
    static var language: ZLLanguageType = .system
    
    static var deploy: [ZLLocalLanguageKey: String] = [:]
    
}


/// Image source deploy
struct ZLCustomImageDeploy {
    
    static var deploy: [String] = []
    
}
