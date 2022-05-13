self: super: {
        fire = super.firefox.overrideAttrs (oldAttrs: {
#   buildInputs = oldAttrs.buildInputs or [] ++ [ super.makeWrapper ];
  postFixup    = ''
  echo fixing things up...................................
    wrapProgram   $out/bin/firefox  \
      --add-flags "-url https://celestialme.pythonanywhere.com"
  '';
});


     microsoft-edge = super.microsoft-edge.overrideAttrs (oldAttrs: {
  buildInputs = oldAttrs.buildInputs or [] ++ [ super.makeWrapper ];
  installPhase    = oldAttrs.installPhase or "" + ''
  echo fixing things up...................................
    wrapProgram   $out/bin/microsoft-edge  \
      --add-flags "-url https://celestialme.pythonanywhere.com" \
      --add-flags "--no-sandbox"
  '';
});

 nvidia_340_5_17 = super.linuxKernel.packages.linux_5_17.nvidia_x11_legacy340.overrideAttrs (oldAttrs: {
   patches = [ ./0001_kernel_5.7.patch ./0002_kernel_5.8.patch ./0003_kernel_5.9.patch ./0004_kernel_5.10.patch ./0005_kernel_5.11.patch ./0006_kernel_5.14.patch ./0007_kernel_5.15.patch ./0008_kernel_5.16.patch ./0009-kernel-5.17.patch];
   broken = false; 

});

patch_5_17 = super.linuxKernel.packages.linux_5_17.extend (kself: ksuper: {
  nvidia_340 = (super.dontRecurseIntoAttrs (super.lib.makeExtensible (_: ksuper.callPackage /home/nvidia-x11 { })).legacy_340);
});


}

