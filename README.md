# boostcamp_iOS_dough

> [Boostcamp iOS 2기 안내사항](https://github.com/connect-boostcamp/iOS_Notice)

## 질문 및 고민거리

+ ~~좋은 commit 습관: commit 단위, 횟수, 메시지 등~~
+ guard else 구문 내에서 print, assertionFailure, assert 언제 써야 하는지
+ 만연해지는 것이 불가피한 코드, 어떻게 처리하는게 좋을까?
```swift
UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [.curveLinear], animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                self.view.layoutIfNeeded()
        },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint,
                     &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
        })
```
