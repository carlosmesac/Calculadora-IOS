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
    var numeroIntroducido:Int = 0
    var resultado:Double!
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
        resultado = nil
        if(resultado == nil){
            textoEnPantalla.text = "0"
        }
    }
    
    @IBAction func cancelarEntrada() {
    
        var texto = textoEnPantalla.text
        guard let nuevoValor = texto?.dropLast() else {return}
        textoEnPantalla.text = String(nuevoValor)
        guard let numero = textoEnPantalla.text?.count else {return} //Count cuenta desde 0
        if(numero == 0){
            textoEnPantalla.text = "0"
            numeroIntroducido = 0
        }else{
            numeroIntroducido = Int(textoEnPantalla.text ?? "0")!
        }
        
    }

    @IBAction func presionaBotonNumero(_ sender: UIButton) {
        
        
        
        guard let tecla = sender.currentTitle else { return }
        if(numeroIntroducido==0){
            textoEnPantalla.text = tecla
            numeroIntroducido = Int(tecla)!
        } else {
            
            numeroIntroducido = numeroIntroducido * 10 + Int(tecla)!
            textoEnPantalla.text = String(numeroIntroducido)
        }
        

        
    }
    
    @IBAction func presionaBotonOperacion(_ sender: UIButton) {
        if(resultado == nil){
            resultado = Double(numeroIntroducido)
            numeroIntroducido = 0
            operador = sender.titleLabel?.text

            return
        }
        
        
        operador = sender.titleLabel?.text

        realizarOperacion()

        numeroIntroducido = 0
        
    }
    
    func realizarOperacion(){
        switch operador {
        case "+" : resultado = modelo.sumar(resultado, numero2: Double(numeroIntroducido))
        textoEnPantalla.text = String(resultado)
            break
        case "-" : resultado = modelo.restar(resultado, numero2: Double(numeroIntroducido))
        textoEnPantalla.text = String(resultado)

            break
        case "*" :resultado = modelo.multiplicar(resultado, numero2: Double(numeroIntroducido))
        textoEnPantalla.text = String(resultado)

            break
        case "/" : if(numeroIntroducido == 0){
            resultado = 0.0
            operador = ""
            error = 1
            return
        }else{
            resultado = modelo.dividir(resultado, numero2: Double(numeroIntroducido))
            textoEnPantalla.text = String(resultado)

            error = 0
            }
        case "=" :
            //let temp = Int(self.resultado)
            //let decimales: Double = self.resultado - Double(temp)
            
            //if(decimales != 0.0){
              //  textoEnPantalla.text = String(format:"%.3f", resultado)
            
           // }else{
             //   textoEnPantalla.text = String(format:"%.0f", resultado)
           // }
            
            textoEnPantalla.text = String(resultado)
        default:
            error = 2
            return
        }
    }
}

