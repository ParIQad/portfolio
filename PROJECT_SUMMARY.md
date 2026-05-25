# Portfolio App - สรุปโปรเจ็ค

## ภาพรวม

แอปพลิเคชัน Portfolio ส่วนตัว พัฒนาด้วย **Flutter** สำหรับแสดงข้อมูลโปรไฟล์ ทักษะ ประสบการณ์ และช่องทางติดต่อ ออกแบบ UI ในสไตล์ **Y2K / Retro** ที่มีสีสันสดใส ขอบดำหนา และ gradient background

- **ชื่อโปรเจ็ค:** portfolio
- **เวอร์ชัน:** 1.0.0+1
- **Dart SDK:** ^3.9.2
- **แพลตฟอร์มที่รองรับ:** Android, iOS, Web, Windows, macOS, Linux

---

## สถาปัตยกรรม (Architecture)

โปรเจ็คใช้ **Clean Architecture** แบ่งเป็น 3 ชั้น:

```
lib/
├── core/              # Shared utilities, widgets, constants
│   ├── constants/
│   ├── error/
│   ├── theme/
│   ├── utils/         # AppUtils (launch URL, copy to clipboard)
│   └── widgets/       # GradientScaffold, FolderTab
│
├── features/          # Feature-based modules
│   ├── auth/          # ระบบ Login
│   ├── home/          # หน้าหลัก (ID Card + Navigation)
│   ├── profile/       # ข้อมูลโปรไฟล์
│   ├── experience/    # ประสบการณ์ / โปรเจ็คที่ทำ
│   ├── skills/        # ทักษะ (Hard/Soft/Language)
│   └── contact/       # ช่องทางติดต่อ + Chat
│
└── main.dart          # Entry point
```

แต่ละ feature แบ่งเป็น:
- **data/** — datasources, models, repository implementations
- **domain/** — entities, repository interfaces, use cases
- **presentation/** — pages, widgets, bloc/cubit (state management)

---

## State Management

- ใช้ **flutter_bloc** (Cubit pattern) สำหรับ Authentication
- ใช้ **ChangeNotifier** (ListenableBuilder) สำหรับ Contact feature
- ใช้ **FutureBuilder** สำหรับ Skills feature

---

## ฟีเจอร์หลัก

### 1. Authentication (Login & Logout)
- เชื่อมต่อ API จาก `https://dummyjson.com/auth/login`
- ใช้ Cubit จัดการ state (Initial → Loading → Success/Failure)
- เมื่อ login สำเร็จจะนำทางไปหน้า Home พร้อมส่ง `userData`
- **Logout:** ปุ่ม logout อยู่มุมขวาของ AppBar ในหน้า Home
  - แสดง dialog ยืนยันก่อน logout
  - เรียก API `DELETE /users/{id}` เพื่อจำลองการ invalidate session
  - เมื่อ logout สำเร็จจะนำทางกลับหน้า Login และเคลียร์ navigation stack

### 2. Home Page
- แสดง **ID Card** สไตล์ Y2K พร้อมข้อมูล:
  - Nickname: Aikyu
  - Location: Khon Kaen
  - Role: Flutter Developer
  - Team: Woxa
- มี **Folder Tabs** สำหรับนำทางไปแต่ละหน้า (Profile, Experience, Skills, Contact)
- มีปุ่ม **Logout** (ไอคอนวงกลมขอบดำ สไตล์ Y2K) ที่มุมขวาของ AppBar

### 3. Profile
- แสดงข้อมูลส่วนตัวแบบละเอียด
- ใช้ widget สไตล์ Retro Sticker

### 4. Experience
- แสดงรายการโปรเจ็คที่เคยทำ
- มีหน้า Project Detail สำหรับดูรายละเอียด
- ใช้ Retro Project Card widget

### 5. Skills
- แบ่งเป็น 3 หมวด:
  - **Hard Skills** — แสดงเป็น loading bar พร้อมเปอร์เซ็นต์
  - **Soft Skills** — แสดงเป็น tags/stickers
  - **Languages** — แสดงระดับความสามารถพร้อมดาว
- UI ใช้ Retro Window frame

### 6. Contact
- แสดงช่องทางติดต่อ (Email, GitHub, LinkedIn, Phone)
- มีระบบ Chat/Messaging ในสไตล์ Instant Messenger
- รองรับการส่งข้อความและแสดง Chat Bubble

---

## Dependencies หลัก

| Package | เวอร์ชัน | หน้าที่ |
|---------|----------|---------|
| flutter_bloc | ^8.1.3 | State management (Cubit) |
| equatable | ^2.0.5 | Value equality สำหรับ state classes |
| http | ^1.6.0 | HTTP requests (Login API) |
| url_launcher | ^6.1.11 | เปิด URL ภายนอก |
| cupertino_icons | ^1.0.8 | iOS-style icons |

---

## UI/UX Design

- **ธีม:** Dark mode (Material 3) + Indigo color scheme
- **สไตล์:** Y2K / Retro aesthetic
  - Gradient background (สี → ขาว → สี)
  - ขอบดำหนา (bold black borders)
  - เงาแบบ solid (ไม่ blur)
  - สี Pastel สดใส
  - Font สไตล์ Courier (monospace)
  - Folder tab navigation แทน bottom nav

---

## วิธีรันโปรเจ็ค

```bash
# ติดตั้ง dependencies
flutter pub get

# รันบน Chrome (Web)
flutter run -d chrome

# รันบน Android
flutter run -d android

# Build สำหรับ Web
flutter build web
```

---

## โครงสร้างไฟล์สำคัญ

| ไฟล์ | คำอธิบาย |
|------|----------|
| `lib/main.dart` | Entry point, ตั้งค่า theme และ route เริ่มต้น |
| `lib/core/widgets/gradient_scaffold.dart` | Scaffold พร้อม gradient background |
| `lib/core/widgets/folder_tab.dart` | Widget แท็บรูปโฟลเดอร์ |
| `lib/core/utils/app_utils.dart` | Utility functions (launch URL, copy) |
| `lib/features/auth/presentation/bloc/auth_cubit.dart` | Logic การ login |
| `lib/features/home/presentation/pages/home_page.dart` | หน้าหลักพร้อม ID Card |

---

## หมายเหตุ

- โปรเจ็คนี้เป็น **private package** (publish_to: 'none')
- ใช้ DummyJSON API สำหรับทดสอบ login/logout (ไม่ใช่ backend จริง)
  - Login: `POST /auth/login`
  - Logout: `DELETE /users/{id}` (จำลอง session invalidation)
- Dependency Injection ทำแบบ manual (ยังไม่ใช้ GetIt หรือ Provider)
- โฟลเดอร์ `assets/` ยังว่างอยู่ (ยังไม่มีรูปภาพหรือ font เพิ่มเติม)
