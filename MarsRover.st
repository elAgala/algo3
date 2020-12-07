!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/5/2020 16:34:38'!
test01WhenCreatedAMarsRoverThePositionGivenIsTheOneAskedFor

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#North.

	self assert: marsRoverTest xPosition=0.
	self assert: marsRoverTest yPosition=0.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/5/2020 16:46:46'!
test02WhenCreatedAMarsRoverTheDirectionGivenIsTheOneAskedFor

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#North.

	self assert: marsRoverTest cardinalDirection = #North
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:55:01'!
test03WhenAskingToCreateAMarsRoverFacingANonExistingDirectionTheMethodReturnError

	
	[MarsRover initializeAtX:0 andY:0 facing:#Sorth.self error:'Not Error']
	on:Error
	do:[:anerror| self assert: anerror messageText = 'Not a Valid Type' ]
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:28:56'!
test04WhenCreatedAMarsRoverFacingNorthAndAskToMoveForwardTheYCoordinateGetsBigger

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#North.

	marsRoverTest  executeCommands:'f'.
	
	self assert: marsRoverTest yPosition = 1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:29:01'!
test05WhenCreatedAMarsRoverFacingSouthAndAskToMoveForwardTheYCoordinateGetsSmaller

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#South.

	marsRoverTest  executeCommands:'f'.
	
	
	self assert: marsRoverTest yPosition = -1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:54:34'!
test06WhenCreatedAMarsRoverFacingEastAndAskToMoveForwardTheXCoordinateGetsBigger

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#East.

	marsRoverTest  executeCommands:'f'.
	
	self assert: marsRoverTest xPosition = 1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:29:15'!
test07WhenCreatedAMarsRoverFacingWestAndAskToMoveForwardTheXCoordinateGetsSmaller

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#West.

	marsRoverTest  executeCommands:'f'.
	
	self assert: marsRoverTest xPosition = -1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:29:42'!
test08WhenCreatedAMarsRoverFacingWestAndAskToMoveBackwardsTheXCoordinateGetsBigger

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#West.
	
	marsRoverTest  executeCommands:'b'.
	
	self assert: marsRoverTest xPosition = 1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:32:41'!
test09WhenCreatedAMarsRoverFacingEastAndAskToMoveBackwardsTheXCoordinateGetsSmaller

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#East.
	
	marsRoverTest  executeCommands:'b'.
	
	self assert: marsRoverTest xPosition = -1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:32:10'!
test10WhenCreatedAMarsRoverFacingNorthAndAskToMoveBackwardsTheXCoordinateGetsSmaller

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#North.
	
	marsRoverTest  executeCommands:'b'.
	
	self assert: marsRoverTest yPosition = -1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:32:32'!
test11WhenCreatedAMarsRoverFacingSouthAndAskToMoveBackwardsTheXCoordinateGetsBigger

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#South.
	
	marsRoverTest  executeCommands:'b'.
	
	self assert: marsRoverTest yPosition = 1
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:33:02'!
test12WhenCreatedAMarsRoverFacingNorthAndAskToRotateLeftItsFacingWest

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#North.

	marsRoverTest  executeCommands:'l'.
	
	self assert: marsRoverTest cardinalDirection = #West
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:33:29'!
test13WhenCreatedAMarsRoverFacingWestAndAskToRotateLeftItsFacingSouth

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#West.

	marsRoverTest  executeCommands:'l'.
	
	self assert: marsRoverTest cardinalDirection = #South
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:34:55'!
test14WhenCreatedAMarsRoverFacingEastAndAskToRotateLeftItsFacingNorth

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#East.

	marsRoverTest  executeCommands:'l'.
	
	self assert: marsRoverTest cardinalDirection = #North
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:35:52'!
test15WhenCreatedAMarsRoverFacingSouthAndAskToRotateLeftItsFacingEast

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#South.

	marsRoverTest  executeCommands:'l'.
	
	self assert: marsRoverTest cardinalDirection = #East
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:37:29'!
test16WhenCreatedAMarsRoverFacingSouthAndAskToRotateRightItsFacingWest

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#South.

	marsRoverTest  executeCommands:'r'.
	
	self assert: marsRoverTest cardinalDirection = #West
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:37:33'!
test17WhenCreatedAMarsRoverFacingWestAndAskToRotateRightItsFacingNorth

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#West.

	marsRoverTest  executeCommands:'r'.
	
	self assert: marsRoverTest cardinalDirection = #North
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:38:00'!
test18WhenCreatedAMarsRoverFacingNorthAndAskToRotateRightItsFacingEast

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#North.

	marsRoverTest  executeCommands:'r'.
	
	self assert: marsRoverTest cardinalDirection = #East	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:38:40'!
test19WhenCreatedAMarsRoverFacingEastAndAskToRotateRightItsFacingSouth

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#East.

	marsRoverTest  executeCommands:'r'.
	
	self assert: marsRoverTest cardinalDirection = #South! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:41:17'!
test20WhenCreatedAMarsRoverAndSendingMoreThanOneCommandTheMovementIsCorrectlyExecuted

	| marsRoverTest |
	
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#North.

	marsRoverTest  executeCommands:'frfrfrf'.
	
	self assert: marsRoverTest cardinalDirection = #West.
	self assert: marsRoverTest yPosition = 0.
	self assert: marsRoverTest xPosition = 0.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'NI 12/7/2020 17:58:58'!
test21WhenCreatedAMarsRoverAndSendingANonValidCommandTheMethodReturnAnError

	| marsRoverTest |
	marsRoverTest := MarsRover initializeAtX:0 andY:0 facing:#South.
	
	[marsRoverTest executeCommands: 'fffjff']
	on:Error
	do:[:anerror| self assert: anerror messageText =  'Not a Valid Command'.
		self assert: marsRoverTest yPosition =-3]
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinateX coordinateY directionX directionY'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'testing' stamp: 'NI 12/7/2020 17:11:35'!
isAValidCommand: aCommand
	aCommand = $f ifTrue:[^true].
	aCommand = $b ifTrue:[^true].
	aCommand = $l ifTrue:[^true].
	aCommand = $r ifTrue:[^true].
	^false! !


!MarsRover methodsFor: 'movement' stamp: 'NI 12/7/2020 17:30:55'!
b
	coordinateX :=coordinateX - directionX.
	coordinateY :=coordinateY - directionY.! !

!MarsRover methodsFor: 'movement' stamp: 'NI 12/7/2020 17:56:07'!
executeCommands: commandsString

	commandsString 	do:[:aCommand| 
		aCommand = $f ifTrue:[self f].
		aCommand = $b ifTrue:[self b].
		aCommand = $l ifTrue:[self l].
		aCommand = $r ifTrue:[self r].
		(self isAValidCommand:aCommand) ifFalse:[^self error:'Not a Valid Command']
		]! !

!MarsRover methodsFor: 'movement' stamp: 'NI 12/7/2020 16:16:23'!
f
	coordinateX:= coordinateX + directionX.
	coordinateY:= coordinateY + directionY.! !

!MarsRover methodsFor: 'movement' stamp: 'NI 12/7/2020 16:32:28'!
l
	|auxiliar|
	
	auxiliar:=directionX. 
	
	directionX:=directionY *-1.
	directionY:=auxiliar
	
	! !

!MarsRover methodsFor: 'movement' stamp: 'NI 12/7/2020 16:33:04'!
r
	|auxiliar|
	
	auxiliar:=directionX. 
	
	directionX:=directionY.
	directionY:=auxiliar* -1.
	
	! !


!MarsRover methodsFor: 'initialization' stamp: 'NI 12/7/2020 16:02:24'!
initializeAtX:aXCoordinate andY:aYCoordinate facingX: aXDirection andFacingY: aYDirection 

	coordinateX:=aXCoordinate .
	coordinateY:=aYCoordinate .
	directionX := aXDirection.
	directionY:= aYDirection. 
	! !


!MarsRover methodsFor: 'values' stamp: 'NI 12/7/2020 16:17:52'!
cardinalDirection
	directionX = 1 ifTrue: [^#East]. 
	directionX = -1 ifTrue: [^#West].
	directionY = 1 ifTrue: [^#North].
	directionY = -1 ifTrue: [^#South].! !

!MarsRover methodsFor: 'values' stamp: 'NI 12/5/2020 16:33:43'!
xPosition
	^coordinateX ! !

!MarsRover methodsFor: 'values' stamp: 'NI 12/5/2020 16:34:27'!
yPosition
	^coordinateY ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'NI 12/7/2020 17:51:49'!
initializeAtX:aXCoordinate andY:aYCoordinate facing:aCardinalDirection

	aCardinalDirection = #North ifTrue:[^self new initializeAtX: aXCoordinate andY: aYCoordinate facingX:0 andFacingY:1].
	aCardinalDirection = #East ifTrue:[^self new initializeAtX: aXCoordinate andY: aYCoordinate facingX:1 andFacingY:0].
	aCardinalDirection = #South ifTrue:[^self new initializeAtX: aXCoordinate andY: aYCoordinate facingX:0 andFacingY:(-1)].
	aCardinalDirection = #West ifTrue:[^self new initializeAtX: aXCoordinate andY: aYCoordinate facingX:(-1) andFacingY:0].
	^self error: 'Not a Valid Type' ! !
