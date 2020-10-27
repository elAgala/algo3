!classDefinition: #CintaAzul category: 'Factorio'!
DenotativeObject subclass: #CintaAzul
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaAzul class' category: 'Factorio'!
CintaAzul class
	instanceVariableNames: 'destino contenido'!

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:24:48'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:24:48'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:24:48'!
cantidadDeMenas
	^contenido size.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:24:49'!
conectarA: unDestino
	destino := unDestino.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 20:40:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaRoja.
	contenido := ((OrderedCollection new)).! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:44:43'!
moverMena
	destino agregar: (contenido at:1).
	contenido remove: (contenido at:1)! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:24:49'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaRoja category: 'Factorio'!
DenotativeObject subclass: #CintaRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaRoja class' category: 'Factorio'!
CintaRoja class
	instanceVariableNames: 'destino contenido'!

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:21:29'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:22:00'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:22:09'!
cantidadDeMenas
	^contenido size.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:20:03'!
conectarA: unDestino
	destino := unDestino.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 20:40:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := Contenedor.
	contenido := ((OrderedCollection new)).! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:44:25'!
moverMena
	destino agregar: (contenido at:1).
	contenido remove: (contenido at:1)! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:22:21'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #Contenedor category: 'Factorio'!
DenotativeObject subclass: #Contenedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Contenedor class' category: 'Factorio'!
Contenedor class
	instanceVariableNames: 'contenido'!

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:04'!
agregar: unaMena
	contenido add: unaMena.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:00'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:20'!
cantidadDeMenas
	^contenido size.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 20:40:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #carbon; add: #hierro; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:51'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'Factorio'!
ExtractorDeCarbon class
	instanceVariableNames: 'destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:23'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:50'!
extraer
	destino agregar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 20:40:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaRoja.! !


!classDefinition: #ExtractorDeHierro category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'Factorio'!
ExtractorDeHierro class
	instanceVariableNames: 'destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:25:13'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 19:29:48'!
extraer
	destino agregar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'II 10/26/2020 20:40:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaAzul.! !


!classDefinition: #FactorioTest category: 'Factorio'!
DenotativeObject subclass: #FactorioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FactorioTest class' category: 'Factorio'!
FactorioTest class
	instanceVariableNames: ''!

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 01:01:45'!
configurarCircuitoExtractorCaja.

	Contenedor vaciar.
	ExtractorDeCarbon conectarA: Contenedor.	
! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:55:32'!
hacerAndarCircuitoExtractorCaja

	ExtractorDeCarbon extraer.
	! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:53:55'!
test01ExtractorCaja
	self configurarCircuitoExtractorCaja.
	
	self hacerAndarCircuitoExtractorCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.! !


!FactorioTest class methodsFor: 'escenario 2' stamp: 'II 10/26/2020 19:18:28'!
configurarCircuitoExtractorCintaCaja

	Contenedor vaciar.
	CintaRoja vaciar.
	ExtractorDeCarbon conectarA: CintaRoja.
	CintaRoja conectarA: Contenedor
	
! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'II 10/26/2020 19:23:19'!
hacerAndarCircuitoExtractorCintaCaja

	ExtractorDeCarbon extraer.
	CintaRoja moverMena.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'II 10/26/2020 19:43:01'!
test02ExtractorCintaCaja
	self configurarCircuitoExtractorCintaCaja.
	
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	Assert that: CintaRoja cantidadDeMenas isEqualTo: 0.! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'II 10/26/2020 19:27:12'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	Contenedor vaciar.
	CintaRoja vaciar.
	CintaAzul vaciar.
	ExtractorDeCarbon conectarA: CintaRoja. 
	ExtractorDeHierro conectarA:  CintaAzul.
	CintaRoja conectarA: Contenedor.
	CintaAzul conectarA: CintaRoja 
	
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'II 10/26/2020 19:38:10'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja
	
	ExtractorDeCarbon extraer .
	ExtractorDeHierro extraer.
	CintaAzul moverMena.
	CintaRoja  moverMena.
	CintaRoja  moverMena.! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'II 10/26/2020 19:43:22'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	Assert that: CintaRoja cantidadDeMenas isEqualTo: 0.
	Assert that: CintaAzul cantidadDeMenas isEqualTo: 0.! !

CintaAzul initializeAfterFileIn!
CintaRoja initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!