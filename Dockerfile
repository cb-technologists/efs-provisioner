FROM quay.io/external_storage/efs-provisioner:latest

# create efs-provisioner user & group
RUN addgroup -g 2000 efs-provisioner && adduser -D -S -g "efs-provisioner" -h "/" -s "/bin/ash" -u 2000 -G efs-provisioner efs-provisioner

# create /persistentvolumes directory and change ownership to new user/group
RUN mkdir /persistentvolumes && chown -R efs-provisioner:efs-provisioner /persistentvolumes

# move efs-provisioner to /usr/bin
RUN mv /efs-provisioner /usr/bin/

# run as efs-provisioner user
USER efs-provisioner

# use updated efs-provisioner location as entrypoint
ENTRYPOINT ["/usr/bin/efs-provisioner"]
