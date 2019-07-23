#cloud-config
runcmd:
    - [ mkfs.xfs, ${git_data_disk} ]
    - [ mkdir, ${git_data_disk_mount_point} ]
mounts:
    - [ ${git_data_disk}, ${git_data_disk_mount_point}]
write_files:
    - content: |
        ####! External_Url
        external_url 'https://${domain_name}'
        ####! GitLab NGINX
        ####! Docs: https://docs.gitlab.com/omnibus/settings/nginx.html
        nginx['listen_port'] = 80
        nginx['listen_https'] = false
        nginx['proxy_set_headers'] = {"X-Forwarded-Proto" => "https","X-Forwarded-Ssl" => "on"}
        ####! Job artifacts Object Store
        ####! Docs: https://docs.gitlab.com/ee/administration/job_artifacts.html#using-object-storage
        gitlab_rails['artifacts_enabled'] = true
        gitlab_rails['artifacts_object_store_enabled'] = true
        gitlab_rails['artifacts_object_store_remote_directory'] = "${artifactory_s3_bucket_name}"
        gitlab_rails['artifacts_object_store_connection'] = {'provider' => '${s3_bucket_provider}','region' => '${s3_bucket_region}','aws_access_key_id' => '${s3_bucket_user_access_key}','aws_secret_access_key' => '${s3_bucket_user_secret_key}'}
        ####! Git LFS
        ####! https://docs.gitlab.com/ee/workflow/lfs/lfs_administration.html#s3-for-omnibus-installations
        gitlab_rails['lfs_enabled'] = true
        gitlab_rails['lfs_object_store_enabled'] = false
        gitlab_rails['lfs_object_store_remote_directory'] = "${lfs_s3_bucket_name}"
        gitlab_rails['lfs_object_store_connection'] = {'provider' => '${s3_bucket_provider}', 'region' => '${s3_bucket_region}', 'aws_access_key_id' => '${s3_bucket_user_access_key}','aws_secret_access_key' => '${s3_bucket_user_secret_key}'}
        ####! Package repository
        ####! Docs: https://docs.gitlab.com/ee/administration/maven_packages.md
        gitlab_rails['packages_enabled'] = true
        gitlab_rails['packages_object_store_enabled'] = true
        gitlab_rails['packages_object_store_remote_directory'] = "${packages_s3_bucket_name}"
        gitlab_rails['packages_object_store_direct_upload'] = false
        gitlab_rails['packages_object_store_background_upload'] = true
        gitlab_rails['packages_object_store_proxy_download'] = false
        gitlab_rails['packages_object_store_connection'] = {'provider' => '${s3_bucket_provider}', 'region' => '${s3_bucket_region}', 'aws_access_key_id' => '${s3_bucket_user_access_key}', 'aws_secret_access_key' => '${s3_bucket_user_secret_key}'}
        ####! Container Registry settings
        ####! Docs: https://docs.gitlab.com/ce/administration/container_registry.html
        registry['storage'] = {'s3' => {'accesskey' => '${s3_bucket_user_access_key}','secretkey' => '${s3_bucket_user_secret_key}','region' => '${s3_bucket_region}','bucket' => '${registry_s3_bucket_name}'}}
      path: /etc/gitlab/gitlab.rb
      permissions: '0600'
runcmd:
    - [ gitlab-ctl, reconfigure ]