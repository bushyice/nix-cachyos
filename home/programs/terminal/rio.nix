{ config, pkgs, lib, ... }:
{
  programs.rio = {
    enable = true;
  
    settings = {
      editor.program = "hx";
    
      # Visual Adjustments
      window = {
        opacity = 0.95;
        blur = true;
        width = 800;
        height = 600;
      };
    
      # Typography
      fonts = {
        size = 14;
      };
    };
  };
}
