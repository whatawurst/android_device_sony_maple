Device configuration for Sony Xperia XZ Premium (maple)
========================================================

Description
-----------

This repository is for LineageOS 20.0 on Sony Xperia XZ Premium (maple).

How to build LineageOS
----------------------

* Make a workspace:

        mkdir -p ~/lineageos
        cd ~/lineageos

* Initialize the repo:

        repo init -u git://github.com/LineageOS/android.git -b lineage-20.0

* Create a local manifest:

        vim .repo/local_manifests/roomservice.xml

        <?xml version="1.0" encoding="UTF-8"?>
        <manifest>
            <!-- SONY -->
            <project name="whatawurst/android_kernel_sony_msm8998" path="kernel/sony/msm8998" remote="github" revision="lineage-20" />
            <project name="whatawurst/android_device_sony_yoshino-common" path="device/sony/yoshino-common" remote="github" revision="lineage-20" />
            <project name="whatawurst/android_device_sony_maple" path="device/sony/maple" remote="github" revision="lineage-20" />

            <!-- blobs for maple -->
            <project name="whatawurst/android_vendor_sony_yoshino-common" path="vendor/sony/yoshino-common" remote="github" revision="lineage-20" />
            <project name="whatawurst/android_vendor_sony_maple" path="vendor/sony/maple" remote="github" revision="lineage-20" />
        </manifest>

* Sync the repo:

        repo sync

* Setup the environment

        source build/envsetup.sh
        lunch lineage_maple-userdebug

* Build LineageOS

        make -j8 bacon
