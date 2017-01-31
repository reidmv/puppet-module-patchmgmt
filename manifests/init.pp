class patch_management (
  $baseurl = 'http://mirror.centos.org/centos/$releasever/os/$basearch/',
  $gpgkey  = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
  $enforce = false,
) {
  
  yumrepo { 'patch_management':
    baseurl  => $update_repo,
    descr    => 'Patch Management Repo',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => $gpgkey,
  }
  
  exec { 'yum-ensure-patch_management':
    command   => "yum --disablerepo '*' --enablerepo patch_management update -y",
    unless    => "yum --disablerepo '*' --enablerepo patch_management check-update",
    logoutput => true,
    path      => '/usr/bin',
    noop      => !$enforce,
    require   => Yumrepo['patch_management'],
  }
 
}
