#!/bin/sh

## If template file doesn't work, use this

sudo mkfs -t xfs ${git_data_disk}
sudo mkdir -p ${git_data_disk_mount_point}
sudo mount ${git_data_disk} ${git_data_disk_mount_point}

sudo mkdir -p /etc/gitlab/ssl
sudo chmod -R 700 /etc/gitlab/ssl
sudo openssl req -newkey rsa:2048 -nodes -keyout /etc/gitlab/ssl/gitlabssl.key -x509 -days 3650 -out /etc/gitlab/ssl/gitlabssl.crt -subj "/CN=${domain_name}"
sudo chmod 600 /etc/gitlab/ssl/gitlabssl.*

cat > /etc/gitlab/gitlab.rb <<- EOM
####! External_Url
external_url 'https://${domain_name}'
####! GitLab NGINX
####! Docs: https://docs.gitlab.com/omnibus/settings/nginx.html
nginx['redirect_http_to_https'] = true
nginx['ssl_certificate'] = '/etc/gitlab/ssl/gitlabssl.crt'
nginx['ssl_certificate_key'] = '/etc/gitlab/ssl/gitlabssl.key'
####! Job artifacts Object Store
####! Docs: https://docs.gitlab.com/ee/administration/job_artifacts.html#using-object-storage
gitlab_rails['artifacts_enabled'] = true
gitlab_rails['artifacts_object_store_enabled'] = true
gitlab_rails['artifacts_object_store_remote_directory'] = '${artifactory_s3_bucket_name}'
gitlab_rails['artifacts_object_store_connection'] = {'provider' => '${s3_bucket_provider}','region' => '${s3_bucket_region}','aws_access_key_id' => '${s3_bucket_user_access_key}','aws_secret_access_key' => '${s3_bucket_user_secret_key}'}
####! Git LFS
####! https://docs.gitlab.com/ee/workflow/lfs/lfs_administration.html#s3-for-omnibus-installations
gitlab_rails['lfs_enabled'] = true
gitlab_rails['lfs_object_store_enabled'] = false
gitlab_rails['lfs_object_store_remote_directory'] = '${lfs_s3_bucket_name}'
gitlab_rails['lfs_object_store_connection'] = {'provider' => '${s3_bucket_provider}', 'region' => '${s3_bucket_region}', 'aws_access_key_id' => '${s3_bucket_user_access_key}','aws_secret_access_key' => '${s3_bucket_user_secret_key}'}
####! For setting up different data storing directory
####! Docs: https://docs.gitlab.com/omnibus/settings/configuration.html#storing-git-data-in-an-alternative-directory
git_data_dirs({'default' => { 'path' => '${git_data_disk_mount_point}'}})
EOM

sudo gitlab-ctl reconfigure