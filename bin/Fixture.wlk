import Emociones.*
import Riley.*
object fixture{
	//Emociones
	const enojo = new Emocion()
	const disgusto = new Emocion()
	const temor = new Emocion()
	//EmocionesCompuestas
	//([emociones])
	const alegriaTristeza = new EmocionCompuesta([alegria,tristeza])
	const enojoDisgusto = new EmocionCompuesta([enojo,disgusto])
	const alegriaTemor = new EmocionCompuesta([alegria,temor])
	//Recuerdos
	//(_fecha,_descripcion,_emocionDominante,_asentamiento) 
	// var fecha = new Date(28,01,2001) Date[2001-01-28]
	//Diarios
	const recuerdoAlegre = new Recuerdo("Si! Tengo mi unicornio",new Date(),alegria)
	const recuerdoAlegre2 = new Recuerdo("",new Date(), alegria)
	const recuerdoTriste = new Recuerdo("",new Date(), tristeza)
	const recuerdoTriste2 = new Recuerdo("",new Date(), tristeza)
	const recuerdoEnojado = new Recuerdo("",new Date(), enojo)
	const recuerdoTemeroso = new Recuerdo("Tengo miedo mami",new Date(),temor)
	const recuerdoDisgustado = new Recuerdo("",new Date(),disgusto)
	const recuerdoAlegriaTemor = new Recuerdo ("",new Date(),alegriaTemor)
	const recuerdoAlegriaTristeza = new Recuerdo("", new Date(),alegriaTristeza)
	//Asentados
	const recuerdoAlegre3 = new Recuerdo("Me gustan mucho los unicornios de color blanco y rosa pastel",new Date(21,09,2008),alegria)
	const recuerdoTriste3  = new Recuerdo("",new Date(),tristeza)
	const recuerdoEnojado2  = new Recuerdo("¿POR QUE NO PUEDO TENER ESE PELUCHE DE UNICORNIO QUE TANTO QUIERO?",new Date(),enojo)
	const recuerdoTemeroso2  = new Recuerdo("",new Date(),temor)
	const recuerdoDisgustado2  = new Recuerdo("",new Date(30,10,2009),disgusto)
	const recuerdoAlegriaTemor2  = new Recuerdo ("",new Date(),alegriaTemor)
	const recuerdoAlegriaTristeza2 = new Recuerdo("",new Date(),alegriaTristeza)
	//Personas
	//(_felicidad,_dominante,_recuerdosDelDia,_pensamientosCentrales,_largoPlazo,_fechaNacimiento)
	const riley = new Persona(1000,alegria,[recuerdoAlegre,recuerdoTriste,recuerdoTemeroso],[recuerdoAlegre3,recuerdoTriste3],[],new Date(21,09,2005))
	const lara = new Persona(750,enojo,[],[],[],new Date(03,02,2005))
	const monica = new Persona(400,disgusto,[],[],[],new Date(07,06,2005))
	const sadAffleck = new Persona(1,tristeza,[recuerdoAlegre,recuerdoTriste,recuerdoTemeroso],[],[],new Date(04,06,2005))
	const lisa = new Persona(1000,temor,[],[],[],new Date(19,06,2005))
	const mona = new Persona (100,alegriaTristeza, [],[],[], new Date(28,01,2005))
	 const mica = new Persona(650,enojo,[],[],[recuerdoAlegre3,recuerdoDisgustado2],new Date(05,01,2005))
	//Getters
	method monica() = monica
	method riley() = riley
	method lara () = lara
	method sadAffleck () = sadAffleck
	method lisa () = lisa 
	method mona () = mona
	method mica () = mica
	method enojo () = enojo
	method disgusto () = disgusto
	method temor () = temor 
	method alegriaTristeza () = alegriaTristeza
	method enojoDisgusto () = enojoDisgusto
	method alegriaTemor () = alegriaTemor 
	method recuerdoAlegre () = recuerdoAlegre
	method recuerdoAlegre2 () = recuerdoAlegre2
	method recuerdoTriste () = recuerdoTriste
	method recuerdoTriste2 () = recuerdoTriste2
	method recuerdoEnojado () = recuerdoEnojado
	method recuerdoTemeroso () = recuerdoTemeroso 
	method recuerdoDisgustado () = recuerdoDisgustado
	method recuerdoAlegriaTemor () = recuerdoAlegriaTemor
	method recuerdoAlegriaTristeza () = recuerdoAlegriaTristeza 
	method recuerdoAlegre3 () = recuerdoAlegre3
	method recuerdoTriste3() = recuerdoTriste3
	method recuerdoEnojado2() = recuerdoEnojado2
	method recuerdoTemeroso2() = recuerdoTemeroso2
	method recuerdoDisgustado2() = recuerdoDisgustado2
	method recuerdoAlegriaTemor2() = recuerdoAlegriaTemor2
	method recuerdoAlegriaTristeza2() = recuerdoAlegriaTristeza2
}