git config --global user.name "Jose Olvera"
git config --global user.email "armando.ob@hotmail.com"

ssh-keygen -t ed25519 -C "armando.ob@hotmail.com"
# If you are using a legacy system that doesn't support the Ed25519 algorithm, use:
# ssh-keygen -t rsa -b 4096 -C "armando.ob@hotmail.com"

cat ~/.ssh/id_ed25519.pub | clip
# Copies the contents of the id_ed25519.pub file to your clipboard