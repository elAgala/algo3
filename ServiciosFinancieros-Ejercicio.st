!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:32'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:38'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio hasAccount: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:45'!
test03PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:51'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:57'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:03'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 12/10/2020 03:38:47'!
test07PortfolioWithOnlyAccountsGivesTheBalanceCorrectlyOfMoreThanOneAccount

	| portfolio accountOne accountTwo|
	
	accountOne:= ReceptiveAccount new.
	accountTwo:= ReceptiveAccount new.
	
	Deposit register: 150*peso on:accountOne.
	Withdraw register: 50*peso on:accountOne.
	Deposit register: 50*peso on:accountTwo.
	Withdraw register: 25*peso on:accountTwo.
	
	portfolio:=Portfolio with:accountOne with:accountTwo .
	
	self assert: portfolio balance equals: 125*peso! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 12/10/2020 03:37:55'!
test08PortfolioWithOnlyAccountsCorrectlyTestIfATransactionIsInIt

	| portfolio accountOne accountTwo transaction|
	
	accountOne:= ReceptiveAccount new.
	accountTwo:= ReceptiveAccount new.
	
	Deposit register: 150*peso on:accountOne.
	Withdraw register: 50*peso on:accountOne.
	Deposit register: 50*peso on:accountTwo.
	transaction:=Withdraw register: 25*peso on:accountTwo.
	
	portfolio:=Portfolio with:accountOne with:accountTwo .
	
	self assert: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 12/10/2020 03:30:27'!
test09PortfolioBalanceGiveZeroWhenEmpty

	| portfolio |
	
	portfolio:=Portfolio new.
	
	self assert: portfolio balance equals: 0*peso! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 12/10/2020 03:40:13'!
test10ComposedPortfolioGivesTheBalanceCorrectly

	|composedPortfolio portfolio accountOne accountTwo|
	
	accountOne:= ReceptiveAccount new.
	accountTwo:= ReceptiveAccount new.
	
	Deposit register: 150*peso on:accountOne.
	Withdraw register: 50*peso on:accountOne.
	Deposit register: 50*peso on:accountTwo.
	Withdraw register: 25*peso on:accountTwo.
	
	
	portfolio:=Portfolio with:accountOne.
	
	composedPortfolio :=Portfolio with:portfolio  with:accountTwo.
		
	self assert: composedPortfolio balance equals: 125*peso! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 12/10/2020 03:41:36'!
test11ComposedPortfolioCorrectlyTestIfATransactionIsInIt

	| composedPortfolio portfolio accountOne accountTwo transaction|
	
	accountOne:= ReceptiveAccount new.
	accountTwo:= ReceptiveAccount new.
	
	Deposit register: 150*peso on:accountOne.
	Withdraw register: 50*peso on:accountOne.
	Deposit register: 50*peso on:accountTwo.
	transaction:=Withdraw register: 25*peso on:accountTwo.
	
	portfolio:=Portfolio with:accountOne. 
	
	composedPortfolio:=Portfolio with:portfolio with:accountTwo .
	
	self assert: (composedPortfolio hasRegistered: transaction)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:33'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 12/3/2020 21:09:18'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:54'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:01'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'NI 12/10/2020 01:49:53'!
test01TransferUpdateCorrectlyTheBalance

	| receiver giver|
	
	receiver := ReceptiveAccount new.
	giver := ReceptiveAccount new.
	
	Deposit register: 100 * peso on:receiver.
	Deposit register: 100 * peso on:giver.
	
	Transference from:giver to:receiver for:50*peso.
		
	self assert: giver balance equals: 50*peso.
	self assert: receiver  balance equals: 150*peso! !

!TransferTest methodsFor: 'tests' stamp: 'NI 12/10/2020 01:50:04'!
test02TransferReturnsTheValueOfATransfer

	| receiver giver transaction|
	
	receiver := ReceptiveAccount new.
	giver := ReceptiveAccount new.
	
	transaction:= Transference from:giver to:receiver for:50*peso.
		
	self assert: transaction value equals: 50*peso.
! !

!TransferTest methodsFor: 'tests' stamp: 'NI 12/10/2020 01:50:28'!
test03TransferGivesTheCounterPartCorrectly

	| receiver giver transaction|
	
	receiver := ReceptiveAccount new.
	giver := ReceptiveAccount new.
	
	transaction:= Transference from:giver to:receiver for:50*peso.
		
	self assert: transaction deposit counterPart equals: transaction withdraw.
	self assert: transaction withdraw counterPart equals: transaction deposit ! !

!TransferTest methodsFor: 'tests' stamp: 'NI 12/10/2020 01:50:41'!
test04TransferAddTheDepositAndWithdrawToTheAccounts

	| receiver giver transaction|
	
	receiver := ReceptiveAccount new.
	giver := ReceptiveAccount new.
	
	transaction:= Transference from:giver to:receiver for:50*peso.
		
	self assert: (giver hasRegistered: transaction deposit).
	self assert: (receiver hasRegistered: transaction withdraw).! !

!TransferTest methodsFor: 'tests' stamp: 'NI 12/10/2020 02:24:07'!
test05TransferenceNotAllowedBetweenTheSamePerson

	| account|
	
	account := ReceptiveAccount new.
	
	[Transference from:account to:account for:50*peso. self error: 'Not Error']
	on: Error
	do:[:anError| self assert: anError messageText = 'Receiver has to be different from giver']
		
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'testing' stamp: 'NI 12/9/2020 18:35:04'!
isDeposit
	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'testing' stamp: 'NI 12/9/2020 18:35:13'!
isWithdraw
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'NI 12/9/2020 22:43:15'!
pureValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'NI 12/9/2020 23:08:37'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DepositTransfer category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #DepositTransfer
	instanceVariableNames: 'value counterPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositTransfer methodsFor: 'initialization' stamp: 'NI 12/9/2020 23:22:14'!
chargeCounterPart:aCounterPart
	counterPart :=aCounterPart ! !

!DepositTransfer methodsFor: 'initialization' stamp: 'NI 12/9/2020 23:20:49'!
initializeFor: aValue

	value := aValue ! !


!DepositTransfer methodsFor: 'value' stamp: 'NI 12/10/2020 01:38:30'!
counterPart
	^counterPart ! !

!DepositTransfer methodsFor: 'value' stamp: 'NI 12/9/2020 23:20:49'!
pureValue

	^ value! !

!DepositTransfer methodsFor: 'value' stamp: 'NI 12/9/2020 23:20:49'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
DepositTransfer class
	instanceVariableNames: ''!

!DepositTransfer class methodsFor: 'instance creation' stamp: 'NI 12/9/2020 23:20:49'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'NI 12/9/2020 22:43:07'!
pureValue

	^ value * -1! !

!Withdraw methodsFor: 'value' stamp: 'NI 12/3/2020 21:08:48'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'NI 12/9/2020 23:08:43'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WithdrawTransfer category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #WithdrawTransfer
	instanceVariableNames: 'value counterPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!WithdrawTransfer methodsFor: 'initialization' stamp: 'NI 12/9/2020 23:22:24'!
chargeCounterPart:aCounterPart
	counterPart :=aCounterPart ! !

!WithdrawTransfer methodsFor: 'initialization' stamp: 'NI 12/9/2020 23:20:32'!
initializeFor: aValue

	value := aValue ! !


!WithdrawTransfer methodsFor: 'value' stamp: 'NI 12/10/2020 01:38:21'!
counterPart
	^counterPart ! !

!WithdrawTransfer methodsFor: 'value' stamp: 'NI 12/9/2020 23:20:32'!
pureValue

	^ value * -1! !

!WithdrawTransfer methodsFor: 'value' stamp: 'NI 12/9/2020 23:20:32'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
WithdrawTransfer class
	instanceVariableNames: ''!

!WithdrawTransfer class methodsFor: 'instance creation' stamp: 'NI 12/9/2020 23:20:32'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !


!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accessing' stamp: 'NI 12/10/2020 03:13:17'!
balance
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [0*peso].
	! !

!Portfolio methodsFor: 'accessing' stamp: 'NI 12/10/2020 03:23:14'!
hasRegistered: aTransaction
	accounts do:[:anAccount| (anAccount hasRegistered: aTransaction) ifTrue:[^true]].
	^false! !


!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NI 12/9/2020 22:44:17'!
balance
	
	^transactions sum: [ :aTransaction | aTransaction pureValue ] ifEmpty: [0*peso].
	! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'deposit withdraw giver receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'NI 12/9/2020 23:16:09'!
from:aReceiver to:aGiver withDeposit:aDeposit andWithdraw:aWithdraw 
	receiver:=aReceiver .
	giver :=aGiver.
	deposit :=aDeposit. 
	withdraw:=aWithdraw. ! !


!Transference methodsFor: 'value' stamp: 'NI 12/9/2020 23:42:32'!
deposit
	^deposit! !

!Transference methodsFor: 'value' stamp: 'NI 12/9/2020 23:16:38'!
value
	^deposit value! !

!Transference methodsFor: 'value' stamp: 'NI 12/9/2020 23:42:42'!
withdraw
	^withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'NI 12/10/2020 02:22:46'!
from:aGiver to:aReceiver for:aValue
	| given received|
	
	aGiver = aReceiver  ifTrue:[^self error:'Receiver has to be different from giver'].
	
	given:= WithdrawTransfer for: aValue.
	received:=DepositTransfer for: aValue.
	
	given chargeCounterPart: received.
	received chargeCounterPart: given.
		
	aGiver register: given.
	aReceiver  register: received.
	
	^Transference new from:aReceiver to:aGiver withDeposit:given andWithdraw:received! !
