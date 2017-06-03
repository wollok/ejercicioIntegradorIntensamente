import Emociones.*
class Persona{ 
	var felicidad
	var dominante
	const fechaNacimiento
	var pensamientoActual 
	
	var recuerdosDelDia = []
	var pensamientosCentrales = #{}
	var largoPlazo = []
	var procesosMentales = []
		
	constructor(_felicidad,_dominante,_recuerdosDelDia,_pensamientosCentrales,_largoPlazo,_fechaNacimiento){
		felicidad = _felicidad
		dominante = _dominante
		recuerdosDelDia = _recuerdosDelDia
		pensamientosCentrales = _pensamientosCentrales
		largoPlazo = _largoPlazo
		fechaNacimiento = _fechaNacimiento // Estructura Date[Año-Mes-Dia]
	}	
	//Getters
	method felicidad() = felicidad
	method recuerdosDelDia() = recuerdosDelDia
	
	//method fecha() = fechaNacimiento
	
	//method largoPlazo() = largoPlazo
	
	method pensamientoActual() = pensamientoActual
	method pensamientoActual(pensamiento) {
		pensamientoActual = pensamiento
	} 
	

	method disminuirFelicidad(porcentaje){
		felicidad = felicidad * (100-porcentaje)/100
		if (felicidad  < 1)
			throw new Exception("La persona no puede soportar la tristeza")
	}
	
	method aumentarFelicidad(cantidad){
		felicidad = (felicidad + cantidad).min(1000) 
	}
	method muyFeliz() {
		return felicidad > 500
	}
	
	method dominante(_dominante){
		dominante=_dominante
	}

	method edad(){
		return new Date().year() - fechaNacimiento.year()
	}

	//Demás Métodos
	method agregarLargoPlazo(_recuerdos){
		largoPlazo.addAll(_recuerdos)
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
		var recuerdo = new Recuerdo(descripcion, new Date(),dominante )
		recuerdosDelDia.add(recuerdo)
	}

	//Vivir 2
	method asentar(recuerdo){
//		if (!recuerdo.sePuedeAsentar())
			recuerdo.asentarseEn(self)
	}
	//Vivir 3 (en realidad pide los ultimos, pero aca retornamos los primeros)
	method recuerdosRecientes(){
		return recuerdosDelDia.take(5)
	}
	//Vivir 4 (en realidad pide los ultimos, pero aca retornamos los primeros)
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
		pensamientosCentrales.drop(3)
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
		 pensamientoActual = largoPlazo.findOrElse({recuerdo => recuerdo.esRememorable(self)},{new Exception("Nada para rememorar")})
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
	
	constructor(_palabra) {
		palabra = _palabra
	}

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
	const fecha
	const descripcion
	const emocion
	
	constructor(_descripcion,_fecha, _emocion){
		fecha = _fecha // Estructura Date[Año-Mes-Dia]
		descripcion = _descripcion
		emocion = _emocion
	}

	method emocion() = emocion
	method descripcion()= descripcion

	method esRememorable(nena){
		return (new Date().year() - fecha.year())> (nena.edad()/2)
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
