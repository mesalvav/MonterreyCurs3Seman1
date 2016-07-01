//
//  ViewController.swift
//  Request
//
//  Created by Mario E Salvatierra V on 6/28/16.
//  Copyright © 2016 Dunas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //var texto: NSString!
    
    
    @IBOutlet weak var ISBNtextField: UITextField!
    
    @IBOutlet weak var resultadoTextView: UITextView!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
       
        resultadoTextView.text = "buscando ..."
        
        
        if let output =  sincrono(ISBNtextField.text!) {
            
            resultadoTextView.text = output as String
            
            self.ISBNtextField.endEditing(true)
        }
      
        
        //print("entrada de datum \(texto) ")
        
        
        return true
    }
    

    
    func sincrono(ISBN: String) -> NSString? {
       // let urlstr = "http://dia.ccm.itesm.mx"
        let urlstr = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + ISBN
        let url = NSURL(string: urlstr)
        let texto: NSString = "internet error"
        
        if let datos: NSData = NSData(contentsOfURL: url!) {
       
        
            if let texto = NSString(data: datos, encoding: NSUTF8StringEncoding) {
            return texto
            }
        }
        
        let alert = UIAlertController(title: "OJO", message: "Parece que no hay conexion al Internet", preferredStyle: .Alert)
       // print(texto!)
        let accion = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(accion)
        
        self.presentViewController(alert, animated: true, completion: nil)
            return texto
    }
    
    func asincrono(ISBN: String) {
        //let urlstr = "http://dia.ccm.itesm.mx"
        
        let urlstr = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + ISBN
        let url = NSURL(string: urlstr)
        let sesion = NSURLSession.sharedSession()
        let bloque =
            {
                (datos: NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
                var texto: NSString = ""
                if error == nil {
                        texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)!
                        print(texto)
                        //print(resp)
                    
                   // self.resultadoTextView.text = String(self.texto!)
                    
                } else {
                    texto = NSString(UTF8String: "Incapaz de bajar datum. Error!")!
                    print(error)
                }
            }
        
        let dt = sesion.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()
        print("antes o despues")
        
        //to text view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.ISBNtextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

