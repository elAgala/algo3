!classDefinition: #ShopTest category: 'TusLibros.com'!
TestCase subclass: #ShopTest
	instanceVariableNames: 'shop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 04:16:57'!
test01WhenCreatingACartItReturns0
	| aCart aUser aPasswordForUser|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 
	
	self assert: ((aCart at:1) = $0).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 03:52:12'!
test02WhenCreatingACartWithBlankClientItReturns1AndATextSayingTheError
	| aCart aUser aPasswordForUser|
	
	self setUp.
	
	aUser :=''.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 
	
	self assert: (aCart  = '1|Client Can Not Be NULL').
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 03:52:52'!
test03WhenCreatingACartWithBlankPasswordItReturns1AndATextSayingTheError
	| aCart aUser aPasswordForUser|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := ''.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 
	
	self assert: (aCart  = '1|Password Can Not Be NULL').
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/18/2021 01:55:05'!
test04WhenCreatingACartTheCartIsEmpty
		| aCart aUser aPasswordForUser books cartId|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 
	
	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	books:=shop listCart: cartId.
		
	self assert: (books = '0|0').
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 04:58:11'!
test05WhenAddingAValidBookTheMethodReturn0
		| aCart aUser aPasswordForUser aBook cartId anAdition|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	aBook:='ValidISBN1'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	anAdition := shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
		
	self assert: (anAdition = '0|OK' ).
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 05:06:36'!
test06WhenAddingAnInvalidBookTheMethodDAdviceIt
		| aCart aUser aPasswordForUser aBook cartId anAdition|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	aBook:='InvalidISBN'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	anAdition := shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
		
	self assert: (anAdition = '1|Non Valid ISBN' ).
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 05:09:53'!
test07WhenAskingToAddToANonExistenIdTheMethodReturn1
	| aBook cartId anAdition|
	
	self setUp.
	
	aBook:='InvalidISBN'.
	
	cartId := 1.
	
	anAdition := shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
		
	self assert: (anAdition = '1|Non Existent CartId' ).
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 05:09:59'!
test08WhenAskingToListANonExistenIdTheMethodReturn1
	| cartId books|
	
	self setUp.
	
	cartId := 1.
	
	books := shop listCart: cartId.
	 		
	self assert: (books = '1|Non Existent CartId' ).
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 05:13:09'!
test09WhenAskingToAdd0BooksTheMethodReturns1
	| aCart aUser aPasswordForUser aBook cartId anAdition|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	aBook:='ValidISBN1'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	anAdition := shop addToCart: cartId anAmountOf:0 ofTheBook: aBook.
		
	self assert: (anAdition = '	1|The Amount Must Be A Positive Number' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/18/2021 01:56:02'!
test10WhenAskingToListBooksTheyAreListedCorrectly
	| aCart aUser aPasswordForUser aBook cartId books|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	aBook:='ValidISBN1'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	shop addToCart: cartId anAmountOf:2 ofTheBook: aBook.
	
	aBook:='ValidISBN2'.
	
	shop addToCart: cartId anAmountOf:3 ofTheBook: aBook.
	
	books:=shop listCart: cartId .
			
	self assert: (books = '0|ValidISBN1|2|ValidISBN2|3|5' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'NI 2/18/2021 16:47:32'!
test11WhenAskingToCheckOutACartWithAnExpiredCardItReturnError
	| aCart aUser aPasswordForUser cartId transaction aBook|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	aBook:='ValidISBN1'.
	
	shop addToCart: cartId anAmountOf:2 ofTheBook: aBook.
	
	
	transaction := shop checkOutCart: cartId forCard: 1111222233334444 expiratonDate: '012020' namedTo: aUser .
		
	self assert: (transaction = '1 | CARD_EXPIRED' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 17:42:32'!
test12WhenAskingToCheckOutAnEmptyCartItReturnsError
	| aCart aUser aPasswordForUser cartId transaction|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	transaction := shop checkOutCart: cartId forCard: 1111222233334444 expiratonDate: 042020 namedTo: aUser .
		
	self assert: (transaction = '1 | CART_EMPTY' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 18:30:12'!
test13WhenAskingToCheckOutWithInvalidCardReturnsError
	| aCart aUser aBook aPasswordForUser cartId transaction|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	aBook:='ValidISBN1'.

	shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
		
	transaction := shop checkOutCart: cartId forCard: 1111222233334444123123 expiratonDate: 042020 namedTo: aUser .
		
	self assert: (transaction = '1 | CARD_NUMBER_INVALID' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 18:30:06'!
test14WhenAskingToCheckOutWithInvalidCardOwnerNameReturnsError
	| aCart aUser aBook aPasswordForUser cartId transaction expirationDate |
	
	self setUp.
	
	aUser :='ASDASDASDASDASDASDASDASDASDASDASDASDASDASDASD'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	aBook:='ValidISBN1'.
	
	shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
		
	expirationDate := '042021'.
	transaction := shop checkOutCart: cartId forCard: 1111222233334443 expiratonDate: expirationDate namedTo: aUser .
	
	self assert: (transaction = '1 | INVALID_OWNER_NAME' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 18:29:58'!
test15WhenAskingToCheckOutSuccesfullyItReturns0
	| aCart aUser aBook aPasswordForUser cartId transaction expirationDate |
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	aBook:='ValidISBN1'.
	
	shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
		
	expirationDate := '042021'.
	transaction := shop checkOutCart: cartId forCard: 1111222233334443 expiratonDate: expirationDate namedTo: aUser .
	
	self assert: (transaction = '0|1' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 18:29:52'!
test16WhenAskingToCheckOutWithExpiredCardReturnsError
	| aCart aUser aBook aPasswordForUser cartId transaction expirationDate |
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	aBook:='ValidISBN1'.
	
	shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
		
	expirationDate := '042005'.
	transaction := shop checkOutCart: cartId forCard: 1111222233334443 expiratonDate: expirationDate namedTo: aUser .
	
	self assert: (transaction = '1 | CARD_EXPIRED' ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 18:29:42'!
test17WhenAskingToCheckOutTransactionAmountIsCorrect
	| aCart aUser aBook aPasswordForUser cartId transaction transactionResponse expirationDate anotherBook|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	aBook:='ValidISBN1'.
	anotherBook:='ValidISBN2'.
	
	shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
	shop addToCart: cartId anAmountOf:1 ofTheBook: anotherBook .
	expirationDate := '042021'.
	transactionResponse := shop checkOutCart: cartId forCard: 1111222233334443 expiratonDate: expirationDate namedTo: aUser .
	transaction := shop 	getTransaction: 1.
	self assert: [(transactionResponse = '0|1' ) and: (transaction amount = 55) ].
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 18:29:33'!
test18WhenAskingForUserTransactionsItMatches
	| purchaseString expectedString aCart aUser aBook aPasswordForUser cartId expirationDate anotherBook|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 

	cartId := (aCart copyFrom: 3 to: aCart size). 
	aBook:='ValidISBN1'.
	anotherBook:='ValidISBN2'.
	
	shop addToCart: cartId anAmountOf:1 ofTheBook: aBook.
	shop addToCart: cartId anAmountOf:2 ofTheBook: anotherBook .
	expirationDate := '042021'.
	shop checkOutCart: cartId forCard: 1111222233334443 expiratonDate: expirationDate namedTo: aUser .
	expectedString := '0|ValidISBN1|1|ValidISBN2|2|3'.
	purchaseString:= shop listPurchasesFor: aUser withPassword: aPasswordForUser.
	self assert:( purchaseString isEqualTo: expectedString ).
	
	! !

!ShopTest methodsFor: 'testing' stamp: 'AG 2/18/2021 18:33:09'!
test19WhenAskingForUserTransactionsWithNoPurchasesDoesNotMatch
	| aCart aUser aPasswordForUser purchaseString |
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser.
	purchaseString := shop listPurchasesFor: aUser withPassword: aPasswordForUser .
	self assert: purchaseString = '1 | NO_TRANSACTIONS_DETECTED'.
	
	! !


!ShopTest methodsFor: 'setup' stamp: 'AG 2/18/2021 13:49:04'!
setUp
	|book1 price1 book2 price2|
	
	shop:=Shop new initialize.
	
	book1:= 'ValidISBN1'.
	price1:=25.
	
	shop add:book1 withAPriceOf:price1.
	
	book2:= 'ValidISBN2'.
	price2:=30.
	
	shop add:book2 withAPriceOf:price2.
	! !


!classDefinition: #Cart category: 'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'books shop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'accesing' stamp: 'NI 2/10/2021 20:38:26'!
books
	^books! !

!Cart methodsFor: 'accesing' stamp: 'AG 2/18/2021 14:06:29'!
isEmpty
	
	^books size = 0! !

!Cart methodsFor: 'accesing' stamp: 'NI 2/18/2021 01:54:46'!
listBooks
	|stringBooks booksAlreadyListed|
	
	stringBooks :='|'.
	booksAlreadyListed :=OrderedCollection new.
	
	books do:[:aBook|
		(booksAlreadyListed includes: aBook ) ifFalse:[
			stringBooks:= stringBooks append: aBook.
			stringBooks:= stringBooks append: '|' .
			stringBooks:= stringBooks append: (self quantityOf:aBook)asString.
			stringBooks:= stringBooks append: '|' .
			].
		
		booksAlreadyListed add: aBook.
		].
	stringBooks:= stringBooks append: (books size)asString .
	^stringBooks ! !

!Cart methodsFor: 'accesing' stamp: 'NI 2/11/2021 05:20:15'!
quantityOf: aBook

	|quantity|
	
	quantity :=0.

	books do:[:aBookListed|
		(aBookListed = aBook) ifTrue: [quantity :=quantity+1]
		].
	
	^quantity
	
	! !

!Cart methodsFor: 'accesing' stamp: 'AG 2/18/2021 18:11:25'!
totalAmount

	| amount |
	
	amount := 0.
	books do: [ :aBook |
		amount := amount + (shop priceOf: aBook) asInteger .
	].
	^amount.! !


!Cart methodsFor: 'initialization' stamp: 'NI 2/10/2021 20:35:18'!
initialize
	books:= OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'NI 2/18/2021 03:08:44'!
initializeFor:aShop
	books:= OrderedCollection new.
	shop:=aShop.! !


!Cart methodsFor: 'adding' stamp: 'NI 2/11/2021 05:04:47'!
add: aQuantity OfBook: aBook
	
	|anAmount|
	
	anAmount:=aQuantity .
	
	[anAmount = 0] whileFalse:[
		books add:aBook.
		anAmount  := anAmount  -1
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'NI 2/10/2021 22:44:03'!
for: aClient withPassword:aPassword
	"
	| aChart |
	"
	(aClient = '') ifTrue: [^ self error: 'Client Can Not Be NULL'].
	
	(aPassword = '') ifTrue: [^ self error: 'Password Can Not Be NULL'].
	
	^self new initialize! !


!classDefinition: #MerchantProcessor category: 'TusLibros.com'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'NI 2/18/2021 16:17:48'!
debitCard: cardNumber expiringAt: expirationDate namedTo: cardOwner for: anAmount
	| today expirationMonth expirationYear expiration |

	(cardNumber asString size = 16) ifFalse: [ ^'1 | CARD_NUMBER_INVALID'].
	(expirationDate asNumber isNumber) ifFalse: [^'1 | INVALID_EXPIRATION_DATE'].
	(expirationDate  asString size = 6) ifFalse: [^'1 | INVALID_EXPIRATION_DATE'].
	today:= Date today.
	expirationMonth := (expirationDate asString copyFrom:1 to:2)asInteger.
	expirationYear:=(expirationDate asString copyFrom:3 to:6)asInteger.
	(expirationMonth = 12) ifTrue: [expirationMonth :=1.
		expirationYear := expirationYear +1] ifFalse:[expirationMonth :=expirationMonth +1].
	
	expiration := Date newDay: 1 month: (Date nameOfMonth:expirationMonth ) year: expirationYear .
	
	(today > expiration or: today = expiration) ifTrue: [^'1 | CARD_EXPIRED'].

	(cardOwner size > 30) ifTrue: [^'1 | INVALID_OWNER_NAME'].
	
	^'0|'! !


!classDefinition: #Shop category: 'TusLibros.com'!
Object subclass: #Shop
	instanceVariableNames: 'cartsLine catalog prices clients passwords transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Shop methodsFor: 'initialization' stamp: 'NI 2/18/2021 16:19:07'!
initialize
	catalog := OrderedCollection new.
	clients:= OrderedCollection new.
	passwords := OrderedCollection new.
	cartsLine := OrderedCollection  new.
	prices := OrderedCollection  new.
	transactions:=OrderedCollection new.! !


!Shop methodsFor: 'catalog' stamp: 'NI 2/18/2021 02:45:08'!
add: aBook withAPriceOf:aPrice
	catalog add: aBook.
	prices add:aPrice.! !

!Shop methodsFor: 'catalog' stamp: 'AG 2/18/2021 15:21:24'!
indexOf: aBookISBN
	| index |
	
	index:=1.
	catalog do:[:aISBN|
		(aBookISBN  = aISBN ) ifTrue:[^index].
		index := index + 1.
	].! !

!Shop methodsFor: 'catalog' stamp: 'AG 2/18/2021 15:20:41'!
priceOf: aBookISBN

	| index |
	
	(catalog includes:aBookISBN) ifFalse: [^'1 | INVALID_ISBN'].
	index := self indexOf: aBookISBN .
	^prices at: (index asInteger ).! !


!Shop methodsFor: 'testing' stamp: 'NI 2/11/2021 04:44:44'!
isAnInteger: aString
	|position|
	
	[position :=aString asInteger.
	self error:'Not Error'		]
		on:Error
		do:[:arg1| (arg1 messageText = 'Not Error') ifFalse:
		[^false]].
	
	^true! !


!Shop methodsFor: 'purchases' stamp: 'AG 2/18/2021 18:31:52'!
listPurchasesFor: aClient withPassword:aPassword
	
	|books stringBooks booksAlreadyListed|
	
	books:=OrderedCollection new.
		
	transactions do:[:aTransaction|
		(aTransaction isFrom: aClient withPassword: aPassword ) ifTrue:[
			(aTransaction books) do: [:aBook| books add:aBook].
		]
	].

	(books size=0) ifTrue:[^'1 | NO_TRANSACTIONS_DETECTED'].
	
	stringBooks :='0|'.
	booksAlreadyListed :=OrderedCollection new.
	
	books do:[:aBook|
		(booksAlreadyListed includes: aBook ) ifFalse:[
			stringBooks:= stringBooks append: aBook.
			stringBooks:= stringBooks append: '|' .
			stringBooks:= stringBooks append: (self quantityOf:aBook in:books)asString.
			stringBooks:= stringBooks append: '|' .
			].
		
		booksAlreadyListed add: aBook.
		].
	
	stringBooks:= stringBooks append: (books size)asString .
	
	^stringBooks 
	! !

!Shop methodsFor: 'purchases' stamp: 'NI 2/18/2021 16:46:08'!
quantityOf: aBook in:books

	|quantity|
	
	quantity :=0.

	books do:[:aBookListed|
		(aBookListed = aBook) ifTrue: [quantity :=quantity+1]
		].
	
	^quantity! !


!Shop methodsFor: 'carts' stamp: 'NI 2/11/2021 05:12:41'!
addToCart: aCartId anAmountOf: anAmount ofTheBook: aBookISBN
	| aCart position|
	
	(self isAnInteger: aCartId ) ifFalse: [^'1|Non Valid CartId'].
	
	position:=aCartId asInteger.
	
	(position > cartsLine size) ifTrue: [^'1|Non Existent CartId'].
	
	(catalog includes:aBookISBN) ifFalse: [^'1|Non Valid ISBN'].
	
	(anAmount<1) ifTrue:[^'	1|The Amount Must Be A Positive Number'].
	
	aCart := cartsLine at:position. 
	
	aCart add:anAmount OfBook: aBookISBN.
	
	^ '0|OK'! !

!Shop methodsFor: 'carts' stamp: 'AG 2/18/2021 18:10:07'!
checkOutCart: aCartId forCard: cardNumber expiratonDate: aExpirationDate namedTo: cardOwner
	
	| position cart transactionAmount response merchantProcessor transaction|
	
	position := 	aCartId  asInteger.
	(position > cartsLine size ) ifTrue:[^'1 | INVALID_CART_ID'].
	cart := cartsLine at: position.
	(cart isEmpty ) ifTrue:[^'1 | CART_EMPTY'].
	transactionAmount  := cart totalAmount .
	merchantProcessor  := MerchantProcessor new.
	response := merchantProcessor debitCard:cardNumber expiringAt:aExpirationDate namedTo:cardOwner for: transactionAmount .
	
	((response at:1) = $1) ifTrue:[^response.].
	
	transaction:=Transaction new initializeFor: (clients at:position ) withPassword: (passwords at:position) aPurchaseOf: cart books for: transactionAmount .
	
	transactions add:transaction.
	^response append: (transactions size)asString
	
	! !

!Shop methodsFor: 'carts' stamp: 'NI 2/18/2021 03:15:17'!
createCartFor: aClient withPassword:aPassword
	| aCart|
	
	(aClient = '') ifTrue: [^ '1|Client Can Not Be NULL'].
	
	(aPassword = '') ifTrue: [^ '1|Password Can Not Be NULL'].
	
	aCart:=Cart new initializeFor:self. 
	
	cartsLine add:aCart.
	clients add:aClient.
	passwords add:aPassword.
	
	^('0|' append: cartsLine size asString)
	
	
	
	
	
	
	
	! !

!Shop methodsFor: 'carts' stamp: 'AG 2/18/2021 18:13:37'!
getTransaction: transactionId

	^transactions at: transactionId ! !

!Shop methodsFor: 'carts' stamp: 'NI 2/11/2021 05:43:56'!
listCart: aCartId
	| aCart position stringBooks|
	
	(self isAnInteger: aCartId ) ifFalse: [^'1|Non Valid CartId'].
	
	position:=aCartId asInteger.
	
	(position > cartsLine size) ifTrue: [^'1|Non Existent CartId'].
	
	aCart := cartsLine at:position. 
	
	stringBooks := '0'.
	
	stringBooks:= stringBooks append: aCart listBooks.
	
	
	^stringBooks ! !


!classDefinition: #Transaction category: 'TusLibros.com'!
Object subclass: #Transaction
	instanceVariableNames: 'client password books amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Transaction methodsFor: 'accesing' stamp: 'AG 2/18/2021 18:12:21'!
amount
	^amount! !

!Transaction methodsFor: 'accesing' stamp: 'NI 2/18/2021 16:41:22'!
books
	^books! !

!Transaction methodsFor: 'accesing' stamp: 'NI 2/18/2021 16:28:29'!
isFrom: aClient withPassword:aPassword
	^ (aClient = client and: aPassword=password)! !


!Transaction methodsFor: 'initialization' stamp: 'AG 2/18/2021 18:09:26'!
initializeFor: aClient withPassword:aPassword aPurchaseOf:booksBought for: anAmount
	client:=aClient.
	password:=aPassword.
	books:=booksBought.
	amount:=anAmount 
	! !
