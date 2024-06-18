//
//  ContentView.swift
//  ProjetMorpion
//
//  Created by goldorak on 13/09/2023.
//

import SwiftUI

struct ContentView: View {
    //Declarartion variables
    @State private var joueur = "X"
    @State private var tableau = Array(repeating: "", count: 9)
    @State var gagnant = false
    @State var nul = false
    
    var body: some View {
        
        //Affiche le jeu
        VStack {
            Text("Morpion")
                .font(.system(size: 50))
                .padding(.bottom, 20)
                .fontWeight(.bold)
            Text("C'est au tour de : \(joueur)")
                .font(.title)
            
            //Affiche le tableau de jeu
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        
                        //Bouton qui sert à jouer
                        Button(action: {
                            if tableau[row * 3 + column] == "" {
                                tableau[row * 3 + column] = joueur
                                gagnant = Victoire()
                                AJoué()
                            }
                        }) {
                            Carrés(caractereJ: tableau[row * 3 + column])
                        }
                        .disabled(gagnant || nul )
                    }
                }
            }
            if gagnant == true {
                Text("\(joueur) a gagné !")
                    .foregroundColor(.black)
            }
            else if nul == true {
                Text("Égalité")
            }
            
            //Bouton qui réinitialise le jeu
            Button(action: {
                Reset()
            }) {
                Text("Réinitialiser")
                    .font(.title)
                    .padding()
                    .background(.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(30)
        }
    }
    
    //Fonction qui verifie le joueur qui doit jouer
    func AJoué() {
        if gagnant {
            joueur = joueur
        }
        else {
            joueur = (joueur == "X") ? "O" : "X"
        }
    }
    
    
    //Fonction qui définie le design des carrés ainsi que le design des symboles
    func Carrés(caractereJ: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 100)
            .foregroundColor(.purple)
            .padding(5)
            .overlay(
                Text(caractereJ)
                    .foregroundColor(caractereJ == "X" ? .white : .black)
                    .fontWeight(.bold)
                    .font(.system(size:100))
            )
    }
    
    
    //Fonction qui réinitialise le jeu
    func Reset() {
        gagnant = false
        nul = false
        joueur = "X"
        tableau = Array(repeating: "", count: 9)
    }
    
    
    //Fonction qui définie les conditions de victoires
    func Victoire() -> Bool{
        let combinaisonVictoire: [[Int]] = [[0,1,2], [3,4,5], [6,7,8], [0,3,6],[1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        for combinaison in combinaisonVictoire {
            if tableau[combinaison[0]] == tableau[combinaison[1]] && tableau[combinaison[1]] == tableau[combinaison[2]] && !tableau[combinaison[0]].isEmpty {
                nul = false
                return true
            }
        }
        if !tableau.contains("") && !nul {
                nul = true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
