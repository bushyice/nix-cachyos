{ config, pkgs, lib, ... } : {

  programs.zellij = {
    enable = true;
    package = pkgs.stdenv.mkDerivation {
    	pname = "dummy";
      version = "0";
      src = null;
      dontUnpack = true;
      dontBuild = true;
      installPhase = ''
      mkdir -p $out
      '';
    };


    layouts = {
  dev = {
    layout = {
      _children = [
        {
          default_tab_template = {
            _children = [
              {
                pane = {
                  size = 1;
                  borderless = true;
                  plugin = {
                    location = "zellij:tab-bar";
                  };
                };
              }
              { children = {}; }
              {
                pane = {
                  size = 2;
                  borderless = true;
                  plugin = {
                    location = "zellij:status-bar";
                  };
                };
              }
            ];
          };
        }

        {
          tab = {
            _props = {
              name = "Dev";
              focus = true;
            };

            _children = [
              {
                pane = {
                  split_direction = "vertical";

                  _children = [
                    {
                      pane = {
                        size = "30%";
                        split_direction = "horizontal";

                        _children = [
                          {
                            pane = {
                              size = "70%";
                              command = "yazi";
                              args = [ "." ];
                            };
                          }
                          {
                            pane = {};
                          }
                        ];
                      };
                    }
                    {
                      pane = {
                        command = "helix";
                        args = [ "." ];
                      };
                    }
                  ];
                };
              }
            ];
          };
        }
      ];
    };
  };
};
    };
  
}
