# swift-datepicker
Present UIDatePicker inside UIAlertController with ActionSheet style (Swift 2)

## How to use?
```
// Step 1: Make `YourViewController` conform `DatePickerActionSheetDelegate`
class YourViewController: UIViewController, DatePickerActionSheetDelegate {

	// Step 2: Declare a variable of `DatePickerActionSheet`
	var datePickerActionSheet: DatePickerActionSheet?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Step 3: Initialize `DatePickerActionSheet` object and set it's delegate
		datePickerActionSheet = DatePickerActionSheet()
		datePickerActionSheet?.delegate = self
	}
	
	@IBAction func tapAction(sender: AnyObject) {
		presentDatePickerActionSheet()
	}
	
	// Step 4: Implement delegate method to get selected date value
	func onDidDateSelected(date: NSDate?) {
		// your selected date should be here
		print(date)
	}
}
```
