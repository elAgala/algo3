!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'jb 11/2/2020 21:51:06'!
calcularTimeEnMilliseconds: closure
	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closure.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning)
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/7/2020 18:53:37'!
chequearCantidadesEn: cantidades seanIgualesA: pruebas

	1 to: cantidades size do: 
	[ :index |
		self assert: (pruebas at: index value) equals: (cantidades at: index).
	].! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/7/2020 19:29:16'!
comprobarSi: closure esErrorEn: Error Para: condicion
 	[closure value. self fail]
		on:Error
		do:[:anError|
			 (condicion value: anError)]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/5/2020 17:10:11'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |

	customerBook := CustomerBook new.
	
	customerBook initialize.

	self assert: (self calcularTimeEnMilliseconds: [customerBook addCustomerNamed: 'John Lennon']) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/5/2020 17:11:23'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney|

	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self calcularTimeEnMilliseconds: [customerBook removeCustomerNamed: paulMcCartney.]) < (100 * millisecond)



	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/7/2020 19:36:13'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook condicion prueba|
			
	customerBook := CustomerBook new.
	condicion:=[customerBook addCustomerNamed: '']. 
	prueba:=[:anError| 
			self assert: (anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage).
			self assert: (customerBook isEmpty) ].
		
	self comprobarSi: condicion esErrorEn: Error Para: prueba
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/7/2020 19:36:07'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook condicion prueba johnLennon|
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	condicion:=[customerBook removeCustomerNamed: 'Paul McCartney'.]. 
	prueba:=[:anError| 
			self assert: (customerBook numberOfCustomers = 0).
			self assert: (customerBook includesCustomerNamed: johnLennon)].
	self comprobarSi: condicion esErrorEn: NotFound Para: prueba

	"		
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	"! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/7/2020 19:25:40'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney cantidad pruebas|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	
	cantidad:= #(0 1 1 true).
	
	pruebas:= OrderedCollection new.
	pruebas add: ([customerBook numberOfActiveCustomers] value).
	pruebas add: ([customerBook numberOfSuspendedCustomers] value).
	pruebas add: ([customerBook numberOfCustomers] value).
	pruebas add: ([customerBook includesCustomerNamed: paulMcCartney]value).
	self chequearCantidadesEn: cantidad seanIgualesA: pruebas.
	"
	self assert: (customerBook includesCustomerNamed: paulMcCartney)."
	"
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
"
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/7/2020 19:36:00'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon condicion prueba|
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	condicion:=[customerBook suspendCustomerNamed: 'Ringo Starr'.]. 
	prueba:=[:anError|
			self assert:customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)].
	self comprobarSi: condicion esErrorEn: CantSuspend Para: prueba
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'II 11/7/2020 19:35:47'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon condicion prueba |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	condicion:=[customerBook suspendCustomerNamed: johnLennon]. 
	prueba:=[:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
		
	self comprobarSi: condicion esErrorEn: CantSuspend Para: prueba

! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 11/2/2020 21:40:41'!
removeCustomerNamed: aName.

	(active includes: aName) ifTrue: [active remove: aName. ^aName ].
	(suspended includes: aName) ifTrue: [suspended remove: aName. ^aName ]. 
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'II 11/5/2020 17:08:02'!
removeName: aName fromCollection: aCollection

	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^True
			] 
	].

	^False.
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 11/2/2020 21:08:27'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
