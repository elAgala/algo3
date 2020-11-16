!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 5/7/2020 17:46:14'!
test27EnteroSubstractsEnteroCorrectly

	self assert: three - one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:46'!
denominator

	^denominator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:33:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:52'!
numerator

	^numerator! !


!Numero methodsFor: 'printing' stamp: 'II 11/9/2020 21:53:30'!
printOn: aStream
	^self subclassResponsibility ! !


!Numero methodsFor: 'comparing' stamp: 'II 11/9/2020 21:47:47'!
= anObject

	((anObject isKindOf: self class) and: [ type = anObject type ]) ifTrue: [
		^self subclassResponsibility 
	].

! !

!Numero methodsFor: 'comparing' stamp: 'II 11/9/2020 21:55:01'!
hash
	^self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!Numero class methodsFor: 'instance creation' stamp: 'II 11/16/2020 04:34:10'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^Entero with: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'II 11/12/2020 15:45:49'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	(aDivisor isNegative) ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^Fraccion new initializeWith: numerator over: denominator! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'testing' stamp: 'II 11/16/2020 05:04:13'!
isNegative
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'II 11/16/2020 05:04:20'!
isOne
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'II 11/16/2020 05:04:26'!
isZero
	
	self subclassResponsibility ! !


!Entero methodsFor: 'initialization' stamp: 'II 11/16/2020 05:43:09'!
initializeWith: aValue
	self subclassResponsibility 
	! !


!Entero methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:06:09'!
* aMultiplier 
	
	^aMultiplier multiplyToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:00:51'!
+ anAdder 
	
	^anAdder addToEntero:self 
	
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:26:48'!
- aSubtrahend 
	
	^aSubtrahend  substractFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:54:54'!
/ aDivisor 
	
	^ aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'II 11/9/2020 21:49:25'!
negated
	 ^self * (self class with: -1)! !


!Entero methodsFor: 'comparing' stamp: 'II 11/16/2020 03:49:25'!
= anObject

	^anObject equalsEntero: self! !

!Entero methodsFor: 'comparing' stamp: 'II 11/16/2020 05:51:06'!
hash

	^self integerValue hash! !


!Entero methodsFor: 'printing' stamp: 'II 11/16/2020 05:51:24'!
printOn: aStream

	aStream print: self integerValue ! !


!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 05:50:23'!
addToEntero:  anAugend
	
	^Numero with: self integerValue + anAugend integerValue! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 02:56:27'!
addToFraction: anAugend

	| newNumerator newDenominator |
		
	newNumerator := ( anAugend denominator * self) + anAugend numerator.
	newDenominator := anAugend denominator.
	
	^Numero with: newNumerator over: newDenominator! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:51:33'!
divideEntero: aDividend
	^Numero with: aDividend over: self! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:39:45'!
divideFraction: aDividen

	^Numero with:aDividen numerator over:aDividen denominator*self! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 05:50:44'!
equalsEntero: anEntero

	^self integerValue=anEntero integerValue ! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:47:06'!
equalsFraction: aFraction
	^False! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:13:59'!
multiplyToEntero: aMultiplicand

	^Numero with: aMultiplicand integerValue * self integerValue  ! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:13:06'!
multiplyToFraction: aMultiplicand
	
	|newNumerator newDenominator|
	
	newNumerator:=self * aMultiplicand numerator.
	newDenominator:= aMultiplicand denominator.
	
	^Numero with: newNumerator over: newDenominator! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:24:31'!
substractFromEntero: aMinuend
	^Numero with: aMinuend integerValue - self integerValue ! !

!Entero methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:29:55'!
substractFromFraction: aMinuend
	| newNumerator newDenominator |
	
	newNumerator := aMinuend numerator - (aMinuend denominator * self).
	newDenominator := aMinuend denominator.
	
	^Numero with:newNumerator over: newDenominator ! !


!Entero methodsFor: 'accessing' stamp: 'II 11/16/2020 05:13:45'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	self subclassResponsibility ! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'II 11/16/2020 05:55:41'!
// aDivisor 
	
	^Numero with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'jb 11/16/2020 14:31:21'!
fibonacci
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'II 11/16/2020 05:49:19'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (self integerValue gcd: anEntero integerValue)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'II 11/16/2020 05:33:22'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"

	
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue<0 ifTrue: [	^Negative with:aValue].
	aValue=0 ifTrue: [	^Zero with:aValue].
	aValue=1 ifTrue: [	^One with:aValue].
	^BiggerThanOne with:aValue! !


!classDefinition: #BiggerThanOne category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #BiggerThanOne
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!BiggerThanOne methodsFor: 'testing' stamp: 'II 11/16/2020 05:10:17'!
isNegative
	^false
	! !

!BiggerThanOne methodsFor: 'testing' stamp: 'II 11/16/2020 05:10:12'!
isOne
	^false
	! !

!BiggerThanOne methodsFor: 'testing' stamp: 'II 11/16/2020 05:10:08'!
isZero
	^false
	! !


!BiggerThanOne methodsFor: 'accessing' stamp: 'II 11/16/2020 05:12:36'!
integerValue
	^value! !


!BiggerThanOne methodsFor: 'initialization' stamp: 'II 11/16/2020 05:44:42'!
initializeWith:aValue
	value:=aValue! !


!BiggerThanOne methodsFor: 'arithmetic operations' stamp: 'jb 11/16/2020 14:30:48'!
fibonacci
	|one two|
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^(super - one) fibonacci  + (super - two) fibonacci.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BiggerThanOne class' category: 'Numeros-Parte2-Ejercicio'!
BiggerThanOne class
	instanceVariableNames: ''!

!BiggerThanOne class methodsFor: 'initialization' stamp: 'II 11/16/2020 05:38:49'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #Negative category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Negative
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Negative methodsFor: 'testing' stamp: 'II 11/16/2020 05:09:41'!
isNegative
	^true! !

!Negative methodsFor: 'testing' stamp: 'II 11/16/2020 05:09:47'!
isOne
	^false! !

!Negative methodsFor: 'testing' stamp: 'II 11/16/2020 05:09:52'!
isZero
	^false! !


!Negative methodsFor: 'accessing' stamp: 'II 11/16/2020 05:12:54'!
integerValue
	^value! !


!Negative methodsFor: 'initialization' stamp: 'II 11/16/2020 05:44:37'!
initializeWith:aValue
	value:=aValue! !


!Negative methodsFor: 'arithmetic operations' stamp: 'jb 11/16/2020 14:32:06'!
fibonacci
	^self error: Entero negativeFibonacciErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negative class' category: 'Numeros-Parte2-Ejercicio'!
Negative class
	instanceVariableNames: ''!

!Negative class methodsFor: 'initialization' stamp: 'II 11/16/2020 05:38:39'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #One category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #One
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!One methodsFor: 'testing' stamp: 'II 11/16/2020 05:09:25'!
isNegative
	^false! !

!One methodsFor: 'testing' stamp: 'II 11/16/2020 05:09:31'!
isOne
	^true! !

!One methodsFor: 'testing' stamp: 'II 11/16/2020 05:09:20'!
isZero
	^false! !


!One methodsFor: 'accessing' stamp: 'II 11/16/2020 05:13:18'!
integerValue
	^value! !


!One methodsFor: 'initialization' stamp: 'II 11/16/2020 05:44:30'!
initializeWith:aValue
	value:=aValue! !


!One methodsFor: 'arithmetic operations' stamp: 'jb 11/16/2020 14:22:24'!
fibonacci
	^Entero with: 1
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'One class' category: 'Numeros-Parte2-Ejercicio'!
One class
	instanceVariableNames: ''!

!One class methodsFor: 'initialization' stamp: 'II 11/16/2020 05:38:31'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #Zero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Zero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Zero methodsFor: 'testing' stamp: 'II 11/16/2020 05:08:43'!
isNegative
	^false! !

!Zero methodsFor: 'testing' stamp: 'II 11/16/2020 05:09:11'!
isOne
	^false! !

!Zero methodsFor: 'testing' stamp: 'II 11/16/2020 05:08:54'!
isZero
	^true! !


!Zero methodsFor: 'initialization' stamp: 'II 11/16/2020 05:44:24'!
initializeWith:aValue
	value:=aValue! !


!Zero methodsFor: 'accessing' stamp: 'II 11/16/2020 05:13:26'!
integerValue
	^value! !


!Zero methodsFor: 'arithmetic operations' stamp: 'jb 11/16/2020 14:23:01'!
fibonacci
	^Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zero class' category: 'Numeros-Parte2-Ejercicio'!
Zero class
	instanceVariableNames: ''!

!Zero class methodsFor: 'initialization' stamp: 'II 11/16/2020 05:35:35'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'II 11/16/2020 05:08:30'!
isNegative
	
	^numerator * denominator < 0 ! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:22:07'!
* aMultiplier 
	
	^aMultiplier multiplyToFraction: self ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:01:07'!
+ anAdder 
	
	^anAdder addToFraction:self ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:32:47'!
- aSubtrahend 

	^aSubtrahend  substractFromFraction: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'II 11/16/2020 03:39:21'!
/ aDivisor 
	
	^aDivisor divideFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'II 11/9/2020 21:49:36'!
negated
	^self class with: numerator * (self class with: -1) over: denominator! !


!Fraccion methodsFor: 'arithmetic operations-private' stamp: 'II 11/9/2020 21:15:58'!
// aDivisor 
		
	self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations-private' stamp: 'II 11/9/2020 21:14:23'!
greatestCommonDivisorWith: anEntero 
		
	self error: 'Tipo de número no soportado'! !


!Fraccion methodsFor: 'comparing' stamp: 'II 11/16/2020 03:47:42'!
= anObject

	^anObject equalsFraction: self! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:16:42'!
addToEntero:anAugend
	|newNumerator newDenominator|
	
	newNumerator:=self denominator * anAugend + self numerator.
	newDenominator:= self denominator.
	
	^Numero with: newNumerator over:newDenominator! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 02:58:11'!
addToFraction: anAugend

	| newNumerator newDenominator |
		
	newNumerator := (anAugend numerator * self denominator) + (anAugend denominator * self numerator).
		newDenominator := self denominator * anAugend denominator.
	
	^Numero with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:54:35'!
divideEntero: aDividend
	
	| newNumerator newDenominator |

	newNumerator:=aDividend * self denominator.
	newDenominator:= self numerator.

	^Numero with:newNumerator  over:newDenominator ! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:42:09'!
divideFraction: aDividend

	|newNumerator newDenominator|
	
	newNumerator:= aDividend numerator * self denominator.
	newDenominator:= aDividend denominator * self numerator.

	^Numero with: newNumerator over: newDenominator ! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:49:01'!
equalsEntero: anEntero
	
	^False! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:46:35'!
equalsFraction: aFraction
	^ (self numerator= aFraction numerator) &(self denominator= aFraction denominator)! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:12:36'!
multiplyToEntero: aMultiplicand
	
	|newNumerator newDenominator|
	
	newNumerator:= (self numerator) * (aMultiplicand).
	newDenominator:= self denominator.
		
	^Numero with:newNumerator over:newDenominator! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:08:18'!
multiplyToFraction: aMultiplicand
	
	|newNumerator newDenominator|
	
	newNumerator:= aMultiplicand numerator * self numerator. 
	newDenominator:= aMultiplicand denominator * self denominator.
	
	^Numero with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:26:29'!
substractFromEntero: aMinuend
	|newNumerator newDenominator|
	
	newNumerator:=self denominator * aMinuend - self numerator.
	newDenominator:= self denominator.
	
	^Numero with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'auxiliars' stamp: 'II 11/16/2020 03:31:32'!
substractFromFraction: aMinuend
	| newNumerator newDenominator |
	
	newNumerator := (aMinuend numerator * self denominator) - (aMinuend denominator * self numerator).
	newDenominator := aMinuend denominator * self denominator.
	
	^Numero with:newNumerator over:newDenominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
