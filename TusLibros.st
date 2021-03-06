!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'objectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
setUp

	objectsFactory := PublisherTestObjectsFactory new! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:58'!
test01NewCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test02CanAddABookToACart

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:25:18'!
test03CannotAddABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF456'.

	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.
	! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test04CanAddTwoCopiesOfABook

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test05CannotAddNonPositiveNumberOfCopiesOfABook

	| cart |
	cart := self createCart.

	self assert: cart isEmptyAfter: [ cart add: objectsFactory bookFromTheEditorial quantity: -1 ] raisesErrorWithMessage: Cart invalidNumberOfCopiesErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test06CartRemembersAddedBooks

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	cart add: objectsFactory bookFromTheEditorial quantity: 1.
	
	self assert: (cart includes: objectsFactory bookFromTheEditorial).
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 3! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:26:35'!
test07CannotAddTwoCopiesOfABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF123'.
	
	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog quantity: 2 ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.! !


!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 21:24:13'!
assert: cart isEmptyAfter: blockExpectedToFail raisesErrorWithMessage: errorMessage
	
	self should: blockExpectedToFail raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: errorMessage.
		self assert: cart isEmpty.
	]! !

!CartTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:24'!
createCart

	^ objectsFactory anEmptyCart! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'objectsFactory merchantProcessorBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:04'!
setUp

	objectsFactory := PublisherTestObjectsFactory new.
	merchantProcessorBehaviour := [ :anAmountToDebit :aCreditCard |  ]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:40'!
test01CannotCheckoutAnEmptyCart

	| cart salesBook cashier |
	cart := objectsFactory anEmptyCart.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutAnEmptyCart.
			self assert: salesBook isEmpty
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:05'!
test02TotalIsCalculatedCorrectlyAfterCheckout

	| cart ticket cashier |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: objectsFactory bookFromTheEditorialPrice equals: ticket value.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:50'!
test03CannotCheckoutIfCardIsExpired

	| cart cashier merchantProcessorWasContacted salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	merchantProcessorWasContacted := false.
	self merchantProcessorBehaviour: [ :amountToDebit :aCreditCard |  merchantProcessorWasContacted := true ].
	
	self should: [ self cashier: cashier checkout: cart debitingOn: objectsFactory anExpiredCreditCard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutUsingAnExpiredCard.
			self deny: merchantProcessorWasContacted.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 23:04:34'!
test04CheckoutDebitsCreditCardUsingMerchantProcessor

	| cart ticket cashier debitedAmountFromCreditCard debitedCreditCard creditCard |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	creditCard := objectsFactory aValidCreditCard.
		
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | 
		debitedAmountFromCreditCard := anAmountToDebit.
		debitedCreditCard := aCreditCard.
	].
	
	ticket := self cashier: cashier checkout: cart debitingOn: creditCard.
	
	self assert: debitedAmountFromCreditCard equals: ticket value.
	self assert: debitedCreditCard equals: creditCard.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:58'!
test05CheckoutFailsIfMerchantProcessorCantProcessPayment

	| cart cashier salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | Error new signal ].
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: Cashier couldNotProcessPaymentErrorMessage.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:52:03'!
test06CheckingOutACartRegistersASale

	| cart cashier ticket salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.	
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: ticket.! !


!CashierTest methodsFor: 'merchat processor protocol' stamp: 'LL 1/24/2021 18:26:00'!
debit: anAmountToDebit from: aCreditCard

	^merchantProcessorBehaviour value: anAmountToDebit value: aCreditCard! !


!CashierTest methodsFor: 'change mp behaviour' stamp: 'LL 1/24/2021 18:26:00'!
merchantProcessorBehaviour: newBehaviour

	merchantProcessorBehaviour := newBehaviour! !


!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:05'!
cashier: cashier checkout: cart

	^self cashier: cashier checkout: cart debitingOn: objectsFactory aValidCreditCard! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:04'!
cashier: cashier checkout: cart debitingOn: aCreditCard

	^cashier checkout: cart payingWith: aCreditCard through: self merchantProcessorForTest on: objectsFactory now.! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 18:29:57'!
merchantProcessorForTest
	
	^self! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LL 1/24/2021 18:15:23'!
test01CreditCardOwnerNameCannotBeBlank

	^self should: [ CreditCard of: '' number: 11111111 expiringOn: (FixedGregorianDate today) monthOfYear ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: CreditCard nameCannotBeBlankErrorMessage.
		]! !


!classDefinition: #InterfaceTest category: 'TusLibros'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'interface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 17:48:34'!
setUp
	interface:= Interface new initialize.! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:11:32'!
test01CreateACartWithInvalidIdThrowsError
	self setUp .
	self should: [ interface createCartFor: '' with: self validClientPassword. ] 
		raise: Error
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: 'Invalid client Id'.
			]
		! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 17:55:37'!
test02CreateACartReturnsId
	|cartId|
	self setUp .
	cartId := interface createCartFor: self validClientId with: self validClientPassword.
	self assert: (cartId isNumber)! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:13:55'!
test03AddingABookToInvalidCartThrowsError
	self setUp .
	self should: [ interface addToCart: 'asdasdasd' book: 'asdasd' quantity: 1 ] 
		raise: Error
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: 'Not valid cart ID'.
			]! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:16:33'!
test04ListingANonExistingCartThrowsError
	self setUp .
	self should: [ interface listCart: 'asdasdasd' ] 
		raise: Error
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: 'Not valid cart ID'.
			]! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:19:51'!
test05CheckingOutANonExistingCartThrowsError
	self setUp .
	self should: [ interface checkOutCart: 'asdasd' payingWith: '12342134' expiresAt: '031232' of: 'Nacho Iragui'] 
		raise: Error
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: 'Not valid cart ID'.
			]! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:45:33'!
test06CheckingOutACartReturnsTransactionId
	| transactionId cartId nextMonth |
	self setUp .
	nextMonth := (FixedGregorianDate today next: GregorianMonth oneMonth ) monthOfYear .
	cartId := interface createCartFor: 'CLIENT123' with: 'PASS123'.
	interface addToCart: cartId book: 'ABC124' quantity: 1.
	transactionId := interface checkOutCart: cartId payingWith: '12342134' expiresAt: nextMonth of: 'Nacho Iragui'.
	self assert: (transactionId isNumber). ! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:43:32'!
test07CanNotListAExpiredCart
	| clock cartId |
	self setUp .
	cartId := interface createCartFor: 'CLIENT123' with: 'PASS123'.
	interface addToCart: cartId book: 'ABC124' quantity: 1.
	clock := interface clockFor: cartId .
	clock substract: 30. 
	self should: [interface listCart: cartId ] 
		raise: Error
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: 'Cart expired'.
			]! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:44:04'!
test08CanNotAddToExpiredCart
	| clock cartId |
	self setUp .
	cartId := interface createCartFor: 'CLIENT123' with: 'PASS123'.
	interface addToCart: cartId book: 'ABC124' quantity: 1.
	clock := interface clockFor: cartId .
	clock substract: 30. 
	self should: [interface addToCart: cartId book: 'ABC124' quantity: 2. ] 
		raise: Error
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: 'Cart expired'.
			]! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 18:46:02'!
test09CanNotCheckOutAExpiredCart
	| clock cartId nextMonth|
	self setUp .
	nextMonth := (FixedGregorianDate today next: GregorianMonth oneMonth ) monthOfYear .
	cartId := interface createCartFor: 'CLIENT123' with: 'PASS123'.
	interface addToCart: cartId book: 'ABC124' quantity: 1.
	clock := interface clockFor: cartId .
	clock substract: 30. 
	self should: [interface checkOutCart: cartId payingWith: '12342134' expiresAt: nextMonth of: 'Nacho Iragui'. ] 
		raise: Error
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: 'Cart expired'.
			]! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 17:47:26'!
validClientId
	^'105137'
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 17:46:53'!
validClientName
	^'Nacho'
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'AG 2/25/2021 17:47:07'!
validClientPassword
	^'1234'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LL 1/25/2021 18:50:24'!
initializeWithCatalog: aBookCatalog
	
	bookCatalog := aBookCatalog.
	books := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:24:07'!
add: aBook
	
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:23:42'!
add: aBook quantity: numberOfBooksToAdd

	self assertIsInCatalog: aBook.
	self assertValidNumberOfCopies: numberOfBooksToAdd.
	
	books add: aBook withOccurrences: numberOfBooksToAdd.! !


!Cart methodsFor: 'accessing' stamp: 'AG 2/25/2021 16:41:48'!
books
	^books.! !

!Cart methodsFor: 'accessing' stamp: 'AG 2/25/2021 17:05:03'!
listCartItems
	| booksList |
	
	booksList := Dictionary new.
	books do: [ :aBook |
		booksList add: aBook->(self quantityOf: aBook).
		].
	^booksList .! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/24/2021 17:42:15'!
total
	
	^books sum: [ :aBook | bookCatalog at: aBook ].! !


!Cart methodsFor: 'testing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/24/2021 15:49:03'!
assertIsInCatalog: aBook

	^ (bookCatalog includesKey: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LL 1/25/2021 18:29:34'!
acceptingItemsOf: aBookCatalog
 
	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LL 1/20/2021 21:45:09'!
bookNotInCatalogErrorMessage

	^'Cannot add a book that is not from the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'LL 1/21/2021 21:27:21'!
invalidNumberOfCopiesErrorMessage

	^'Cannot add zero books'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'LL 1/25/2021 18:49:19'!
initializeWithSalesBook: aSalesBook

	salesBook := aSalesBook! !


!Cashier methodsFor: 'checkout' stamp: 'LL 1/25/2021 23:10:38'!
checkout: aCart payingWith: aCreditCard through: aMerchantProcessor on: aCheckoutDateTime  

	| ticket |
	self assertCanCheckout: aCart using: aCreditCard on: aCheckoutDateTime.
	
	ticket := aCart total.
	
	self debit: ticket value from: aCreditCard using: aMerchantProcessor.
	
	self registerSale: ticket.
	
	^ticket! !


!Cashier methodsFor: 'assertions' stamp: 'LL 1/25/2021 23:10:22'!
assertCanCheckout: aCart using: aCreditCard on: aDateTime 

	self assertContainsBooks: aCart.
	self assertIsNotExpired: aCreditCard on: aDateTime! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/24/2021 17:45:42'!
assertContainsBooks: aCart

	^ aCart isEmpty ifTrue: [	 self error: Cashier cannotCheckoutAnEmptyCart ]! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/25/2021 23:11:12'!
assertIsNotExpired: aCreditCard on: aDateTime 

	^ (aCreditCard isExpiredOn: aDateTime) ifTrue: [ self error: Cashier cannotCheckoutUsingAnExpiredCard ]! !


!Cashier methodsFor: 'private' stamp: 'LL 1/24/2021 18:23:28'!
debit: anAmount from: aCreditCard using: aMerchantProcessor

	^ [ aMerchantProcessor debit: anAmount from: aCreditCard ]
		on: Error - MessageNotUnderstood 
		do: [ :exceptionRaised |
			self error: self class couldNotProcessPaymentErrorMessage.
		]! !

!Cashier methodsFor: 'private' stamp: 'LL 1/25/2021 19:50:24'!
registerSale: ticket

	^ salesBook add: ticket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/21/2021 21:50:07'!
cannotCheckoutAnEmptyCart
	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 16:44:06'!
cannotCheckoutUsingAnExpiredCard

	^'Cannot checkout using an expired card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:13:36'!
couldNotProcessPaymentErrorMessage

	^'Cart was rejected'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/25/2021 18:48:59'!
registeringSalesOn: aSalesBook

	^ self new initializeWithSalesBook: aSalesBook.! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:33:37'!
add: minutes
	time:= time + (Duration days: 0 hours: 0 minutes: minutes seconds: 0).! !

!Clock methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:32:08'!
initialize
	time:= DateAndTime now.! !

!Clock methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:33:19'!
reset
	time:= DateAndTime now.! !

!Clock methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:33:07'!
substract: minutes
	time:= time - (Duration days: 0 hours: 0 minutes: minutes seconds: 0).! !

!Clock methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:36:04'!
time
	^time.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber owner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'LL 2/16/2021 18:05:42'!
initializeOf: aPerson number: aCreditCardNumber expiringOn: aMonthOfYear 

	owner := aPerson.
	creditCardNumber := aCreditCardNumber.
	expirationDate := aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'LL 2/16/2021 18:05:42'!
isExpiredOn: aDateTime

	^ aDateTime > (expirationDate lastDate)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LL 1/24/2021 18:15:40'!
of: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear

	nameOfTheOwner isEmpty ifTrue: [ self error: self nameCannotBeBlankErrorMessage ].
	
	^self new initializeOf: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear ! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:01:14'!
nameCannotBeBlankErrorMessage

	^'Name cannot be blank'! !


!classDefinition: #Interface category: 'TusLibros'!
Object subclass: #Interface
	instanceVariableNames: 'carts users cashier transactions merchantProcessor clocks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:38:53'!
addToCart: cartId book: bookIsbn quantity: aQuantity
	| aCart |
	self isAValidCartId: cartId.
	self isCartExpired: cartId .
	aCart := carts at: cartId.
	aCart add: bookIsbn quantity: aQuantity.
	(clocks at: cartId ) reset.
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:28:31'!
catalog
	|aCatalog|
	aCatalog := Dictionary new.
	aCatalog at: 'ABC124' put: (10*peso).
	aCatalog at: 'ABC323' put: (20*peso).
	aCatalog at: 'ABC723' put: (15*peso).
	^aCatalog .! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:52:10'!
checkOutCart: aCartId payingWith: aCardNumber expiresAt: aExpireDate of: aClientName
	| aCard aCart aTicket booksBought transactionId |
	self isAValidCartId: aCartId.
	self isCartExpired: aCartId.
	aCard := CreditCard of: aClientName number: aCardNumber expiringOn: aExpireDate.
	aCart := carts at: aCartId.
	aTicket := cashier checkout: aCart payingWith: aCard through: self on: GregorianDateTime now.
	booksBought := aCart listCartItems .
	transactions add: ( Transaction new initializeFor: (users at: aCartId) with: booksBought for: aTicket).
	transactionId := (transactions size) + 1.
	(clocks at: aCartId ) reset.
	^transactionId .! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:40:21'!
clockFor: aCartId
	^clocks at: aCartId .! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:34:50'!
createCartFor: aClientId with: password
	"Falta chequear el ID del usuario, ver donde crear el diccionario, ver donde meter los horarios"
	| aCart aCartId |
	(aClientId = '') ifTrue: [self error: 'Invalid client Id'].
	aCart := Cart acceptingItemsOf: self catalog .
	aCartId := (carts values size) + 1.
	carts add: aCartId->aCart.
	users add: aCartId->aClientId .
	clocks add: aCartId -> Clock new initialize.
	^aCartId.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:51:54'!
debit: anAmountToDebit from: aCreditCard
	^merchantProcessor value: anAmountToDebit value: aCreditCard .! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:49:50'!
initialize
	transactions := OrderedCollection new.
	carts := Dictionary new.
	users := Dictionary new.
	cashier := Cashier new initializeWithSalesBook: OrderedCollection new.
	merchantProcessor:= [ :anAmountToDebit :aCreditCard |  ].
	clocks:= Dictionary new.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 17:00:20'!
isAValidCartId: aCartId
	^(carts includesKey: aCartId ) ifFalse:[self error: 'Not valid cart ID']! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:38:13'!
isCartExpired: aCartId
	| aTime |
	aTime:= (clocks at: aCartId ) time.
	((DateAndTime now - aTime) minutes >= 30) ifTrue: [^self error: 'Cart expired'].! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:39:45'!
listCart: aCartId
	| aCart |
	
	self isAValidCartId: aCartId .
	self isCartExpired: aCartId.
	aCart := carts at: aCartId .
	(clocks at: aCartId ) reset.
	^aCart listCartItems .
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 18:53:32'!
listPurchasesFrom: aClientId with: aPassword
	| booksBought totalAmount |
	
	totalAmount := 0.
	booksBought := Dictionary new.
	transactions do: [ :aTransaction | 
		(aTransaction isFromClient: aClientId )	ifTrue:[
				totalAmount := totalAmount  + aTransaction total.
				self merge: booksBought with: aTransaction books.
			]
		].
	^Transaction new initializeFor: aClientId with: booksBought for: totalAmount.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 17:39:08'!
merge: aBookList with: anotherBookList

	anotherBookList do: [ :aBook |
		(aBookList includesKey: aBook ) ifTrue: [
			aBookList at: aBook put: (aBookList at: aBook) + (anotherBookList at: aBook).
			]
		ifFalse:[
			aBookList at: aBook  put: (anotherBookList at: aBook).
			]
		]! !


!classDefinition: #PublisherTestObjectsFactory category: 'TusLibros'!
Object subclass: #PublisherTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:41:18'!
aCashier

	| salesBook |
	salesBook := OrderedCollection new.
	^ Cashier registeringSalesOn: salesBook.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:45:08'!
aValidCreditCard

	| nextMonth |
	nextMonth := (FixedGregorianDate today next: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: nextMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/25/2021 18:29:34'!
anEmptyCart

	| aCatalog |
	aCatalog := Dictionary newFromPairs: {self bookFromTheEditorial. self bookFromTheEditorialPrice}.
	^Cart acceptingItemsOf: aCatalog.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:51:21'!
anEmptySalesBook

	^OrderedCollection new.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:43:38'!
anExpiredCreditCard
	
	| lastMonth |
	lastMonth := (FixedGregorianDate today previous: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: lastMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 15:59:26'!
bookFromTheEditorial

	^ 'ABC123'! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 17:11:28'!
bookFromTheEditorialPrice

	^ 1000 * peso! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:46:27'!
cartWithABook

	| cart |
	cart := self anEmptyCart.
	cart add: self bookFromTheEditorial.
	^cart! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:48:31'!
now 

	^GregorianDateTime now! !


!classDefinition: #Transaction category: 'TusLibros'!
Object subclass: #Transaction
	instanceVariableNames: 'clientId books total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Transaction methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 17:31:21'!
books
	^books! !

!Transaction methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 17:22:17'!
initializeFor: aClientId with: booksBought for: totalAmount
	clientId := aClientId.
	books := booksBought .
	total := totalAmount .
	! !

!Transaction methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 17:23:56'!
isFromClient: aClientId
	^clientId = aClientId .! !

!Transaction methodsFor: 'as yet unclassified' stamp: 'AG 2/25/2021 17:31:08'!
total
	^total.! !
