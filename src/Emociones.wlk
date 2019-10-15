import Riley.*
class Emocion{
	method consecunciasEn(nena,recuerdo){}
	
	method niega(recuerdo) {
		return false
	}
	
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
}
object tristeza inherits Emocion{
	override method consecunciasEn(nena, recuerdo){
		nena.agregarPensamientoCentral(recuerdo)
		nena.disminuirFelicidad(10) 
	}
	override method niega(recuerdo){
		//return [recuerdo.emocion()] == [alegria]
		return recuerdo.emocion() == alegria
		
	}
}


class EmocionCompuesta{
	const emociones
	
	method esAlegre(){
		return emociones.contains(alegria)
	}
	
	method consecunciasEn(nena,recuerdo){
		emociones.forEach{emocion => emocion.consecunciasEn(nena,recuerdo)}
	}
	method niega(recuerdo){
		return emociones.all{emocion => emocion.niega(recuerdo)}
	}
}

const alegriaTristeza = new EmocionCompuesta(emociones = [alegria,tristeza])
const alegriaTemor = new EmocionCompuesta(emociones = [alegria,temor])
	

