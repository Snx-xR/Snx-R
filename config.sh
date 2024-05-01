# add repo, dt, vt, kt etc.
repo init --depth=1 -u https://github.com/ProjectMatrixx/android.git -b 14.0 --git-lfs
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b los-21 .repo/local_manifests
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
# /opt/crave/resync.sh
# lunch command paste here
source build/envsetup.sh
rm -rf packages/apps/Trebuchet
echo "Done ✅"
rm -rf packages/overlays/Lineage
lunch lineage_lavender-ap1a-eng
# export extra module
make installclean
brunch lavender
Snx-R