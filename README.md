# Create a new app:

    oc new-app . --name psi

# Password for admin

By default, password is not set. To set password use:

    oc env dc/psi --overwrite PSITRANSFER_ADMIN_PASS=secret

# Changes, deploy on OpenShift:

    oc start-build psi --from-dir .

