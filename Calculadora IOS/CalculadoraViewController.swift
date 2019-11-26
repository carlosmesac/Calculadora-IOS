//
//  ViewController.swift
//  Calculadora IOS
//
//  Created by alumno on 26/11/19.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

class CalculadoraViewController: UIViewController {

    var operador:String?
    var numeroIntroducido:Double = 0
    var resultado:Double = 0
    var numeroPantalla:String?
    var tecla:String?
    var modelo:CalculadoraModelo = CalculadoraModelo()
    var error:Int = 0
    @IBOutlet weak var textoEnPantalla: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Calculadora iOS"
        textoEnPantalla.text = String(numeroIntroducido)
        
        
    }
    @IBAction func cancelarOperacion() {
        numeroIntroducido = 0
        operador = ""
        resultado = 0.0
        textoEnPantalla.text = String(resultado)
    }
    
    @IBAction func cancelarEntrada() {
    }
    
    @IBAction func presionaBotonNumero(_ sender: UIButton) {
        guard let tecla = sender.currentTitle else { return }
        if(numeroIntroducido==0){
            textoEnPantalla.text = tecla
        } else {
            guard let anterior = textoEnPantalla.text else {return }
            textoEnPantalla.text = "\(anterior)\(tecla)"

        }
        
        
        
    }
    
    @IBAction func presionaBotonOperacion(_ sender: UIButton) {
        var operacion = sender.titleLabel?.text
        operador = operacion
        numeroIntroducido = 0
        
    }
    
    func realizarOperacion(){
        switch operador {
        case "+" : resultado = modelo.sumar(resultado, numero2: Double(numeroIntroducido))
            break
        case "-" : resultado = modelo.restar(resultado, numero2: Double(numeroIntroducido))
            break
        case "*" :resultado = modelo.multiplicar(resultado, numero2: Double(numeroIntroducido))
            break
        case "/" : if(numeroIntroducido == 0){
            resultado = 0.0
            operador = ""
            error = 1
            return
        }else{
            resultado = modelo.dividir(resultado, numero2: Double(numeroIntroducido))
            error = 0
            }
        case "=" :
            let temp = Int(self.resultado)
            let decimales: Double = self.resultado - Double(temp)
            
            if(decimales != 0.0){
                textoEnPantalla.text = String(format:"%.3f", resultado)
            
            }else{
                textoEnPantalla.text = String(format:"%.0f", resultado)
            }
        default:
            error = 2
            return
        }
    }
}

