class Persona{ 
	var property felicidad
	var property dominante 
	const fechaNacimiento
	var property pensamientoActual = null 
	
	var property recuerdosDelDia = []
	const pensamientosCentrales = #{}
	const largoPlazo = []
	const procesosMentales = []
		

	method disminuirFelicidad(porcentaje){
		felicidad = felicidad * (100-porcentaje)/100
		if (felicidad  < 1)
			throw new Exception(message = "La persona no puede soportar la tristeza")
	}
	
	method aumentarFelicidad(cantidad){
		felicidad = (felicidad + cantidad).min(1000) 
	}
	method muyFeliz() {
		return felicidad > 500
	}

	method edad(){
		return new Date().year() - fechaNacimiento.year()
	}

	//Demás Métodos
	method agregarLargoPlazo(recuerdos){
		largoPlazo.addAll(recuerdos)
	}
	method tieneLargoPlazo(recuerdo) {
		return largoPlazo.contains(recuerdo)
	}
	
	method agregarPensamientoCentral(recuerdo){
		pensamientosCentrales.add(recuerdo)
	}

	method tienePensamientoCentral(recuerdo){
		return pensamientosCentrales.contains(recuerdo)
	}
	method agregarProcesoMental(proceso){
		procesosMentales.add(proceso)
	}


	//Vivir 1
	method vivirEvento(descripcion){
		const recuerdo = new Recuerdo(descripcion  =descripcion, fecha = new Date(),emocion = dominante)
		recuerdosDelDia.add(recuerdo)
	}

	//Vivir 2
	method asentar(recuerdo){
			recuerdo.asentarseEn(self)
	}
	//Vivir 3 (Como pide los ultimos, se invierte la lista)
	method recuerdosRecientes(){
		return recuerdosDelDia.reverse().take(5)
	}
	//Vivir 4 ()
	method pensamientosCentrales(){
		return pensamientosCentrales
	}
	//Vivir 5 
	method centralesDificiles(){
		return pensamientosCentrales.filter({recuerdo => recuerdo.esDificil()})
	}
	//Descansar 6
	method niega(recuerdo){
		return dominante.niega(recuerdo)
	}
	//Descansar 7
	method dormir(){
		procesosMentales.forEach{ proceso=>proceso.desencadenarse(self)}
	}
			
	method asentarRecuerdos(recuerdos){
		recuerdos.forEach({recuerdo => self.asentar(recuerdo)})
	}
	
	method recuerdosCon(palabra){
		return recuerdosDelDia.filter{recuerdo => recuerdo.dice(palabra)}
	}
	
	method recuerdosProfundos(){
		 return recuerdosDelDia.filter{recuerdo => !self.tienePensamientoCentral(recuerdo) && !self.niega(recuerdo)} 
	 }

	method desequilibrarseHormonalmente(){
		felicidad *= 0.85
		3.times{i=>pensamientosCentrales.remove(self.pensamientoCentralMasAntiguo())}
	}
	method pensamientoCentralMasAntiguo(){
		return pensamientosCentrales.min{p=>p.fecha()}
	}

	method mismaEmocionEnElDia(){
  		return recuerdosDelDia.all{recuerdo => recuerdo.emocion() == recuerdosDelDia.head().emocion()}
 	}
 	
	method centralEnLargoPlazo(){
		return pensamientosCentrales.any{recuerdo => self.tieneLargoPlazo(recuerdo)}
	}
	
	method liberarRecuerdos() {
		recuerdosDelDia.clear()
	}
	
	// Rememorar 8
	method rememorar(){
		 pensamientoActual = largoPlazo.findOrElse(
		 	{recuerdo => recuerdo.esRememorable(self)},
		 	{throw new Exception(message = "Nada para rememorar")}
		 )
	}
	
	// Rememorar 9
	method repeticionesLargoPlazoDe(recuerdo){
		return largoPlazo.occurrencesOf(recuerdo)
	}

	// Rememorar 10
	method dejaVu(){	
		return self.tieneLargoPlazo(pensamientoActual)
	}
}

object asentamiento{
	method desencadenarse(nena){
		nena.asentarRecuerdos(nena.recuerdosDelDia())
	}
}	

class AsentamientoSelectivo {
	var palabra
	
	method desencadenarse(nena){
		nena.asentarRecuerdos(nena.recuerdosCon(palabra))
	}
}	
	
object profundizacion {
	method desencadenarse(nena){
		nena.agregarLargoPlazo(nena.recuerdosProfundos())
	}
}

object controlHormonal {
	method desencadenarse(nena){
		if(nena.mismaEmocionEnElDia() || nena.centralEnLargoPlazo())
			nena.desequilibrarseHormonalmente()
	}
}

object restauracionCognitiva{
	method desencadenarse(nena){
		nena.aumentarFelicidad(100)
	}
}

object liberacionDeRecuerdos{
	method desencadenarse (nena){
		nena.liberarRecuerdos()
	}
}

class Recuerdo{
	const property fecha = new Date()
	const property descripcion = ""
	const property emocion
	
	method esRememorable(nena){
		return (new Date().year() - fecha.year()) > (nena.edad()/2)
	}
	method asentarseEn(nena){
		emocion.consecunciasEn(nena,self)
	}
	method esDificil() {
		return descripcion.words().size()>10
	}
	method dice(palabra) {
		return descripcion.contains(palabra)
	}
	
}

class Emocion{
	method consecunciasEn(nena,recuerdo) {
		// No hay que hacer nada (furia, disgusto, temor) 
	}
	
	method niega(recuerdo) =  false
	method esAlegre() = false
	
	method agregarAPensamientosCentrales(nena,recuerdo){
  		if (!nena.tienePensamientoCentral(recuerdo))
   			nena.agregarPensamientoCentral(recuerdo)
 	}
}

const enojo = new Emocion()
const disgusto = new Emocion()
const temor = new Emocion()

object alegria inherits Emocion{
	override method consecunciasEn(nena, recuerdo){
		if (nena.muyFeliz())
			nena.agregarPensamientoCentral(recuerdo)
	}
	override method niega(recuerdo){
		return !recuerdo.emocion().esAlegre() 
	}
	override method esAlegre() = true
}
object tristeza inherits Emocion{
	override method consecunciasEn(nena, recuerdo){
		nena.agregarPensamientoCentral(recuerdo)
		nena.disminuirFelicidad(10) 
	}
	override method niega(recuerdo){
		return recuerdo.emocion().esAlegre() 
		
	}
}


class EmocionCompuesta{
	const emociones
	
	method esAlegre(){
		return emociones.any{emocion=>emocion.esAlegre()}
	}
	
	method consecunciasEn(nena,recuerdo){
		emociones.forEach{emocion => emocion.consecunciasEn(nena,recuerdo)}
	}
	method niega(recuerdo){
		return emociones.all{emocion => emocion.niega(recuerdo)}
	}
}


	

