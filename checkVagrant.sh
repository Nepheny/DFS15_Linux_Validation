#/bin/bash

# ----------------- #
# --- VARIABLES --- #
# ----------------- #

BLUE="\033[34;1m"
RED="\033[31;1m"
GREEN="\033[32;1m"
CLOSE="\033[0m"


# ----------------- #
# --- FUNCTIONS --- #
# ----------------- #

displayVMs() {
    echo
    echo -e "$BLUE Liste des machines virtuelles en fonction : $CLOSE"
    vagrant global-status | grep "running"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1
    chooseAction;
}

chooseAction() {
    echo
    echo -e "$BLUE Veuillez sélectionner une action à effectuer : $CLOSE"

    select CHOICE in "Quitter le script" "Intéragir avec une VM"; do
        case $CHOICE in
            "Quitter le script") leave; break;;
            "Intéragir avec une VM") chooseVM; break;;
            *) echo -e "$RED Erreur, réponse invalide. $CLOSE"; chooseAction; break;;
        esac
    done
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1
}

chooseVM() {
    echo
    echo -e "$BLUE Veuillez indiquer l'ID d'une VM à éteindre : $CLOSE"
    read VMID

    if [ ! "$(vagrant global-status | grep "running" | awk '{print $1;}')" == "$VMID" ];
    then
        echo -e "$RED Erreur : l'ID renseigné ne correspond à aucune VM en fonction.$CLOSE"
        chooseAction;
    else
        vagrant halt $VMID
        echo -e "$GREEN VM $VMID éteinte. $CLOSE"
        echo -e "$BLUE ------------------------------------------ $CLOSE"
        sleep 1
        chooseAction;
    fi

    sleep 1
}

leave() {
    echo
    echo -e "$BLUE Voulez-vous quitter le script ? $CLOSE"

    select LEAVE in "Oui" "Non"; do
        case $LEAVE in
            "Oui") echo -e "$GREEN Fin du script. $CLOSE"; exit; break;;
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
echo -e "$BLUE Une liste des machines virtuelles en fonction va être affichée. $CLOSE"
echo -e "$BLUE ------------------------------------------ $CLOSE"
echo

sleep 1
displayVMs;