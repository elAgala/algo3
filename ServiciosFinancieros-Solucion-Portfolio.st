!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!


!AccountSummaryTest methodsFor: 'testing' stamp: 'NI 12/14/2020 20:19:50'!
test01AnEmptyAccountReturnsOnlyTheBalance
	|account summary summaryExpected summaryResult|
	
	account:=ReceptiveAccount  new.
	
	summary:=AccountSummary for: account.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'balance = 0 pesos'.
	
	summaryResult:= summary summary.
	
	self assert: (summaryExpected = summaryResult ).! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'NI 12/14/2020 19:55:10'!
test02AnEmptyPortfolioReturnsOnlyTheBalance
	|account summary summaryExpected summaryResult|
	
	account:=Portfolio new.
	
	summary:=AccountSummary for: account.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'balance = 0 pesos'.
	
	summaryResult:= summary summary.
	
	self assert: (summaryExpected = summaryResult ).
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'NI 12/14/2020 19:55:17'!
test03ASummaryIncludesEveryPosibleTransaction
	|account otherAccount summary summaryExpected summaryResult|
	
	account:=ReceptiveAccount  new.
	otherAccount:=ReceptiveAccount  new.
	
	Deposit register: 100*peso on:account.
	Withdraw register: 50*peso on: account.
	Transfer amount:200*peso from:otherAccount  to:account.
	Transfer amount: 50*peso from: account to:otherAccount.
	
	summary:=AccountSummary for: account.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'Depósito por: 100 pesos'.
	summaryExpected add: 'Extracción por: 50 pesos'.
	summaryExpected add: 'Entrada por transferencia de: 200 pesos'.
	summaryExpected add: 'Salida por transferencia de: 50 pesos'.
	summaryExpected add: 'balance = 200 pesos'.
	
	summaryResult:=summary summary.
	
	self assert: (summaryExpected = summaryResult ).
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'NI 12/14/2020 19:55:26'!
test04ASummaryfromaPotfolioIncludesEveryPosibleTransaction
	|account otherAccount portfolio summary summaryExpected summaryResult|
	
	account:=ReceptiveAccount  new.
	otherAccount:=ReceptiveAccount  new.
	
	Deposit register: 100*peso on:account.
	Withdraw register: 50*peso on: account.
	Transfer amount:200*peso from:otherAccount  to:account.
	Transfer amount: 50*peso from: account to:otherAccount.
	
	portfolio:=Portfolio with:account with:otherAccount.
	summary:=AccountSummary for: portfolio.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'Depósito por: 100 pesos'.
	summaryExpected add: 'Extracción por: 50 pesos'.
	summaryExpected add: 'Entrada por transferencia de: 200 pesos'.
	summaryExpected add: 'Salida por transferencia de: 50 pesos'.
	summaryExpected add: 'Salida por transferencia de: 200 pesos'.
	summaryExpected add: 'Entrada por transferencia de: 50 pesos'.
	summaryExpected add: 'balance = 50 pesos'.
	
	summaryResult:=summary summary.
	
	self assert: (summaryExpected = summaryResult ).
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

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

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:16'!
test07BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

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

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:31'!
test08BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

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

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:37'!
test09BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

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

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:42'!
test10PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

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

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:46'!
test11PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:51'!
test12PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:59'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:06'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:10'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:15'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:20'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferSummaryTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #TransferSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferSummaryTest methodsFor: 'testing' stamp: 'NI 12/14/2020 20:39:40'!
test01AnEmptyAccountReturnsOnlyTheBalance
	|account summary summaryExpected|
	
	account:=ReceptiveAccount  new.
	
	summary:=TransferSummary for: account.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'Neto por Transferencia = 0 pesos'.
	
	self assert: (summaryExpected = summary summary ).
	! !

!TransferSummaryTest methodsFor: 'testing' stamp: 'NI 12/14/2020 20:39:45'!
test02AnEmptyPortfolioReturnsOnlyTheBalance
	|account summary summaryExpected summaryResult|
	
	account:=Portfolio new.
	
	summary:=TransferSummary for: account.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'Neto por Transferencia = 0 pesos'.
	
	summaryResult:= summary summary.
	
	self assert: (summaryExpected = summaryResult ).
	! !

!TransferSummaryTest methodsFor: 'testing' stamp: 'NI 12/17/2020 14:58:50'!
test03ASummaryIncludesOnlyTransferTransactions
	|account otherAccount summary summaryExpected summaryResult|
	
	account:=ReceptiveAccount  new.
	otherAccount:=ReceptiveAccount  new.
	
	Deposit register: 100*peso on:account.
	Withdraw register: 50*peso on: account.
	Transfer amount:200*peso from:otherAccount  to:account.
	Transfer amount: 50*peso from: account to:otherAccount.
	
	summary:=TransferSummary for: account.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'Neto por Transferencia = 150 pesos'.
	
	summaryResult:=summary summary.
	
	self assert: (summaryExpected = summaryResult ).
	! !

!TransferSummaryTest methodsFor: 'testing' stamp: 'NI 12/17/2020 14:58:56'!
test04ASummaryfromaPotfolioIncludesOnlyTransferTransaction
	|account otherAccount portfolio summary summaryExpected summaryResult|
	
	account:=ReceptiveAccount  new.
	otherAccount:=ReceptiveAccount  new.
	
	Deposit register: 100*peso on:account.
	Withdraw register: 50*peso on: account.
	Transfer amount:200*peso from:otherAccount  to:account.
	Transfer amount: 50*peso from: account to:otherAccount.
	
	portfolio:=Portfolio with:account with:otherAccount.
	summary:=TransferSummary for: portfolio.
	
	summaryExpected:= OrderedCollection new.
	summaryExpected add: 'Neto por Transferencia = 0 pesos'.
	
	summaryResult:=summary summary.
	
	self assert: (summaryExpected = summaryResult ).
	! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

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


!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'NI 12/17/2020 18:37:43'!
summaryWith:aClosure

	^self subclassResponsibility ! !


!Account methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

!Account methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion-Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !




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


!Portfolio methodsFor: 'main protocol' stamp: 'LL 9/21/2020 01:35:22'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'NI 12/17/2020 18:37:33'!
summaryWith:aClosure

	accounts do:[:anAccount| anAccount summaryWith:aClosure].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
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


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion-Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/21/2020 01:35:28'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:53:32'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NI 12/17/2020 18:37:18'!
summaryWith:aClosure
	
	transactions do:[:aTransaction| aClosure value:aTransaction .]
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'testing' stamp: 'NI 12/9/2020 18:35:04'!
isDeposit
	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'testing' stamp: 'NI 12/9/2020 18:35:13'!
isWithdraw
	^self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'NI 12/17/2020 17:56:14'!
printMessageFor:aTypeOfSummary
	^aTypeOfSummary messageForDeposit: self.! !

!Deposit methodsFor: 'value' stamp: 'NI 12/9/2020 22:43:15'!
pureValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'value' stamp: 'NI 12/14/2020 20:01:26'!
printMessageFor:aTypeOfSummary
	^self subclassResponsibility ! !

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'value' stamp: 'NI 12/14/2020 20:04:23'!
printMessageFor:aTypeOfSummary
	^aTypeOfSummary messageForTransferDeposit: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'value' stamp: 'NI 12/14/2020 20:02:32'!
printMessageFor:aTypeOfSummary
	^aTypeOfSummary messageForTransferWithdraw: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'NI 12/14/2020 20:03:05'!
printMessageFor:aTypeOfSummary
	^aTypeOfSummary messageForWithdraw:self.! !

!Withdraw methodsFor: 'value' stamp: 'NI 12/9/2020 22:43:07'!
pureValue

	^ value * -1! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #Report
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Report methodsFor: 'summary' stamp: 'NI 12/17/2020 16:42:18'!
summary
	^self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion-Portfolio'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!AccountSummary methodsFor: 'summary' stamp: 'NI 12/17/2020 18:38:05'!
summary
	|summary total closure|
	
	total:=0*peso.
	
	summary:=OrderedCollection new.
	
	closure:=[:aTransaction| summary add: (aTransaction printMessageFor: self).
		total:=aTransaction affectBalance: total].
	
	account summaryWith:closure.
	
	summary add: ('balance = ' append: total asString).
	
	^summary
	! !


!AccountSummary methodsFor: 'initialization' stamp: 'NI 12/10/2020 20:55:09'!
with: anAccount
	account :=anAccount ! !


!AccountSummary methodsFor: 'messages' stamp: 'NI 12/14/2020 20:04:07'!
messageForDeposit:aDeposit
	^'Depósito por: ' append: (aDeposit value) asString! !

!AccountSummary methodsFor: 'messages' stamp: 'NI 12/14/2020 20:05:15'!
messageForTransferDeposit:aTransferDeposit
	^'Entrada por transferencia de: ' append: (aTransferDeposit value) asString! !

!AccountSummary methodsFor: 'messages' stamp: 'NI 12/14/2020 20:05:51'!
messageForTransferWithdraw:aTransferWithdraw
	^'Salida por transferencia de: ' append: (aTransferWithdraw value) asString! !

!AccountSummary methodsFor: 'messages' stamp: 'NI 12/14/2020 20:06:24'!
messageForWithdraw:aWithdraw
	^'Extracción por: ' append: (aWithdraw value) asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'NI 12/10/2020 20:54:50'!
for: anAccount
	^self new with:anAccount! !


!classDefinition: #TransferSummary category: 'ServiciosFinancieros-Solucion-Portfolio'!
Report subclass: #TransferSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferSummary methodsFor: 'testing' stamp: 'NI 12/17/2020 14:58:24'!
shouldAddForTotal:aTranasction
	^aTranasction isKindOf:TransferLeg! !


!TransferSummary methodsFor: 'summary' stamp: 'NI 12/17/2020 18:38:12'!
summary
	|summary total closure|
	
	total:=0*peso.
	
	summary:=OrderedCollection new.
	
	closure:=[:aTransaction| (self shouldAddForTotal: aTransaction)ifTrue:[
		total:=aTransaction affectBalance: total]].
	
	account summaryWith:closure.
	
	summary add: ('Neto por Transferencia = ' append: total asString).
	
	^summary

"
	|summary total|
	
	summary:=OrderedCollection new.
	
	total:=account totalSummary: summary from:self.
	
	summary add: ('Neto por Transferencia = ' append: total asString).
	
	^summary
	"! !


!TransferSummary methodsFor: 'initialization' stamp: 'NI 12/14/2020 20:12:16'!
with: anAccount
	account :=anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSummary class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferSummary class
	instanceVariableNames: ''!

!TransferSummary class methodsFor: 'instance creation' stamp: 'NI 12/14/2020 20:12:16'!
for: anAccount
	^self new with:anAccount! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !
