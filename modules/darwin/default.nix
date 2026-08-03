# modules/darwin/default.nix
{...}:
{
	nixpkgs.config.allowunfree = true;
	nixpkgs.config.allowUnsupported = true;

	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		auto-optimise-store = true;
		warn-dirty = false;
		sandbox = true;
	}
}