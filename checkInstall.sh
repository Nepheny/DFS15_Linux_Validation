#/bin/bash

# ----------------- #
# --- VARIABLES --- #
# ----------------- #

BLUE="\033[34;1m"
RED="\033[31;1m"
GREEN="\033[32;1m"
CLOSE="\033[0m"
CHOICE="Non"


# ----------------- #
# --- FUNCTIONS --- #
# ----------------- #

askInstall() {
    echo -e "$BLUE Voulez-vous installer le programme ?$CLOSE"
    select ANSWER in "Oui" "NON"; do
        case $ANSWER in
            "Oui")
                # sudo apt install $PROGRAMM;
                break;;
            "Non") leave; break;;
            *) echo -e "$RED Erreur, réponse invalide. $CLOSE"; askInstall; break;;
        esac
    done
    sleep 1
}

checkVirtualBox() {
    echo
    echo -e "$BLUE Vérification de l'installation de VirtualBox :$CLOSE"
    if [ ! "$(command -v virtualbox)" ];
    then
        echo -e "$RED VirtualBox n'est pas installé sur cette machine.$CLOSE"
        PROGRAMM="virtualbox"
        askInstall;
    fi
    sleep 1
}

checkVagrant() {
    echo
    echo -e "$BLUE Vérification de l'installation de VirtualBox :$CLOSE"
    if [ ! "$(command -v vagrant)" ];
    then
        echo -e "$RED Vagrant n'est pas installé sur cette machine.$CLOSE"
        PROGRAMM="vagrant"
        askInstall;
    fi
    sleep 1
}

confirmChoices() {
    echo
    echo -e "$BLUE Voulez-vous poursuivre la création de votre machine virtuelle ?$CLOSE"
 
    select CHOICE in "Oui" "Non"; do
        case $CHOICE in
            "Oui") break;;
            "Non") leave; break;;
            *) echo -e "$RED Erreur, réponse invalide. $CLOSE"; confirmChoices; break;;
        esac
    done
    sleep 1
}

leave() {
    echo
    echo -e "$BLUE Voulez-vous quitter le script ? $CLOSE"

    select LEAVE in "Oui" "Non"; do
        case $LEAVE in
            "Oui") echo -e "$GREEN Annulation... $CLOSE"; exit; break;;
            "Non") break;;
            *) echo -e "$RED Erreur, réponse invalide. $CLOSE"; leave; break;;
        esac
    done

    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1
}

# -------------- #
# --- SCRIPT --- #
# -------------- #

clear

echo
echo -e "$BLUE ****************************************** $CLOSE"
echo -e "$BLUE Bienvenue sur le script permettant la création de votre machine virtuelle avec vagrant. $CLOSE"
echo -e "$BLUE En seulement quelques étapes, vous obtiendrez une machine virtuelle fonctionnelle. $CLOSE"
echo -e "$BLUE Veuillez suivre les indications : $CLOSE"
echo -e "$BLUE ------------------------------------------ $CLOSE"

while [ $CHOICE != "Oui" ];
do
    checkVirtualBox;
    echo -e "$GREEN VirtualBox est installé $CLOSE"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1

    checkVagrant;
    echo -e "$GREEN Vagrant est installé. $CLOSE"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1    

    confirmChoices;
    echo -e "$GREEN Confirmation effectuée.$CLOSE"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1
done

echo -e "$GREEN Maintenant vous allez être dirigé sur la configuration de votre machine virtuelle. $CLOSE"
echo -e "$BLUE ****************************************** $CLOSE"
bash configVagrant.sh;