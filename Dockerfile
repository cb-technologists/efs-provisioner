FROM quay.io/external_storage/efs-provisioner:latest

RUN addgroup -g 2000 efs-provisioner && adduser -D -S -g "efs-provisioner" -h "/" -s "/bin/ash" -u 2000 -G efs-provisioner efs-provisioner

RUN mkdir /persistentvolumes && chown -R efs-provisioner:efs-provisioner /persistentvolumes

RUN mv /efs-provisioner /usr/bin/

USER efs-provisioner
ENTRYPOINT ["/usr/bin/efs-provisioner"]
