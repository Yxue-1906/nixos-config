{ pkg, config, lib, hostname, secrets, ...}: {

  networking.hostName = hostname; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.firewall = {
    trustedInterfaces = [ "singbox_tun" ];
    checkReversePath = "loose";
  };

  services.sing-box = {
    enable = true;
    settings = let 
                 template = builtins.fromJSON (builtins.readFile ./singbox-settings-template.json);
                 outbounds = secrets.sing-box.outbounds;
		 tags = map (outbound: outbound.tag) outbounds;
               in
	         lib.attrsets.updateManyAttrsByPath [
		   {
		     path = [ "outbounds" ];
		     update = old: old ++ [
		       {
                         type = "selector";
			 tag = "proxy";
			 outbounds = tags ++ [ "direct" ];
			 interrupt_exist_connections = true;
		       }
		       {
		         type = "urltest";
			 tag = "auto";
			 outbounds = tags;
		       }
		     ] ++ outbounds;
		   }
		   {
		     path = [ "experimental" "clash_api" ];
		     update = old: old // { secret = secrets.sing-box.clash_api.secret; };
		   }
		 ] template;
  };
} 
