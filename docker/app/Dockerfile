FROM oraclelinux:8

# Install Oracle Release and Instant Client repositories
RUN dnf install -y oracle-release-el8 oracle-instantclient-release-el8

# Install Development Tools and basic Oracle Instant Client components
# We omit 'precomp' as we are providing it via the copied SDK
RUN dnf groupinstall -y "Development Tools" --setopt=install_weak_deps=False && \
    dnf install -y \
    oracle-instantclient-basic \
    oracle-instantclient-devel \
    oracle-instantclient-sqlplus \
    libnsl \
    --setopt=install_weak_deps=False && \
    dnf clean all

# Create symbolic links for compatibility
RUN mkdir -p /usr/lib/oracle/current && \
    ln -s /usr/lib/oracle/21/client64 /usr/lib/oracle/current/client64

# Create Pro*C system configuration file (pcscfg.cfg)
RUN mkdir -p /usr/lib/oracle/21/client64/precomp/admin && \
    echo "sys_include=(/usr/include,/usr/include/c++/8,/usr/include/c++/8/x86_64-redhat-linux,/usr/lib/gcc/x86_64-redhat-linux/8/include,/app/oracle_sdk/include)" > /usr/lib/oracle/21/client64/precomp/admin/pcscfg.cfg

WORKDIR /app

# Set environment variables
ENV ORACLE_HOME=/usr/lib/oracle/current/client64
ENV LD_LIBRARY_PATH=/usr/lib/oracle/current/client64/lib
ENV PATH=$PATH:$ORACLE_HOME/bin:/app/oracle_sdk

CMD ["/bin/bash"]
