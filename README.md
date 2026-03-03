# BabyApp (iOS, SwiftUI)

这个目录包含可运行的 SwiftUI 代码骨架（不含 Xcode 工程文件）。

## 目标
- iOS 16+
- 云同步：Firebase Auth + Firestore
- 多用户共享宝宝
- 记录：喝奶 / 辅食 / 便便 / 睡眠 / 外出（含定位与备注）
- 周报 + 月报：总和、日均、趋势曲线
- 提醒：固定时间、习惯提醒、自定义提醒

## 使用方式（建议）
1. 在 Xcode 里新建 iOS App（SwiftUI, iOS 16+），项目名建议 `BabyApp`。
2. 把 `BabyApp/` 目录下的源码拖进你的 Xcode 工程（保持目录结构）。
3. 通过 Swift Package Manager 安装 Firebase：Auth + Firestore。
4. 在工程里添加 `GoogleService-Info.plist`。
5. 按需完善 `Services/` 的 Firebase 实现与权限提示。

## 结构
- App/：入口与依赖注入
- Models/：数据模型
- Services/：云同步、定位、通知、报告生成
- ViewModels/：状态管理
- Views/：页面
- Components/：可复用 UI 组件

## 说明
当前代码以“可编译的骨架”为目标，Firebase 与定位/通知权限逻辑已留好接口。

