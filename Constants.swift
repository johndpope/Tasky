import Foundation

class Constants {
	
	struct Classes {
		static let ADD_CATCH_UP = "AddCatchUp"
		static let CATCH_UP = "CatchUp"
		static let CATCH_UPS = "CatchUps"
		static let SETTINGS = "Settings"
	}
	
	struct Common {
		static let APPNAME = "Tasky"
		static let APP_STORE_URL = "http://apple.co/2krwSkQ"
		static let CELL = "cell"
		static let MAIN_STORYBOARD = "Main"
		static let SUBMIT = "Create"
	}
	
	struct CoreData {
		static let CATCHUP = "CatchUp"
		static let PERSON = "Person"
		static let NAME = "name"
		static let REASON = "reason"
		static let THUMBNAIL = "thumbnail"
		static let TYPE = "type"
		static let WHEN = "when"
		static let UUID = "uuid"
	}
	
	struct IAP {
		static let PURCHASED_PRODUCTS = "PurchasedProducts"
		static let TRANSACTION_IN_PROGRESS = "TransactionInProgress"
		static let CURRENT_THEME = "CurrentTheme"
		static let COLORFUL_THEME = "Colorful Theme"
		static let GIRLY_THEME = "Girly Theme"
		static let MANLY_THEME = "Manly Theme"
		static let RAINBOW_THEME = "Rainbow Theme"
		static let ROYAL_THEME = "Royal Theme"
		static let SLIDE_THEME = "Slide Theme"
		static let STYLE_THEME = "Style Theme"
		static let TIDAL_THEME = "Tidal Theme"
		static let WAVE_THEME = "Wave Theme"
	}
    
    struct LocalData {
        static let SELECTED_PERSON = "selectedPerson"
        static let SELECTED_CATCHUP_INDEX = "selectedCatchupIndex"
        static let SELECTED_PERSON_INDEX = "selectedPersonIndex"
        static let DATE_FORMAT = "h:mm a, d MMM, yyyy" // e.g. 4:30 PM, 28 March
    }
    
    struct LocalNotifications {
        static let ACTION_CATEGORY_IDENTIFIER = "ActionCategory"
		static let DONE_ACTION_IDENTIFIER = "DoneAction"
		static let DONE_ACTION_TITLE = "Complete"
		static let REMIND_ACTION_IDENTIFIER = "RemindAction"
		static let REMIND_ACTION_TITLE = "Remind in 30 minutes"
	}
	
	struct String {
		static let SHARE = "Check out " + Constants.Common.APPNAME + " on the App Store, where you can easily create goals and tasks to achieve those goals! " + Constants.Common.APP_STORE_URL
		static let CONTACT = "Please send us feedback via the apps settings table -> Send Feedback button!"
	}
}