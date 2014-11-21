node.default[:packer][:url_base] = "https://dl.bintray.com/mitchellh/packer"
node.default[:packer][:version] = "0.7.1"
node.default[:packer][:arch] = kernel['machine'] =~ /x86_64/ ? "amd64" : "386"

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/packer/${VERSION}_SHA256SUMS?direct
node.default[:packer][:raw_checksums] = <<-EOF
    1e83a630229bb15691ddb09b3428b3df3e364c2ed1c4c9d2a62bdb632afa5772  0.7.1_darwin_386.zip
    1b490d4ef86b074c658681b550e98e40fcbdd407fa8f6eb5da8191e5808b8ec3  0.7.1_darwin_amd64.zip
    b9ca7a356189c10cac1a0f30661dd37e76626944c1316328ebb1601364b22364  0.7.1_freebsd_386.zip
    1ba03334e93485f5141924383c80aa94b24a6e129bfd402a1afbfb9b2f84c186  0.7.1_freebsd_amd64.zip
    a2b869d9bdbdbdd5554a14b8ad72151b44e70aebea7f072c87bc95583bd4bac7  0.7.1_freebsd_arm.zip
    2e7d75cb0e835b49438c90133bbfacfb6caa70a4ba7830b8bac6c62404dc3e72  0.7.1_linux_386.zip
    44483a2a41e9203837afa4a3fe2e18308a545632c24ce7704b12baef84f18532  0.7.1_linux_amd64.zip
    dbdbde356aecb8ac659da1175c66b8edf44fbdc7351779bdc3166a6850a2e206  0.7.1_linux_arm.zip
    a2f2ab09c555e9c8ef1864aebb9b128367e866e45d1510a9889ca9eddc617f35  0.7.1_openbsd_386.zip
    754761c627afe61383a80d1425c752ae4a54bcb3c2234609267e2c54829e835a  0.7.1_openbsd_amd64.zip
    1996302a846ef6f049c309162cc589b9d31409bcbac116824c1858ca9e5ee3c5  0.7.1_windows_386.zip
    26b1569119b02ab908b308090f8eee20d70ab75b4a6ace2996de0356e9a79595  0.7.1_windows_amd64.zip
EOF
node.default[:packer][:checksums] = Hash[
    node[:packer][:raw_checksums].split("\n").collect { |s| s.split.reverse }
]
filename = "#{node[:packer][:version]}_#{node[:os]}_#{node[:packer][:arch]}.zip"
node.default[:packer][:checksum] = node[:packer][:checksums][filename]
