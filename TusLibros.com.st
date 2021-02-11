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

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 04:56:43'!
test04WhenCreatingACartTheCartIsEmpty
		| aCart aUser aPasswordForUser books cartId|
	
	self setUp.
	
	aUser :='Julian'.
	aPasswordForUser := 'Test123'.
	
	aCart := shop createCartFor: aUser withPassword: aPasswordForUser. 
	
	cartId := (aCart copyFrom: 3 to: aCart size). 
	
	books:=shop listCart: cartId.
		
	self assert: (books = '0|').
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

!ShopTest methodsFor: 'testing' stamp: 'NI 2/11/2021 05:45:55'!
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
			
	self assert: (books = '0|ValidISBN1|2|ValidISBN2|3|' ).
	
	! !


!ShopTest methodsFor: 'setup' stamp: 'NI 2/11/2021 03:36:14'!
setUp
	|aCatalog|
	
	aCatalog:= OrderedCollection new.
	
	aCatalog add: 'ValidISBN1'.
	aCatalog add: 'ValidISBN2'.
	
	shop:=Shop for: aCatalog! !


!classDefinition: #Cart category: 'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'accesing' stamp: 'NI 2/10/2021 20:38:26'!
books
	^books! !

!Cart methodsFor: 'accesing' stamp: 'NI 2/11/2021 05:44:31'!
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


!Cart methodsFor: 'initialization' stamp: 'NI 2/10/2021 20:35:18'!
initialize
	books:= OrderedCollection new.! !


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


!classDefinition: #CartsLine category: 'TusLibros.com'!
Object subclass: #CartsLine
	instanceVariableNames: 'carts users passwords'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!


!classDefinition: #Shop category: 'TusLibros.com'!
Object subclass: #Shop
	instanceVariableNames: 'cartsLine catalog clients passwords'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Shop methodsFor: 'initialization' stamp: 'NI 2/11/2021 03:40:55'!
initializeWith:aCatalog
	catalog:=aCatalog.
	clients:= OrderedCollection new.
	passwords := OrderedCollection new.
	cartsLine := OrderedCollection  new.! !


!Shop methodsFor: 'testing' stamp: 'NI 2/11/2021 04:44:44'!
isAnInteger: aString
	|position|
	
	[position :=aString asInteger.
	self error:'Not Error'		]
		on:Error
		do:[:arg1| (arg1 messageText = 'Not Error') ifFalse:
		[^false]].
	
	^true! !


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

!Shop methodsFor: 'carts' stamp: 'NI 2/11/2021 03:53:51'!
createCartFor: aClient withPassword:aPassword
	| aCart|
	
	(aClient = '') ifTrue: [^ '1|Client Can Not Be NULL'].
	
	(aPassword = '') ifTrue: [^ '1|Password Can Not Be NULL'].
	
	aCart:=Cart new initialize. 
	
	cartsLine add:aCart.
	clients add:aClient.
	passwords add:aPassword.
	
	^('0|' append: cartsLine size asString)
	
	
	
	
	
	
	
	! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Shop class' category: 'TusLibros.com'!
Shop class
	instanceVariableNames: ''!

!Shop class methodsFor: 'as yet unclassified' stamp: 'NI 2/11/2021 03:41:05'!
for: aCatalog
	(aCatalog isKindOf: OrderedCollection) ifFalse: [^self error: 'The Catalog Should Be An Ordered Collection'].
	
	^self new initializeWith:aCatalog! !
