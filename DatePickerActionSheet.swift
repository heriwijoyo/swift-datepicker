//
//  DatePickerActionSheet.swift
//  Playground
//
//  Created by Heri Wijoyo on 8/26/16.
//  Copyright © 2016 HeriWijoyo. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerActionSheetDelegate {
	
	var datePickerActionSheet: DatePickerActionSheet? { get set }
	
	func onDidDateSelected(date: NSDate?)
	
	func dismissDatePicker()
}

extension DatePickerActionSheetDelegate where Self: UIViewController {
	
	
	func presentDatePickerActionSheet() {
		
		if let alertController = datePickerActionSheet?.alertController {
			
			presentViewController(alertController, animated: true, completion: nil)
		}
	}
	
	func dismissDatePicker() {
		
		if let alertViewController = datePickerActionSheet?.alertController where alertViewController == presentedViewController {
			
			dismissViewControllerAnimated(true, completion: nil)
		}
	}
}

class DatePickerActionSheet {
	
	internal var alertController: UIAlertController?
	internal var delegate: DatePickerActionSheetDelegate?
	internal var datePicker = UIDatePicker()
	
	private let buttonWidth = CGFloat(80.0)
	private let barHeight = CGFloat(40.0)
	private let pickerHeight = CGFloat(260.0)
	
	private var alertWidth: CGFloat {
		
		return alertController?.view.bounds.width ?? UIScreen.mainScreen().bounds.width
	}
	
	init() {
		
		configureForView()
	}
	
	private func configureForView() {
		
		alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .ActionSheet)
		
		let barView = UIView(frame: CGRectMake(0, 0, alertWidth, barHeight))
		barView.backgroundColor = UIColor(red: 215/255, green: 218/255, blue: 223/255, alpha: 1.0)
		
		addCancelButton(barView: barView)
		addDoneButton(barView: barView)
		
		datePicker.frame = CGRectMake(0, 10, alertWidth, pickerHeight)
		datePicker.datePickerMode = .Date
		
		alertController?.view.addSubview(datePicker)
		alertController?.view.addSubview(barView)
		alertController?.view.layer.cornerRadius = 20.0
		alertController?.view.clipsToBounds = true
	}
	
	private func addCancelButton(barView barView: UIView) {
		
		let cancelButton = UIButton(frame: CGRectMake(0, 0, buttonWidth, barHeight))
		
		cancelButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		cancelButton.setTitle("Cancel", forState: .Normal)
		
		cancelButton.addTarget(self, action: #selector(DatePickerActionSheet.cancelButtonTapped(_:)), forControlEvents: .TouchUpInside)
		
		cancelButton.enabled = true
		
		barView.addSubview(cancelButton)
		
	}
	
	private func addDoneButton(barView barView: UIView) {
		
		let xPosition = alertWidth - buttonWidth - 20
		
		let doneButton = UIButton(frame: CGRectMake(xPosition, 0, buttonWidth, barHeight))
		
		doneButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		doneButton.setTitle("Done", forState: .Normal)
		
		doneButton.addTarget(self, action: #selector(DatePickerActionSheet.doneButtonTapped(_:)), forControlEvents: .TouchUpInside)
		
		doneButton.enabled = true
		
		barView.addSubview(doneButton)
	}
	
	@objc private func cancelButtonTapped(sender: UIButton) {
		
		delegate?.dismissDatePicker()
	}
	
	@objc private func doneButtonTapped(sender: UIButton) {
		
		delegate?.onDidDateSelected(datePicker.date)
		delegate?.dismissDatePicker()
	}
}
