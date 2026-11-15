# CH14 - Installing and Updating Software Packages

## Objective

Practice RPM package inspection, YUM repository management, package searching,
and identifying packages that provide specific files or directories on RHEL 9.

## Environment

- OS: Red Hat Enterprise Linux 9
- User: kero-user
- Architecture: x86_64
- Local repositories: BaseOS and AppStream

## 1. Examine an Installed RPM Package

Checked information about the installed Git package:

```bash
rpm -qi git
```

Verified:

- Package: git
- Version: 2.52.0
- Release: 1.el9
- Architecture: x86_64

## 2. Check YUM Repositories

```bash
sudo yum repolist
```

Available local repositories:

- BaseOS - RHEL 9 BaseOS
- AppStream - RHEL 9 AppStream

The system is not registered with Red Hat Subscription Management.
Local repositories from the RHEL installation media are used instead.

## 3. Local Repository Configuration

```bash
sudo cat /etc/yum.repos.d/local-rhel.repo
```

The configuration contains two enabled repositories:

- BaseOS
- AppStream

Both repositories use the mounted RHEL 9 installation media.

## 4. Examine a Package with YUM

```bash
sudo yum info httpd
```

Verified:

- Package: httpd
- Version: 2.4.62
- Release: 13.el9
- Architecture: x86_64
- Repository: AppStream

## 5. Search for Packages

```bash
sudo yum search git
```

The search returned Git and related packages including:

- git
- git-all
- git-core
- git-core-doc
- git-lfs

## 6. Find Which Package Provides a Path

```bash
sudo yum provides /var/www/html
```

Result:

```text
httpd-filesystem-2.4.62-13.el9.noarch
```

The `httpd-filesystem` package provides `/var/www/html`.

## Key Commands Reviewed

```bash
rpm -qa
rpm -qi PACKAGE
sudo rpm -ivh PACKAGE.rpm

yum search PACKAGE
yum info PACKAGE
sudo yum install PACKAGE
sudo yum remove PACKAGE
sudo yum update
yum provides /path/to/file
sudo yum repolist
```

## Key Concepts

- RPM is the software package format used by RHEL.
- `rpm` can query and manage RPM packages directly.
- YUM uses repositories to find and manage packages.
- YUM handles package dependencies automatically.
- BaseOS and AppStream are available as local repositories.
- `yum provides` identifies which package provides a file or path.

## Lab Status

CH14 package management concepts reviewed and practical repository/package
inspection completed successfully.
