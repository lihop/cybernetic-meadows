#! /usr/bin/env nix-shell
#! nix-shell -i sh -p inkscape
#
# Render SVGs to PNGs using Inkscape.

for image in ./*.svg; do
	filename=$(basename ${image%.svg})
	inkscape \
		--export-area-page \
		--export-png=${filename}.png ${filename}.svg
done


