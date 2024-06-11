# add repo, dt, vt, kt etc.
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs --depth=1
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b los-21 .repo/local_manifests
# sync script
repo sync
# /opt/crave/resync.sh
# lunch command paste here
source build/envsetup.sh
echo "Done ✅"
lunch lineage_lavender-ap1a-eng
# export extra module
make installclean
brunch lavender
Snx-R