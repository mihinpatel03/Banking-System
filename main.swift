//
//  main.swift
//  Project: Banking System
//
//  Created by Sumit Desai, Mihin Patel, Tulsi Patel, Krishna Patel in February 2021.
//

import Foundation

/************************ CLASSES DEFINITION  **********************************/


// defination of the Account class
class Account{
    let accNo : Int
    let name : String
    var contact : Int
    var email : String
    var city : String
    var pincode : Int
    var balance : Double
    var interestRate : Double
    let ifsc : String 
    var upi : String
    
    // initializer for assigning the default value to the all attributes
    init(){
        self.accNo = 0
        self.name = ""
        self.contact = 0
        self.email = ""
        self.city = ""
        self.pincode = 0
        self.balance = 0.0
        self.interestRate = 0.0
        self.ifsc = ""
        self.upi = ""
    }
    
    // initializer for assigning the value to the all attributes
    init(accNo: Int, name: String, contact: Int, email: String, city: String, pincode: Int){
        self.accNo = accNo
        self.name = name
        self.contact = contact
        self.email = email
        self.city = city
        self.pincode = pincode
        self.balance = 0.0
        self.interestRate = 0.0
        self.ifsc = "SBCO60466"
        self.upi = name + "okaccount"
    }
    
    // global function to display the balance
    func displayBalance() -> Double{
        return self.balance
    }
    
    // global function to deposit the amount
    func depositeAmount(depAmount: Double){
        self.balance += depAmount
    }
    
    // global function to withdraw the amount
    func withdrawalAmount(withAmount: Double){
        self.balance -= withAmount 
    }
    
    // global function to transfer the amount from one account to the other account
    func transferAmount(account : Account, transAmount: Double){
        account.balance += transAmount
        self.balance -= transAmount
    }
    
    // global function for pay utility bills
    func payBills(toWhom: String, payAmount: Double){
        print("This method will help to pay the bills!")
    }
    
    // global function to do UPI transfer (modern developed feature)
    func upiTransfer(account: Account, amount: Double){
        print("This method will help to transfer the amount using mobile number only!")
    }
}

// sub-class Saving inherits the parent class Account
class Saving : Account{
    var accType : String
    var accNo_accType = [Int: String]()
    var maxTranNumberPerDay : Int
    var maxTransAmountPerDay : Double
    var minAmount : Double
    
    // initializer for assigning the value to the all attributes
    init(accNo: Int, name: String, contact: Int, email: String, city: String, pincode: Int, accType : String){
        self.accNo_accType[accNo] = accType
        self.accType = accType
        self.maxTranNumberPerDay = 2
        self.maxTransAmountPerDay = 10000.0
        self.minAmount = 1000.0
             
        // calling to parent initializer for assigning the value to attributes of parent class   
        super.init(accNo:accNo, name: name, contact: contact, email: email, city: city, pincode: pincode)
        self.interestRate = 4.5
        self.balance = 1000.0
        self.upi = name + "@oksaving"
    }
    
    // overriding the global function displayBalance for Saving class
    override func displayBalance() -> Double{
        print("\nBalance for this Saving account: \(self.balance)")
        return self.balance
    }
    
    // overriding the global function depositeAmount for Saving class
    override func depositeAmount(depAmount: Double){
        let serviceCharge = 10.0
        self.balance += depAmount - serviceCharge
        print("\nThe amount deposited for this Saving account is: \(depAmount).\nNew balance after depoist is \(self.balance) after deduction of \(serviceCharge) as a service charge for Saving account.")
    }
    
    // overriding the global function withdrawalAmount for Saving class
    override func withdrawalAmount(withAmount: Double){
        let serviceCharge = 10.0
        self.balance -= withAmount + serviceCharge
        print("\nThe withdrawn amount for this Saving account is: \(withAmount).\nNew balance after withdrawn is \(self.balance) after deduction of \(serviceCharge) as a service charge for Saving account.")
    }
    
    // overriding the global function transferAmount for Saving class
    override func transferAmount(account : Account, transAmount: Double){
        if(account is FixedDeposit){
            print("\nSorry! The account entered is Fixed Deposit, and in Fixed Deposit no money can be transferred!")
            print("\nAs there's no transfer possible,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")   
        } else {
            account.balance += transAmount
            self.balance -= transAmount
            print("\nAmount \(transAmount) is transffered to the account number \(account.accNo)")
            print("\nAfter this transaction,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")  
        }
    }
    
    // overriding the global function payBills for Saving class
    override func payBills(toWhom: String, payAmount: Double){		
		self.balance -= payAmount
		if(toWhom == "Credit card bill"){
			print("\nThe bill for credit card has been paid succesfully!\nAfter the bill payment, the balance of your account is \(self.balance)")
		}else if(toWhom == "Electricity bill"){
			print("\nThe bill for electricty has been paid succesfully!\nAfter the bill payment, the balance of your account is \(self.balance)")
		}else if(toWhom == "Mobile recharge"){
			print("\nThe recharge for Mobile has been done succesfully!\nAfter the mobile recharge, the balance of your account is \(self.balance)")
		}else if(toWhom == "DTH recharge"){
			print("\nThe recharge for DTH has been done succesfully!\nAfter the DTH recharge, the  balance of your account is \(self.balance)")
		}
    }
    
    // overriding the global function upiTransfer for Saving class
    override func upiTransfer(account: Account, amount: Double){
        if(account is FixedDeposit){
            print("\nSorry! The account entered is Fixed Deposit, and no amount can be transferred in the Fixed Deposit account!")
            print("\nAs there's no transfer possible,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")   
        } else {
            account.balance += amount
            self.balance -= amount
            print("\nAmount \(amount) is transffered to the account number \(account.accNo)")
            print("\nAfter this transaction,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")  
        }
    }
}

// sub-class Current inherits the parent class Saving
class Current : Saving{
    let panCardNo : String
    
    // initializer for assigning the value to the all attributes
    init(accNo: Int, name: String, contact: Int, email: String, city: String, pincode: Int, accType : String, panCardNo: String){
        self.panCardNo = panCardNo
        
        // calling to parent initializer for assigning the value to attributes of parent class   
        super.init(accNo:accNo, name: name, contact: contact, email: email, city: city, pincode: pincode, accType:accType)
        self.accNo_accType[accNo] = accType
        self.interestRate = 1.0
        self.balance = 3000.0
        self.maxTranNumberPerDay = 20
        self.maxTransAmountPerDay = 100000.0
        self.minAmount = 3000.0
        self.upi = name + "@okcurrent"
    }
    
    // overriding the global function displayBalance for Current class
    override func displayBalance() -> Double{
        print("\nBalance for this Current account: \(self.balance)")
        return self.balance
    }
    
    // overriding the global function depositeAmount for Current class
    override func depositeAmount(depAmount: Double){
        let serviceCharge = 20.0
        self.balance += depAmount - serviceCharge
        print("\nThe amount deposited for this Current account is: \(depAmount).\nNew balance after depoist is \(self.balance) after deduction of \(serviceCharge) as a service charge for Current account.")
    }
    
    // overriding the global function withdrawalAmount for Current class
    override func withdrawalAmount(withAmount: Double){
        let serviceCharge = 20.0
        self.balance -= withAmount + serviceCharge
        print("\nThe withdrawn amount for this Current account is: \(withAmount).\nNew balance after withdrawn is \(self.balance) after deduction of \(serviceCharge) as a service charge for Current account.")
    }
    
    // overriding the global function transferAmount for Current class
    override func transferAmount(account : Account, transAmount: Double){
        if(account is FixedDeposit){
            print("\nSorry! The account entered is Fixed Deposit, and in Fixed Deposit no money can be transferred!")
            print("\nAs there's no transfer possible,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")   
        } else {
            account.balance += transAmount
            self.balance -= transAmount
            print("\nAmount \(transAmount) is transffered to the account number \(account.accNo)")
            print("\nAfter this transaction,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")   
        }
    }
    
    // overriding the global function payBills for Current class
    override func payBills(toWhom: String, payAmount: Double){		
		self.balance -= payAmount
		if(toWhom == "Credit card bill"){
			print("\nThe bill for credit card has been paid succesfully!\nAfter the bill payment, the balance of your account is \(self.balance)")
		}else if(toWhom == "Electricity bill"){
			print("\nThe bill for electricty has been paid succesfully!\nAfter the bill payment, the balance of your account is \(self.balance)")
		}else if(toWhom == "Mobile recharge"){
			print("\nThe recharge for Mobile has been done succesfully!\nAfter the mobile recharge, the balance of your account is \(self.balance)")
		}else if(toWhom == "DTH recharge"){
			print("\nThe recharge for DTH has been done succesfully!\nAfter the DTH recharge, the  balance of your account is \(self.balance)")
		}
    }
    
    // overriding the global function upiTransfer for Current class
    override func upiTransfer(account: Account, amount: Double){
        if(account is FixedDeposit){
            print("\nSorry! The account entered is Fixed Deposit, and no amount can be transferred in the Fixed Deposit account!")
            print("\nAs there's no transfer possible,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")   
        } else {
            account.balance += amount
            self.balance -= amount
            print("\nAmount \(amount) is transffered to the account number \(account.accNo)")
            print("\nAfter this transaction,\nThe account holder \(self.name) having account number as \(self.accNo) has \(self.balance) balance.\nThe account holder \(account.name) having account number as \(account.accNo) has \(account.balance) balance.")  
        }
    }
}

// sub-class FixedDeposit inherits the parent class Account
class FixedDeposit : Account{
    var accNo_accType = [Int: String]()
    let amountToDeposit : Double
    let durationInMonth : Int
    
    // initializer for assigning the value to the all attributes
    init(accNo: Int, name: String, contact: Int, email: String, city: String, pincode: Int, amountToDeposit: Double, durationInMonth: Int){
        self.accNo_accType[accNo] = "Fixed Deposit"
        self.amountToDeposit = amountToDeposit
        self.durationInMonth = durationInMonth
        
        // calling to parent initializer for assigning the value to attributes of parent class   
        super.init(accNo:accNo, name: name, contact: contact, email: email, city: city, pincode: pincode)
        self.interestRate = 8.0
        self.balance = amountToDeposit
    }
    
    // overriding the global function displayBalance for FixedDeposit class
    override func displayBalance() -> Double{
        print("\nBalance for this Fixed Deposit account: \(self.balance)")
        return self.balance
    }
    
    // overriding the global function depositeAmount for FixedDeposit class
    override func depositeAmount(depAmount: Double){
        print("\nThis is Fixed Deposit account, and no more amount can be deposited!")
    }
    
    // overriding the global function withdrawalAmount for FixedDeposit class
    override func withdrawalAmount(withAmount: Double){
        self.balance = 0.0
        print("\nThe withdrawn amount for this Fixed Deposit account is: \(withAmount).\nNew balance after withdrawn is \(self.balance)")
    }
    
    // overriding the global function transferAmount for FixedDeposit class
    override func transferAmount(account : Account, transAmount: Double){
        print("\nThis is Fixed Deposit account, and no transaction can be done from this account!")
    }
    
    // overriding the global function upiTransfer for FixedDeposit class
    override func upiTransfer(account: Account, amount: Double){
        print("\nThis is Fixed Deposit account, and no transaction can be done from this account!")    
    }
}

/************************ CLASSES DEFINITION (END) **********************************/

/********************************* MAIN PROGRAM ************************************/

// heterogeneous collection
var accountList = [Account]()

//---------------------------------------------- FUNCTIONS -------------------------------------------------------

// function for filling the array using the user input
func fillData(){
    repeat{
        var flag = 0
        
        print("\nEnter the name for account holder:")
        let name = readLine()!
        
        print("\nEnter the contact number for account holder:")
        let contact = Int(readLine()!)!
        
        print("\nEnter the email id for account holder:")
        let email = readLine()!
        
        print("\nEnter the city for account holder:")
        let city = readLine()!
        
        print("\nEnter the pincode for account holder:")
        let pincode = Int(readLine()!)!
        
        repeat{     
            //if the same user create the different types of account then flag will have the value of 1
            if(flag == 1){
                print("\nFor \(name), We've already stored the name, contact number, email id, city and pincode for the user! Please provide the remaining details as follow:")
            }
        
            print("\nPlease choose account type from below: \n 1. Saving account \n 2. Current account \n 3. Fixed Deposit account")
            
            // switch case to select from the different type of accounts
            switch Int(readLine()!)!{
                case 1:
                    // Saving account
                    var flag = 0
                    for account in accountList{
                        if (name == account.name && account is Saving){
                            flag = 1
                        }
                    }
                    
                    if(flag == 1){
                        print("\n The client \(name) already has Saving account. Please choose other option!")
                    } else {
                        let accType = "Saving"
                        print("\nPlease enter the Saving account number:")
                        let accNo = Int(readLine()!)!
                        
                        print("\nAs this is Saving account, you have to deposit minimum amount of 1000.0")
                        accountList.append(Saving(accNo: accNo, name: name, contact:contact, email:email, city:city, pincode:pincode, accType: accType))
                        print("For \(name), Saving account created succesfully!")                        
                    }
                case 2:
                    // Current account
                    var flag = 0
                    for account in accountList{
                        if (name == account.name && account is Current){
                            flag = 1
                        }
                    }
                    
                    if(flag == 1){
                        print("\n The client \(name) already has Current account. Please choose other option!")
                    } else {
                        let accType = "Current"
                        print("\nPlease enter the Current account number:")
                        let accNo = Int(readLine()!)!
                        
                        print("\nPlease enter the PAN card number:")
                        let panCardNo = readLine()!
                        
                        print("\nAs this is Current account, you have to deposit minimum amount of 3000.0")
                        accountList.append(Current(accNo: accNo, name: name, contact:contact, email:email, city:city, pincode:pincode, accType:accType, panCardNo:panCardNo))
                        print("For \(name), Current account created succesfully!")   
                    }
                case 3:
                    // Fixed Deposit account
                    var flag = 0
                    for account in accountList{
                        if (name == account.name && account is FixedDeposit){
                            flag = 1
                        }
                    }
                    
                    if(flag == 1){
                        print("\n The client \(name) already has Fixed Deposit account. Please choose other option!")
                    } else {
                        print("\nPlease enter the Fixed Deposit account number:")
                        let accNo = Int(readLine()!)!
                        
                        print("\nPlease enter the amount that needs to be deposited:")
                        let amountToDeposit = Double(readLine()!)!
                        
                        print("\nPlease enter the duration in month for the deposit:")
                        let durationInMonth = Int(readLine()!)!
                        
                        let maturityAmount = amountToDeposit + (amountToDeposit * Double(durationInMonth) * 8.0/12.0)/100.0
                        accountList.append(FixedDeposit(accNo: accNo, name: name, contact:contact, email:email, city:city, pincode:pincode, amountToDeposit:amountToDeposit, durationInMonth:durationInMonth))    
                        print("\nFor \(name), Fixed deposit account created succesfully!")
                        print("\nThe maturity amount is \(String(format:"%.2f", maturityAmount)) after the end of \(durationInMonth) months! However, if the amount is withdrawn before the maturity period it will be \(amountToDeposit) as per the amount deposited!")
                    }
                default:
                    // if user select the wrong value from the given options
                    print("\nSorry! you have choose wrong number!")
            }

            flag = 1
            print("\nDo you want to create another account for the same client? yes/no")
        } while readLine()! == "yes"
        
        print("\nDo you want to create more account: yes/no")
    } while readLine()! == "yes"
}

// function invocation to fill the user data
fillData()

// loop for printing the account details that are created
for account in accountList{
    print("\nName of account holder: \(account.name)")
    print("Account number: \(account.accNo)")
    print("Contact number: \(account.contact)")
    print("Email id: \(account.email)")
    print("City: \(account.city)")
    print("Pincode: \(account.pincode)")
    print("IFSC: \(account.ifsc)")
    
    if account is Current{ // type checking
        let current = account as! Current // type casting
        print("Account type: \(current.accNo_accType)")
        print("PAN Card numner: \(current.panCardNo)")
        print("Maximun number of transaction per day :\(current.maxTranNumberPerDay)")
        print("Maximum amount allowed to transact per day :\(current.maxTransAmountPerDay)")
    } else if account is Saving{ // type checking
        let saving = account as! Saving // type casting
        print("Account type: \(saving.accNo_accType)")
        print("Maximun number of transaction per day :\(saving.maxTranNumberPerDay)")
        print("Maximum amount allowed to transact per day :\(saving.maxTransAmountPerDay)")
    } else if account is FixedDeposit{ // type checking
        let fixedDeposit = account as! FixedDeposit // type casting
        print("Account type: \(fixedDeposit.accNo_accType)")
        print("Deposit amount: \(fixedDeposit.amountToDeposit)")
        print("Deposit duration in months: \(fixedDeposit.durationInMonth)")
    }
}

print("\n\nWELCOME TO THE STATE BANK OF CANADA!")

// loop to continue until the user wants to modify the account details
while(true){
    print("\nDo you want to edit your account details? yes/no")
    let editDetails = readLine()!
    
    // if user input is no then it will terminate the current while loop
    if(editDetails.lowercased() == "no"){
        break
    }
    
    while(true){
        print("\nPlease enter account number which needs changes:")
        let editAccNo = Int(readLine()!)!
        var flag = 0
            
        for account in accountList{
            if(account.accNo == editAccNo){
                flag = 1
                
                print("\nPlease choose the options from below:\n1. Contact number\n2. Email id \n3. City \n4. Pincode")
                switch Int(readLine()!)!{
                    case 1:
                        print("\nPlease enter new Contact number:")
                        let newContact = Int(readLine()!)!
                        account.contact = newContact // update the contact value for the required account
                    case 2:
                        print("\nPlease enter new Email id:")
                        let newEmail = readLine()!
                        account.email = newEmail // update the email value for the required account
                    case 3:
                        print("\nPlease enter new City:")
                        let newCity = readLine()!
                        account.city = newCity // update the city value for the required account
                    case 4:
                        print("\nPlease enter new Pincode:")
                        let newPincode = Int(readLine()!)!
                        account.pincode = newPincode // update the pincode value for the required account
                    default:
                        print("\nSorry! Wrong choice!")
                }
            }
        }
        
        // if user enters the account number that do not exist
        if(flag == 0){
            print("Sorry! The account number does not exist!")
            print("Would you like to enter the account number again? yes/no")
        }
        if(readLine()! == "no"){
            break // terminate the loop if user input is no for entering the account number again
        }
    }
}

// loop to continue until the user wants to select the different options from user menu
while(true){
    var requiredAcc = Account()
    
    while(true){
        print("\nPlease enter your account number to choose different options provided by the bank:")
        let userAccNo = Int(readLine()!)!
        var flag = 0
        
        for account in accountList{
            if(account.accNo == userAccNo){
                flag = 1 // flag will have value 1 if the account number entered by user is found in the system
                requiredAcc = account
                break
            }    
        }
        
        if(flag == 0){
            print("\nSorry! This account number does not exist in our bank!")
        } else {
            break
        }
    }
    
    while(true){
        print("\nWhat would you like to do?\n1. Display current balance\n2. Deposit money\n3. Draw money\n4. Transfer money to other accounts within the bank\n5. Pay utility bills\n6. UPI Transaction \n7. Exit")
        var exit = 0
        
        switch Int(readLine()!)!{
            case 1:
                // to display the balance
                let _ = requiredAcc.displayBalance()
            case 2:
                // to deposite the amount
                print("\nPlease enter the amount you want to add:")
                let depAmount = Double(readLine()!)!
                
                requiredAcc.depositeAmount(depAmount:depAmount)    
            case 3:
                // to withdraw the amount
                if(requiredAcc is FixedDeposit){ // type checking
                    let fdAcc = requiredAcc as! FixedDeposit // type casting
                    
                    print("\nThis is Fixed Deposit account, and if maturity priod is over then you will get the maturity amount or else you will get the amount that was deposited at the time of account opening.\n\nWould you like to withdraw amount? yes/no")
                    let isWithDraw = readLine()!
                    if(isWithDraw == "yes"){
                        print("\nDoes maturity period is over for your account? yes/no")
                        let isMaturity = readLine()!
                        if(isMaturity == "yes"){
                            // this will withdraw the amount with interest
                            let withAmount = fdAcc.amountToDeposit + (fdAcc.amountToDeposit * Double(fdAcc.durationInMonth) * 8.0/12.0)/100.0
                            fdAcc.withdrawalAmount(withAmount: withAmount)
                        } else {
                            // this will withdraw the amount without interest
                            fdAcc.withdrawalAmount(withAmount: fdAcc.amountToDeposit)
                        }
                    } else{
                        print("\nPlease come again if you want to with the amount from Fixed Deposit account!")
                    }
                } else {
                    print("\nPlease enter the amount you want to withdraw:")
                    let withAmount = Double(readLine()!)!
                    
                    // if user wants to withdraw the amount more than the available amount
                    if(withAmount > requiredAcc.balance){
                        print("\nSorry! You have only \(requiredAcc.balance) amount in you account!")
                    } else {
                        requiredAcc.withdrawalAmount(withAmount: withAmount)     
                    }
                }
            case 4:
                // to transfer amount from one account to another account
                if(requiredAcc is FixedDeposit){ // type checking
                    print("\nThis account is Fixed Deposit account, and transfer from this account is not possible!") 
                } else {
                    print("\nPlease enter account number in which you want to transfer the amount:")
                    let accountNo = Int(readLine()!)!
                    var accountFound = "no"
                    
                    for account in accountList {
                        if(accountNo == account.accNo){
                            while(true){
                                var diffFlag = "no"
                                accountFound = "yes"
                                print("\nPlease enter amount that needs to be transfer:")
                                let transAmount = Double(readLine()!)!
                                // if the account number is found and user have sufficient balance to transfer then perform the operation
                                if(transAmount <= requiredAcc.balance){
                                    requiredAcc.transferAmount(account: account, transAmount: transAmount)    
                                } else {
                                // if the account number is found and user don't have sufficient balance to transfer then display the message
                                    print("\nSorry! You have only \(requiredAcc.balance) balance in your account!")
                                    print("\nWould you like to enter the different amount? yes/no")
                                    diffFlag = readLine()!
                                }  
                                
                                if(diffFlag != "yes"){
                                    break
                                }
                            }
                        }
                    }
                    if(accountFound == "no"){
                        print("\nSorry! The account number entered is not found in the Bank!")
                    }
                }
            case 5:
                // pay utility bills
                if(requiredAcc is FixedDeposit){ // type checking
                    print("\nSorry! This is Fixed Deposit account, and no bills can be paid from this account")
                } else {
                    print("\nChoose the option from below:\n1. Credit card bill \n2. Electricity bill \n3. Mobile Recharge \n4. DTH Recharge")
                    
                    // switch case for selection of options to pay bills or do recharge
                    switch Int(readLine()!)!{
                        case 1:
                            // credit card bill
                            let toWhom = "Credit card bill"
                            print("\nPlease enter the Credit card number:")
                            let _ = Int(readLine()!)!
                            
                            print("\nPlease enter the amount of bill you want to pay:")
                            let payAmount = Double(readLine()!)!
                            
                            // if the account don't have sufficient balance then display the message
                            if(payAmount > requiredAcc.balance){
                               print("\nSorry! You don't have sufficient amount in your account to pay the bill!")
                            } else{
                                requiredAcc.payBills(toWhom: toWhom, payAmount: payAmount)
                            }
                        case 2:
                            // electricty bill
                            let toWhom = "Electricity bill"
                            print("\nPlease enter the electricty connection number:")
                            let _ = Int(readLine()!)!
                            
                            print("\nPlease enter the amount of bill you want to pay:")
                            let payAmount = Double(readLine()!)!
                            
                            // if the account don't have sufficient balance then display the message
                            if(payAmount > requiredAcc.balance){
                               print("\nSorry! You don't have sufficient amount in your account to pay the bill!")
                            } else{
                                requiredAcc.payBills(toWhom: toWhom, payAmount: payAmount)
                            }
                        case 3:
                            // mobile serviceCharge
                            let toWhom = "Mobile recharge"
                            print("\nPlease enter the mobile number to recharge:")
                            let _ = Int(readLine()!)!
                            
                            print("\nPlease enter the amount of bill you want to pay:")
                            let payAmount = Double(readLine()!)!
                            
                            // if the account don't have sufficient balance then display the message
                            if(payAmount > requiredAcc.balance){
                               print("\nSorry! You don't have sufficient amount in your account to pay the bill!")
                            } else{
                                requiredAcc.payBills(toWhom: toWhom, payAmount: payAmount)
                            }
                        case 4:
                            // dth recharge
                            let toWhom = "DTH recharge"
                            print("\nPlease enter the DTH number:")
                            let _ = Int(readLine()!)!
                            
                            print("\nPlease enter the amount of bill you want to pay:")
                            let payAmount = Double(readLine()!)!
                            
                            // if the account don't have sufficient balance then display the message
                            if(payAmount > requiredAcc.balance){
                               print("\nSorry! You don't have sufficient amount in your account to pay the bill!")
                            } else{
                                requiredAcc.payBills(toWhom: toWhom, payAmount: payAmount)
                            }
                        default:
                            print("\nSorry! Wrong choice!")
                    }
                }
            case 6:
                // UPI transfer
                if(requiredAcc is FixedDeposit){ // type checking and display the message if its FixedDeposit deposit account
                    print("\nSorry! You can't transfer the amount from the Fixed Deposit!")
                } else{
                    var upiFound = "no"
                    while(true){
                        print("\nPlease enter the UPI id linked with the account number:")
                        let upi = readLine()!
                        var againUPI = "no"
                        
                        for account in accountList{
                            if(account.upi == upi && requiredAcc.name != account.name){
                                upiFound = "yes"
                                
                                print("\nPlease enter the amount that needs to be transfer:")
                                let amount = Double(readLine()!)!
                                requiredAcc.upiTransfer(account: account, amount: amount)
                                break
                            }
                        }
                        
                        if(upiFound == "no"){
                            print("\nSorry! This UPI id is not linked with any of the account!")
                            print("\nWould you like to enter the UPI id again? yes/no")
                            againUPI = readLine()!
                        }
                        if(againUPI == "no"){
                            break
                        }
                    }
                }
            case 7:
                // if user wants to not perform any operations
                exit = 1
            default:
                print("\nSorry! Wrong choice!")
        }
        if(exit == 1){
            break
        }
    }
    
    print("\nWould you like to enter any other account number? yes/no")
    if(readLine()! != "yes"){
        break // terminate the while loop if user don't want to add any other account number
    }
}

