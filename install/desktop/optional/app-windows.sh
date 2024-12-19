ohai "Downloading the VirtIO drivers to $HOME/Downloads..."
mkdir -p $HOME/Downloads
wget -O $HOME/Downloads/virtio-win-0.1.262.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.262-2/virtio-win-0.1.262.iso

ohai "Download the Windows 10 ISO..."
open https://www.microsoft.com/software-download/windows10ISO
gum confirm "Have you finished downloading?"

ohai "Follow instructions in..."
open https://sysguides.com/install-a-windows-11-virtual-machine-on-kvm
