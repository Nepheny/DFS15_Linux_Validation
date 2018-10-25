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

selectLocalSyncedFolder() {
    echo
    echo -e "$BLUE Un dossier va être créé au même endroit que ce script. Il servira au partage de fichiers avec la machine virtuelle. $CLOSE"
    echo -e "$BLUE Veuillez choisir un nom de dossier pour le dossier local : $CLOSE"
    read FOLDER
    if [ -d "$FOLDER" ];
    then
        echo -e "$RED Erreur, ce dossier existe déjà. $CLOSE"
        selectLocalSyncedFolder;
    else
        mkdir $FOLDER       
    fi
    sleep 1
}

selectVagrantSyncedFolder() {
    echo
    echo -e "$BLUE A présent, Un dossier qui sera synchronisé avec $FOLDER du côté de la machine virtuelle va être paramétré. $CLOSE"
    echo -e "$BLUE Veuillez indiquer le chemin absolu du dossier en question : $CLOSE"
    read PATHTOVIRTUALFOLDER
    if [ ${PATHTOVIRTUALFOLDER:0:1} != "/" ];
    then
        echo -e "$RED Erreur, vous n'avez pas spécifié de chemin absolu. $CLOSE"
        selectVagrantSyncedFolder;
    fi
    sleep 1
}

confirmChoices() {
    echo
    echo -e "$BLUE Veuillez confirmer vos options :$CLOSE"
    echo -e "$BLUE - dossier local  : $FOLDER $CLOSE"
    echo -e "$BLUE - dossier de la machine virtuelle : $PATHTOVIRTUALFOLDER $CLOSE"
 
    select CHOICE in "Oui" "Non"; do
        case $CHOICE in
            "Oui") break;;
            "Non") leave; break;;
            *) echo -e "$RED Erreur, réponse invalide. $CLOSE"; confirmChoices; break;;
        esac
    done
    sleep 1
}

modifyFile() {
    echo
    echo -e "$GREEN Vos options sont appliquées. $CLOSE"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sudo sed -i 's|config.vm.box = "base"|config.vm.box = "ubuntu/xenial64"|g' Vagrantfile
    sudo sed -i 's|# config.vm.network "private_network", ip: "192.168.33.10"|config.vm.network "private_network", ip: "192.168.33.10"|g' Vagrantfile
    sudo sed -i 's|# config.vm.synced_folder "../data", "/vagrant_data"|config.vm.synced_folder "./'$FOLDER'", "'$PATHTOVIRTUALFOLDER'"|g' Vagrantfile
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
echo -e "$BLUE Un fichier qui contiendra vos options concernant la machine virtuelle est initialisé. $CLOSE"
echo -e "$BLUE ------------------------------------------ $CLOSE"
echo
sleep 1
if [ Vagrantfile ];
then rm Vagrantfile
fi
vagrant init;
sleep 1

while [ $CHOICE != "Oui" ];
do
    selectLocalSyncedFolder;
    echo -e "$GREEN Le dossier a bien été créé. $CLOSE"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1

    selectVagrantSyncedFolder;
    echo -e "$GREEN Le chemin du dossier virtuel a bien été enregistré. $CLOSE"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1

    confirmChoices;
    echo -e "$GREEN Confirmation effectuée. $CLOSE"
    echo -e "$BLUE ------------------------------------------ $CLOSE"
    sleep 1
done

modifyFile;

echo -e "$GREEN Votre machine virtuelle se lance. $CLOSE"
echo -e "$BLUE ------------------------------------------ $CLOSE"
echo
sleep 1
vagrant up;

echo -e "$GREEN Maintenant vous allez être dirigé sur la liste des machines virtuelles en fonction. $CLOSE"
echo -e "$BLUE ****************************************** $CLOSE"
sleep 1
bash checkVagrant.sh;