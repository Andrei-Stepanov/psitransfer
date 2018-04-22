#sed -i -e '/^[[:space:]]\+PsiTransfer$/ s/PsiTransfer/psi-prod/' \
#    /opt/app-root/src/public/html/upload.html \
#    /opt/app-root/src/public/html/download.html
sed -i -e '/svg/,/\/svg/ {/\/svg/i<img src="/assets/logo.png" height="42">' -e 'd}' \
    /opt/app-root/src/public/html/upload.html \
    /opt/app-root/src/public/html/download.html
