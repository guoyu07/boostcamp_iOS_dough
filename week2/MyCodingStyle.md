# 나의 코딩 스타일

지향점
+ 세로 길이를 최소화:  빈 줄을 줄여 한 화면에 최대한 많은 코드가 보이도록 한다.
+ 가로 길이는 넉넉하게: 띄어쓰기를 분명히 하여 가독성을 높인다.

## 들여쓰기 스타일

+ [K&R (1TBS)](https://en.wikipedia.org/wiki/Indent_style#Variant:_1TBS_.28OTBS.29)

```swift
if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
  return false
} else {
  return true
}
```

## 빈 줄

+ 하나의 파일을 대표하는 클래스의 코드블럭 내 첫 줄과 마지막 줄은 비운다.
+ 다른 코드블럭은 처음과 마지막에 줄을 비우지 않는다.

```swift
class Meal {

    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int

}
```
```swift
class MapViewController: UIViewController {

    // MARK: Properties
    var mapView: MKMapView?
    ···

}
```

+ 유사한 역할을 하는 프로퍼티들은 빈 줄 없이 이어서 나열한다.

```swift
@IBOutlet weak var nameTextField: UITextField!
@IBOutlet weak var mealNameLabel: UILabel!
@IBOutlet weak var photoImageView: UIImageView!
```

+ 메서드 사이는 한 줄을 비운다.

```swift
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
}

func textFieldDidEndEditing(_ textField: UITextField) {
    mealNameLabel.text = textField.text
}
```

+ 코드블럭이 비대해지면 연관성이 깊은 것들끼리 집적한다.

```swift
// Create the button
let button = UIButton()
button.setImage(emptyStar, for: .normal)
button.setImage(filledStar, for: .selected)
button.setImage(highlightedStar, for: .highlighted)
button.setImage(highlightedStar, for: [.highlighted, .selected])

// Add Constraints
button.translatesAutoresizingMaskIntoConstraints = false
button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
```

## 띄어쓰기

+ "{" 앞은 한 칸을 비운다.

```swift
override func viewDidLoad() {
  ···
}
```

+ ","와 ":" 바로 뒤는 한 칸을 비운다.

```swift
class ViewController: UIViewController, UITextFieldDelegate {
  ···
}
```

+ 연산자 바로 앞과 뒤는 한 칸을 비운다.

```swift
if let value = fahrenheitValue {
  return (value - 32) * (5 / 9)
}
```

## 주석

+ 관련성이 있는 것들은 Swift 마크다운을 사용하여 MARK 표시를 한다.
+ // 이후 한 칸 띄우고 작성한다.

```swift
// MARK: Properties
@IBOutlet weak var nameTextField: UITextField!
@IBOutlet weak var mealNameLabel: UILabel!

// MARK: UIViewController
override func viewDidLoad() { ··· }

// MARK: UITextFieldDelegate
func textFieldShouldReturn(_ textField: UITextField) -> Bool { ··· }
```

+ 가능한 한 주석은 해당 코드 시작 전 바로 위에 단다. 불가피한 경우에는 오른쪽에 단다.

```swift
// Only allow photos to be picked, not taken.
imagePickerController.sourceType = .photoLibrary // Instead of UIImagePickerControllerSourceType.photoLibrary
```
