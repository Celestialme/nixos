self: super: {
        fire = super.firefox.overrideAttrs (oldAttrs: {
   buildInputs = oldAttrs.buildInputs or [] ++ [ super.makeWrapper ];
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
      --add-flags "--in-process-gpu --enable-gpu --enable-features=VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization --ignore-gpu-blocklist  --enable-gpu-rasterization --enable-oop-rasterization   --enable-accelerated-video-decode --enable-zero-copy" \
      --add-flags "--no-sandbox"
  '';
});

patch_5_17 = super.linuxKernel.packages.linux_5_17.extend (kself: ksuper: {
  nvidia_340 = (super.dontRecurseIntoAttrs (super.lib.makeExtensible (_: ksuper.callPackage /etc/nixos/overlays/nvidia-x11 { })).legacy_340);
});



}
