import os

def fehler(th, ex):
    return ((th - ex) / th) * 100

control = "a"
while control != "q":
    os.system('cls||clear')
    theorie = float(input("Theorie Wert: "))
    experiment = float(input("Experiment Wert: "))
    result = fehler(theorie, experiment)
    print("Fehler: {:.4f}%".format(result))
    control = input("Klicken sie Q für Verlassen, Enter für Fortsetzen: ")



