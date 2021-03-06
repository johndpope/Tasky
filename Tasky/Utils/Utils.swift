import UIKit
import CoreData
import MessageUI
import FontAwesome_swift


class Utils {
	
	/* MARK: Colors
	/////////////////////////////////////////// */
	class func getMainColor() -> UIColor {
		return UIColor(hex: Utils.getCurrentTheme()[0])
	}
	
	class func getCurrentTheme() -> [String] {
		if Utils.contains(key: Constants.Defaults.CURRENT_THEME) {
			return Constants.Purchases.Colors[Utils.string(key: Constants.Defaults.CURRENT_THEME)]!
		}
		else {
			return Constants.Purchases.Colors[Constants.Purchases.MALIBU_THEME]!
		}
	}
	
	class func getRandomImageString() -> String {
		var imageArray:[String] = []
		
		for i in 1...54 {
			let image = String(i) + ".png"
			imageArray.append(image)
		}
		
		let randomImageIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
		return imageArray[randomImageIndex]
	}
	
	class func insertGradientIntoView(viewController: UIViewController) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame.size = viewController.view.frame.size
		gradientLayer.colors = [UIColor(hex: Utils.getCurrentTheme()[0]).cgColor, UIColor(hex: Utils.getCurrentTheme()[1]).cgColor]
		gradientLayer.name = "999"
		
		// remove layer if it was previously added
		if viewController.view.layer.sublayers?.first?.name == "999" {
			viewController.view.layer.sublayers?.first?.removeFromSuperlayer()
		}
		
		viewController.view.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	class func insertGradientIntoTableView(viewController: UIViewController, tableView: UITableView) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame.size = viewController.view.frame.size
		gradientLayer.colors = [UIColor(hex: Utils.getCurrentTheme()[0]).cgColor, UIColor(hex: Utils.getCurrentTheme()[1]).cgColor]
		
		let bgView = UIView.init(frame: tableView.frame)
		bgView.layer.insertSublayer(gradientLayer, at: 0)
		tableView.backgroundView = bgView
	}
	
	class func insertGradientIntoCell(view: UIView, color1: String, color2: String) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame.size = view.frame.size
		gradientLayer.colors = [UIColor(hex: color1).cgColor, UIColor(hex: color2).cgColor]
		view.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	
	
	/* MARK: Core Data
	/////////////////////////////////////////// */
	class func createDemoData() -> [AnyObject] {
		var goals = [AnyObject]()
		let goal1Name = "Start Up Company"
		let goal2Name = "Write For Forbes"
		let goal3Name = "Become Master Cook"
		let goal4Name = "Skiing Trip"
		let goal5Name = "Learn To Code"
		
		goals.insert(Utils.createGoal(name: goal1Name), at: 0)
		goals.insert(Utils.createGoal(name: goal2Name), at: 0)
		goals.insert(Utils.createGoal(name: goal3Name), at: 0)
		goals.insert(Utils.createGoal(name: goal4Name), at: 0)
		goals.insert(Utils.createGoal(name: goal5Name), at: 0)
		
		Utils.createTask(goalName: goal1Name, type: "Financial" as AnyObject, when: Date(), reason: "Discuss Financials" as AnyObject)
		Utils.createTask(goalName: goal1Name, type: "Financial" as AnyObject, when: Date(), reason: "Discuss Financials" as AnyObject)
		Utils.createTask(goalName: goal1Name, type: "Financial" as AnyObject, when: Date(), reason: "Discuss Financials" as AnyObject)
		Utils.createTask(goalName: goal2Name, type: "Financial" as AnyObject, when: Date(), reason: "Discuss Financials" as AnyObject)
		Utils.createTask(goalName: goal3Name, type: "Hobbies" as AnyObject, when: Date(), reason: "Learn 5 new recipes" as AnyObject)
		Utils.createTask(goalName: goal3Name, type: "Health" as AnyObject, when: Date(), reason: "Only eat protein & veg" as AnyObject)
		Utils.createTask(goalName: goal3Name, type: "Financial" as AnyObject, when: Date(), reason: "Buy in bulk" as AnyObject)
		Utils.createTask(goalName: goal3Name, type: "Efficiency" as AnyObject, when: Date(), reason: "Meal prep" as AnyObject)
		Utils.createTask(goalName: goal4Name, type: "Financial" as AnyObject, when: Date(), reason: "Discuss Financials" as AnyObject)
		Utils.createTask(goalName: goal4Name, type: "Financial" as AnyObject, when: Date(), reason: "Discuss Financials" as AnyObject)
		Utils.createTask(goalName: goal5Name, type: "Financial" as AnyObject, when: Date(), reason: "Discuss Financials" as AnyObject)
		
		return goals
	}
	
	class func createGoal(name: String) -> AnyObject {
		let goal = Utils.createObject(Constants.CoreData.GOAL)
		goal.setValue(name, forKey: Constants.CoreData.NAME)
		goal.setValue(Utils.getRandomImageString(), forKey: Constants.CoreData.THUMBNAIL)
		Utils.saveObject()
		return goal
	}
	
	class func createTask(goalName: String, type: AnyObject, when: Date, reason: AnyObject) {
		let task = Utils.createObject(Constants.CoreData.TASK)
		task.setValue(goalName, forKey: Constants.CoreData.NAME)
		task.setValue(type, forKey: Constants.CoreData.TYPE)
		task.setValue(when, forKey: Constants.CoreData.WHEN)
		task.setValue(reason, forKey: Constants.CoreData.REASON)
		task.setValue(UUID().uuidString, forKey: Constants.CoreData.UUID);
		Utils.saveObject()
	}
	
	class func createObject(_ type: String) -> NSManagedObject {
		let entity = NSEntityDescription.entity(forEntityName: type, in: fetchManagedObjectContext())
		let object = NSManagedObject(entity: entity!, insertInto:fetchManagedObjectContext())
		return object;
	}
	
	class func saveObject() {
		do {
			try fetchManagedObjectContext().save()
		}
		catch {
			print("Could not save \(error)")
		}
	}
	
	class func fetchCoreDataObject(_ key: String, predicate: String) -> [AnyObject] {
		var fetchedResults = [AnyObject]()
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: key)
		
		if predicate != "" {
			fetchRequest.predicate = NSPredicate(format:"name == %@", predicate)
		}
		
		do {
			fetchedResults = try managedContext.fetch(fetchRequest)
		} catch {
			print(error)
		}
		
		return fetchedResults
	}
	
	class func fetchManagedObjectContext() -> NSManagedObjectContext {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext!
		return managedContext
	}
	
	
	
	/* MARK: Data
	/////////////////////////////////////////// */
	class func bool(key: String) -> Bool {
		return UserDefaults.standard.bool(forKey: key)
	}
	
	class func double(key: String) -> Double {
		return UserDefaults.standard.double(forKey:key)
	}
	
	class func int(key: String) -> Int {
		return UserDefaults.standard.integer(forKey:key)
	}
	
	class func object(key: String) -> Any {
		return UserDefaults.standard.object(forKey: key)!
	}
	
	class func string(key: String) -> String {
		return UserDefaults.standard.string(forKey: key)!
	}
	
	class func contains(key: String) -> Bool {
		return UserDefaults.standard.object(forKey: key) != nil
	}
	
	class func set(key: String, value: Any) {
		UserDefaults.standard.set(value, forKey: key)
	}
	
	class func remove(key: String) {
		UserDefaults.standard.removeObject(forKey: key)
	}
	
	
	
	/* MARK: Dates
	/////////////////////////////////////////// */
	class func getDayOfWeek(_ date:String) -> String? {
		let formatter  = DateFormatter()
		formatter.dateFormat = Constants.LocalData.DATE_FORMAT
		
		if let todayDate = formatter.date(from: date) {
			let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
			let myComponents = (myCalendar as NSCalendar).components(.weekday, from: todayDate)
			let weekDay = myComponents.weekday!
			
			switch weekDay {
			case 1 :
				return "Saturday"
			case 2 :
				return "Sunday"
			case 3 :
				return "Monday"
			case 4 :
				return "Tuesday"
			case 5 :
				return "Wednesday"
			case 6 :
				return "Thursday"
			case 7 :
				return "Friday"
			default :
				print("Error fetching days")
				return "Day"
			}
		} else {
			return nil
		}
	}
	
	
	
	/* MARK: Images
	/////////////////////////////////////////// */
	class func imageResize (_ image:UIImage, sizeChange:CGSize) -> UIImage{
		let hasAlpha = true
		let scale: CGFloat = 0.0 // Use scale factor of main screen
		
		UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
		image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
		
		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		return scaledImage!
	}
	
	
	
	/* MARK: Reminders
	/////////////////////////////////////////// */
	class func scheduleReminder(_ task: NSManagedObject) {
		let notification = UILocalNotification() // create a new reminder notification
		notification.alertBody = "Don't forget: \(task.value(forKey: Constants.CoreData.REASON) as! NSString)"
		notification.alertAction = "Open"
		notification.fireDate = Date().addingTimeInterval(30 * 60) // 30 minutes from current time
		notification.soundName = UILocalNotificationDefaultSoundName
		notification.userInfo = ["UUID": task.value(forKey: Constants.CoreData.UUID)!]
		notification.category = Constants.LocalNotifications.ACTION_CATEGORY_IDENTIFIER
		
		UIApplication.shared.scheduleLocalNotification(notification)
	}
	
	
	
	// MARK: Social
	/////////////////////////////////////////// */
	class func openURL(url: String) {
		let url = URL(string: url)!
		if #available(iOS 10.0, *) {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		} else {
			UIApplication.shared.openURL(url)
		}
	}
	
	
	class func openShareView(viewController: UIViewController) {
		let share = Constants.Strings.SHARE
		let link : NSURL = NSURL(string: Constants.Strings.LINK_IOS_STORE)!
		let logo: UIImage = UIImage(named: Constants.Design.LOGO)!
		
		let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [share, link, logo], applicationActivities: nil)
		
		// This lines is for the popover you need to show in iPad
		activityViewController.popoverPresentationController?.sourceView = viewController.view
		
		// This line remove the arrow of the popover to show in iPad
		activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
		activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
		
		// Anything you want to exclude
		activityViewController.excludedActivityTypes = [
			UIActivityType.postToWeibo,
			UIActivityType.print,
			UIActivityType.assignToContact,
			UIActivityType.saveToCameraRoll,
			UIActivityType.addToReadingList,
			UIActivityType.postToFlickr,
			UIActivityType.postToVimeo,
			UIActivityType.postToTencentWeibo
		]
		
		viewController.present(activityViewController, animated: true, completion: nil)
	}
	
	
	
	// MARK: Visual
	/////////////////////////////////////////// */
	class func getViewController(_ viewName: String) -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: viewName) as UIViewController
		return vc
	}
	
	class func presentView(_ view: UIViewController, viewName: String) {
		view.present(getViewController(viewName), animated: true, completion: nil)
	}
	
	class func pushView(_ view: UIViewController, viewName: String) {
		view.navigationController?.pushViewController(getViewController(viewName), animated: true)
	}
	
	class func createFontAwesomeBarButton(button: UIBarButtonItem, icon: FontAwesome, style: FontAwesomeStyle) {
		var attributes = [NSAttributedStringKey : Any]()
		attributes = [.font: UIFont.fontAwesome(ofSize: 21, style: style)]
		button.setTitleTextAttributes(attributes, for: .normal)
		button.setTitleTextAttributes(attributes, for: .selected)
		button.title = String.fontAwesomeIcon(name: icon)
	}
}
