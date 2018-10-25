# DFS15_Linux_Validation

## Installation des programmes
- Vérification de l'installation de ***VirtualBox*** et de ***Vagrant***.
- Installation des logiciels possibles *(ligne mise en commentaire pour des soucis de connexion)*.

## Configuration de Vagrantfile
- Choix du nom de dossier local pour la synchronisaiton de fichiers entre la machine locale et la machine virtuelle.
    - Gestion des dossiers existants dans le répertoire courant.
- Choix du chemin de dossier virtuel pour la synchronisation de fichiers entre la machine local et la machine virtuelle.
    - Gestion de l'erreur si le chemin indiqué n'est pas absolu.

## Intéractions avec les VM
- Affichage des machines virtuelles en fonction uniquement.

## Gestion des erreurs
- Gestion des choix erronés.
- Possibilité de quitter le script sur plusieurs étapes selon les choix de l'utilisateur.
- Séparation des phases de script en plusieurs fichiers.
- Coloration en rapport avec les choix, erreurs, succès et indications.

## Utilisation
Pour lancer le script, il suffit de taper la commande :
```bash
bash checkInstall.sh
```

:octocat:
