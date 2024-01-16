
current_date=$(date "+%Y-%m-%d_%H-%M-%S")
# Définir le chemin du répertoire où vous souhaitez créer le nouveau dossier
destination_directory="C:\Users\Salah\Desktop\Cours\Integration continue"

# Créer le nouveau dossier dans le répertoire spécifié
mkdir -p "$destination_directory/clone$current_date"
cd "$destination_directory/clone$current_date" || { echo "Impossible d'accéder au répertoire." ; exit 1; }

# Cloner le dépôt depuis GitHub dans le répertoire nouvellement créé
git clone https://github.com/SalahOr20/NombreRomain.git .

# Mise à jour du dépôt local
git checkout dev
git pull

# Exécution des tests
python CI/Test.py



if [ $? -eq 0 ]; then
    git rebase dev master
    git push origin dev

    # Vérifier si la branche locale master est derrière la branche distante
    if git diff --quiet origin/master master; then
        # Si elles sont identiques, il n'y a pas besoin de pull
        git push origin master
    else
        # Si la branche locale est derrière, pull pour intégrer les changements distants
        git pull origin master

        # Vérifier si le pull a généré des conflits
        if [ $? -eq 0 ]; then
            # S'il n'y a pas de conflits, repousser les modifications
            git push origin master
        else
            # Sinon, indiquer la nécessité de résoudre les conflits
            echo "Des conflits sont présents. Veuillez résoudre les conflits dans la branche master avant de continuer."
            exit 1
        fi
    fi

    echo "Tests passed"

else
    # Récupère la date pour créer la branche failure
    current_date=$(date "+%F-%Hh-%Mm-%Ss")
    failure_branch="failures/$current_date"

    # Commit des modifications dans la branche actuelle (peut être optionnel selon la configuration)
    git add .
    git commit -m "Work in progress commit"

    # Crée une nouvelle branche failure à partir de la branche actuelle
    git checkout -b "$failure_branch"

    # Ajoute les fichiers qui ont échoué aux tests dans la branche failure
    # Assurez-vous d'ajouter les fichiers spécifiques à votre situation
    # Exemple : cp chemin/vers/fichier_echec.py ./$failure_branch

    # Commit des modifications dans la branche failure
    git add .
    git commit -m "Tests failed on $current_date"

    # Pousse la branche failure sur le dépôt distant
    git push origin "$failure_branch"
    echo "Test failed"
    exit 1
fi

# Attend une interaction de l'utilisateur avant de fermer le terminal
read -p "Appuyez sur Entrée pour quitter le terminal."
