# when

A natural language date/time parser with pluggable rules.

This library is a port of Go's [when](https://github.com/olebedev/when).

### Examples

* **tonight at 11:10 pm**
* at **Friday afternoon**
* the deadline is **next tuesday 14:00**
* drop me a line **next wednesday at 2:25 p.m**
* it could be done at **11 am past tuesday**

Check [EN](https://github.com/hectr/swift-when/blob/master/Sources/when/rules/en) rules and tests for them, for more examples.

**Needed rule not found?**
Open [an issue](https://github.com/hectr/swift-when/issues/new) with the case. Also, pull requests are welcome.

### How it works

Usually, there are several rules added to the parser's instance for checking. Each rule has its own borders - length and offset in provided string. Meanwhile, each rule yields only the first match over the string. So, the library checks all the rules and extracts a cluster of matched rules which have distance between each other less or equal to [`Options.maxDistance`](https://github.com/hectr/swift-when/blob/master/Sources/when/Options.swift), which is `5` by default. For example:

```
on next wednesday at 2:25 p.m.
└──────┬─────┘    └───┬───┘
weekday      hour + minute
```

So, we have a cluster of matched rules - `"next wednesday at 2:25 p.m."` in the string representation. 

After that, each rule is applied to the context. In order of definition (appearance in the text) or in match order, if [`Options.matchByOrder`](https://github.com/hectr/swift-when/blob/master/Sources/when/Options.swift) is set to `true` (which it is by default). Each rule could be applied with given merge [strategy](https://github.com/hectr/swift-when/blob/master/Sources/when/context/Strategy.swift). By default, it's an *Override* strategy.

### Usage

```swift
let parser = Parser(rules: EN.all + Common.all)
let text = "drop me a line in next wednesday at 2:25 p.m"
let result = try parser.parse(text: text, base: Date())
print("the time '\(result.date)' mentioned in '\(result.text)'")
)
```

#### Distance Option

```swift
let parser = Parser(rules: EN.all)

let text = "February 23, 2019 | 1:46pm"
// With default distance (5):
// February 23, 1970 | 1:46pm
//                 └─┬─┘
//           distance: 3 ("February 23, 2019" will be clustered with "1:46pm")

let result = try! parser.parse(text: text, base: january1st1970)
print(result.date)
// "2019-02-23 12:46:27 +0000"
// 2019-02-23 (correct)
//   13:47:27 (correct)
```

```swift
let options = Options(maxDistance: 2)
let parser = Parser(options: options, rules: EN.all)

let text = "February 23, 2019 | 1:46pm"
// With custom distance (2):
// February 23, 1970 | 1:46pm
//                 └─┬─┘
//           distance: 3 (1:46pm will be ignored)

let result = try! parser.parse(text: text)
print(result!.date)
// "2019-02-23 16:10:27 +0000"
// 2019-02-23 (correct)
//   16:10:27 ("wrong")
```

### State of the project

The library is still in development. You can expect some API changes in future updates. Bugs will be fixed as soon as they will be found.

#### To-Do

- [x] Port [Common](https://github.com/olebedev/when/blob/master/rules/common) rules.
- [x] Port [EN](https://github.com/olebedev/when/blob/master/rules/en) rules.
- [ ] Port [RU](https://github.com/olebedev/when/blob/master/rules/ru) rules.
- [ ] Port [BR](https://github.com/olebedev/when/blob/master/rules/br) rules.

### Alternatives

- [SwiftyChrono](https://github.com/quire-io/SwiftyChrono)
- [MKDataDetector](https://github.com/mayankk2308/mkdatadetector)

### LICENSE

http://www.apache.org/licenses/LICENSE-2.0
