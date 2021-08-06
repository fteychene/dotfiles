

echo 
echo "Startree specific install"
yay -S debtap
yay -S bitdefender


echo
echo "Terraform multi version"
brew install terraform@0.13
sudo ln -s /home/linuxbrew/.linuxbrew/Cellar/terraform@0.13/0.13.7/bin/terraform /usr/local/bin/terraform-v0.13.7
sudo ln -s /home/linuxbrew/.linuxbrew/Cellar/terraform/1.0.4/bin/terraform /usr/local/bin/terraform-v1.0.4

echo
echo "Install drata agent & packaged backup"