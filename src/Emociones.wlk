import Riley.*
class Emocion{
	method consecunciasEn(nena,recuerdo) {
		// No es un olvido, no hay que hacer nada (furia, disgusto, temor) 
	}
	
	method niega(recuerdo) {
		return false
	}
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
		return recuerdo.emocion() != self 
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


	

