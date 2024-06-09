class VagonesDePasajeros{
	var property largo
	var property ancho
	var property tieneBanio
	var property estaOrdenado 
	
	
	method cantidadDePasajeros(){
		const multiplicacion = if (ancho <= 3){8} else {10}
		var cantidad = largo * multiplicacion
		
		if(estaOrdenado){
		  cantidad -= 15
		}
		return cantidad
	}
	
	method maximoDeCarga(){
		return
		if (tieneBanio){
			300
		}
		else 800
	}
	
	
	method pesoMaximo(){
		return 2000 + 80 * self.cantidadDePasajeros() + 
		self.maximoDeCarga()
	}
	
	method hacerMantenimiento(){
		return 
		if(estaOrdenado){
			estaOrdenado
		}
		else estaOrdenado = false
	}
}

class VagonesDeCarga{
	var property cargaIdeal
	var property maderasSueltas
	
	
	method maximoDeCarga(){
		return 0.max(cargaIdeal - (400 * maderasSueltas))
	}
	
	method cantidadDePasajeros(){
		return 0
	}
	
	method pesoMaximo(){
		return 1500 + self.maximoDeCarga()
	}
	
	method tieneBanio(){
		return false
	}
	
	method hacerMantenimiento(){
		return 0.max(maderasSueltas - 2)
	}
}

class VagonesDeDormitorio{
	var property compartimiento
	var property camas
	
	
	method cantidadDePasajeros(){
		return compartimiento * camas
	}
	
	method tieneBanio(){
		return true
	}
	
	method maximoDeCarga(){
		return 1200
	}
	
	method pesoMaximo(){
		return 4000 + self.cantidadDePasajeros() +
		self.maximoDeCarga()
	}
	
	method hacerMantenimiento(){
	
	}
}

class Formacion{
	const vagones = []
	const locomotoras = []
	
	method agregarVagon(vagon){
		return vagones.add(vagon)
	}
	
	method quitarVagon(vagon){
		return vagones.remove(vagon)
	}
	
	method cantidadDePasajeros(){
		return vagones.sum({v => v.cantidadDePasajeros()})
	}
	
	method cantidadDeVagonesPopulares(){
		return vagones.filter({v => v.cantidadDePasajeros() > 50}).size()
	}
	
	method esFormacionCarguera(){
		return vagones.all({ v => v.maximoDeCarga() >= 1000})
	}
	
	method vagonMasLiviano(){
		return vagones.min({ v => v.pesoMaximo()})
	}
	
	method vagonMasPesado(){
		return vagones.max({ v => v.pesoMaximo()})
	}
	
	method dispersionDePesos(){
		return self.vagonMasPesado().pesoMaximo() - self.vagonMasLiviano().pesoMaximo()
	}
	
	method cuantosBaniosTieneLaFormacion(){
		return vagones.filter({ v => v.tieneBanio()}).size()
	}
	
	method vagonQueMasLleva(){
		return vagones.max({v => v.cantidadDePasajeros()})
	}
	
	method vagonQueMenosLleva(){
		return vagones.min({v => v.cantidadDePasajeros()})
	}
	
	
	method estaEquilibradaEnPasajeros(){
		return self.vagonQueMasLleva().cantidadDePasajeros() - 
		self.vagonQueMenosLleva().cantidadDePasajeros() < 20
	}
	
	method hacerMantenimiento(){
		return vagones.forEach({ v => v.hacerMantenimiento()})
	}
	
	//falta el ultimo metodo de si esta organizado
	
	method velocidadMaximaDeFormacion(){
		return locomotoras.max({ locomotora => locomotora.velocidadMaxima()})
	}
	
	method todasSonEficientes(){
		return locomotoras.all({locomotora => locomotora.esEficiente()})
	}
	
	method puedeMoverse(){
		return self.arrastreDeLocomotoras() >= self.pesoMaximoDeFormacion()
	}
	
	method arrastreDeLocomotoras(){
		return locomotoras.sum({ locomotora => locomotora.cuantoPuedeArrastrar()})
	}
	
	method pesoMaximoDeFormacion(){
		return locomotoras.sum({ locomotora => locomotora.peso()}) +
		vagones.sum({vagon => vagon.pesoMaximo()})
	}
	
	method kilosDeEmpuje(){
		return 
		if (self.puedeMoverse()){
			0
		}
		else self.pesoMaximoDeFormacion() - self.arrastreDeLocomotoras()
	}
	
}

class Locomotoras{
	var property peso = 10
	var property cuantoPuedeArrastrar
	var property velocidadMaxima = 40
	
	method esEficiente(){
		return cuantoPuedeArrastrar >= peso * 5
	}
	
	
}



























