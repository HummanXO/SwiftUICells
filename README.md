# SwiftUICells  
_Учебно-демонстрационный iOS-проект, показывающий, как можно «подружить» UIKit и SwiftUI внутри одного приложения, оставаясь в рамках MVVM._

---

## Содержание
1. [Контекст проекта](#контекст-проекта)  
2. [Ключевые возможности](#ключевые-возможности)  
3. [Архитектура и структура каталогов](#архитектура-и-структура-каталогов)  
4. [Технические детали реализации](#технические-детали-реализации)  
5. [Недоработки и зоны роста](#недоработки-и-зоны-роста)  
6. [Запуск проекта](#запуск-проекта)  
7. [Дальнейшие планы](#дальнейшие-планы)  
8. [Контрибьютинг](#контрибьютинг)  
9. [Лицензия](#лицензия)  

---

## Контекст проекта
Проект создавался для личного обучения интеграции UIKit-компонентов в SwiftUI и закрепления принципов MVVM.  
В качестве «боевого» кейса выбран **User List**:  
* список пользователей на `UITableView`;  
* кастомная SwiftUI-ячейка через `UIHostingController`;  
* детальный SwiftUI-экран с UIKit-DatePicker-ом внутри (`UIViewRepresentable`).  

---

## Ключевые возможности
| Область | Реализовано |
|---------|-------------|
| **Список** | `UITableView` + кастомная ячейка `UserListTableViewCell`; данные приходят из `UserListViewModel`. |
| **SwiftUI-вью в ячейке** | `SwiftUIView` показывает имя, возраст, premium-бейдж и градиентный аватар. |
| **Детальный экран** | `DeteiledCellSwiftUIView` (да, орфография поправим) редактирует имя, возраст и premium-статус пользователя. |
| **Интеграция UIKit** | `UIDatePicker` обёрнут в `DatePickerUIKit : UIViewRepresentable`, внутри собственный `DatePickerView` + `UIToolbar`. |
| **Двусторонний поток данных** | `@Binding<User>` передаётся из ViewController в ячейку и на детальный экран, изменения мгновенно отражаются в исходном массиве. |
| **Асинхронный API-слой** | `APIService` демонстрирует `async/await`-запрос к локальному endpoint-у. |
| **Ручная верстка (UIKit)** | Constraints пишутся в коде, Storyboard только для LaunchScreen. |

---

## Архитектура и структура каталогов
```
SwiftUICells/
├─ App/
├─ Modules/
│  └─ UserList/
│     ├─ Controllers/
│     ├─ ViewModels/
│     ├─ Models/
│     ├─ Cells/
│     ├─ Views/
│     └─ SwiftUIViews/
├─ Shared/
│  ├─ Components/
│  └─ Services/
└─ Resources/
```

### Поток данных (упрощённо)
```
APIService ----> UserListViewModel ----> UserListViewController
   |                                            |
   | Binding<User>                              | Binding<User>
   v                                            v
DatePickerUIKit <----- DeteiledCellSwiftUIView ---- SwiftUIView
```

---

## Технические детали реализации
| Блок | Выбор / Причина |
|------|-----------------|
| **MVVM без Combine** | `UserListViewModel` держит массив `users`, изменения пушатся через `didSet` и колбэк. |
| **SwiftUI внутри ячейки** | `UIHostingController` создаётся один раз на ячейку, при переиспользовании перезаписываем `rootView`. |
| **Routing** | `UINavigationController` → `UIHostingController`. |
| **Date → Age** | Возраст вычисляется в `DatePickerView`, результат — наружу через замыкание. |
| **Асинхронность** | `fetchUsers()` использует `async/await`. |

---

## Недоработки и зоны роста
| Категория | Что нужно улучшить |
|-----------|--------------------|
| **Стиль кода** | Нет SwiftLint, опечатки (`Deteiled`, `invalideStatusCode`). |
| **Безопасность** | Force-unwrap при dequeuing может упасть. |
| **UI** | `reloadRows(at:)` перерисовывает строку целиком. |
| **Архитектура** | ViewModel "тонкий", нет DI/use-case слоя. |
| **Тесты** | Отсутствуют. |
| **Локализация** | Все строки зашиты. |
| **Accessibility** | Нет `accessibilityLabel`. |
| **CI** | Нет GitHub Actions. |
| **Документация** | Нет `///` комментариев. |

---

## Запуск проекта
```bash
git clone https://github.com/HummanXO/SwiftUICells.git
cd SwiftUICells
open SwiftUICells.xcodeproj
```

_Если используешь API: убедись, что по адресу `http://localhost:3000/users` работает json-сервер._

---

## Дальнейшие планы
- UITableViewDiffableDataSource
- DI + Use-case слой
- SwiftLint + pre-commit hook
- Unit-тесты (APIService)
- GitHub Actions
- Локализация
- Accessibility

---

## Контрибьютинг
1. Fork
2. Новая ветка: `feature/my-change`
3. Коммиты: Conventional Commits (`feat(user): add avatar`)
4. Pull Request
5. CI должен быть зелёный

---

## Лицензия
MIT © 2025 HummanXO