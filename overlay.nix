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
}

