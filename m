Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33969 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdGOVU7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jul 2017 17:20:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so16599994wmg.1
        for <util-linux@vger.kernel.org>; Sat, 15 Jul 2017 14:20:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/5] bash-completion: make completions to work when bash set -u is in use
Date: Sat, 15 Jul 2017 22:20:46 +0100
Message-Id: <20170715212046.1655-6-kerolasa@iki.fi>
In-Reply-To: <20170715212046.1655-1-kerolasa@iki.fi>
References: <20170715212046.1655-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

User who want to avoid refering to none-existing variables got earlier the
following error.

$ set -u
$ findmnt --output <tab>bash: OUTPUT: unbound variable

Here is short explanation of this setting.

$ help set
 -u  Treat unset variables as an error when substituting.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/blkid   | 2 +-
 bash-completion/fdisk   | 2 +-
 bash-completion/fincore | 2 +-
 bash-completion/findmnt | 2 +-
 bash-completion/losetup | 2 +-
 bash-completion/lsipc   | 2 +-
 bash-completion/lslocks | 2 +-
 bash-completion/lsmem   | 2 +-
 bash-completion/partx   | 2 +-
 bash-completion/prlimit | 2 +-
 bash-completion/sfdisk  | 2 +-
 bash-completion/swapon  | 2 +-
 bash-completion/wdctl   | 2 +-
 bash-completion/zramctl | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/bash-completion/blkid b/bash-completion/blkid
index eb2ecf3fe..57b34c3f4 100644
--- a/bash-completion/blkid
+++ b/bash-completion/blkid
@@ -59,7 +59,7 @@ _blkid_module()
 		prefix="${cur%$realcur}"
 		for WORD in $OUTPUT_ALL; do
 			if ! [[ $prefix == *"$WORD"* ]]; then
-				OUTPUT="$WORD $OUTPUT"
+				OUTPUT="$WORD ${OUTPUT:-""}"
 			fi
 		done
 		compopt -o nospace
diff --git a/bash-completion/fdisk b/bash-completion/fdisk
index ef6c5beb4..855de1468 100644
--- a/bash-completion/fdisk
+++ b/bash-completion/fdisk
@@ -49,7 +49,7 @@ _fdisk_module()
 			"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/fincore b/bash-completion/fincore
index 4988f198b..3639763b5 100644
--- a/bash-completion/fincore
+++ b/bash-completion/fincore
@@ -12,7 +12,7 @@ _fincore_module()
 			OUTPUT_ALL='PAGES SIZE FILE RES'
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index 5583fbf6c..bdfa5de5c 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -55,7 +55,7 @@ _findmnt_module()
 
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/losetup b/bash-completion/losetup
index 7fee1d0ae..b58d8de94 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -33,7 +33,7 @@ _losetup_module()
 				SIZELIMIT DIO"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/lsipc b/bash-completion/lsipc
index ffe44b7d1..a40fe4286 100644
--- a/bash-completion/lsipc
+++ b/bash-completion/lsipc
@@ -35,7 +35,7 @@ _lsipc_module()
 			"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/lslocks b/bash-completion/lslocks
index 4ca1e6b6e..acc7b1ff6 100644
--- a/bash-completion/lslocks
+++ b/bash-completion/lslocks
@@ -20,7 +20,7 @@ _lslocks_module()
 			OUTPUT_ALL="COMMAND PID TYPE SIZE MODE M START END PATH BLOCKER"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/lsmem b/bash-completion/lsmem
index 85cf3e01a..8f7a46ec3 100644
--- a/bash-completion/lsmem
+++ b/bash-completion/lsmem
@@ -12,7 +12,7 @@ _lsmem_module()
 			OUTPUT_ALL='RANGE SIZE STATE REMOVABLE BLOCK NODE'
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/partx b/bash-completion/partx
index 929000013..2368336ed 100644
--- a/bash-completion/partx
+++ b/bash-completion/partx
@@ -15,7 +15,7 @@ _partx_module()
 			prefix="${cur%$realcur}"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/prlimit b/bash-completion/prlimit
index fff7a85c5..f5e00bb16 100644
--- a/bash-completion/prlimit
+++ b/bash-completion/prlimit
@@ -17,7 +17,7 @@ _prlimit_module()
 			OUTPUT_ALL="DESCRIPTION RESOURCE SOFT HARD UNITS"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/sfdisk b/bash-completion/sfdisk
index c00e8c799..9401f89ac 100644
--- a/bash-completion/sfdisk
+++ b/bash-completion/sfdisk
@@ -28,7 +28,7 @@ _sfdisk_module()
 			"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/swapon b/bash-completion/swapon
index fc80af5eb..4a53ec5ac 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -18,7 +18,7 @@ _swapon_module()
 			OUTPUT_ALL="NAME TYPE SIZE USED PRIO UUID LABEL"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/wdctl b/bash-completion/wdctl
index 811b5e3cc..f1a870ef6 100644
--- a/bash-completion/wdctl
+++ b/bash-completion/wdctl
@@ -29,7 +29,7 @@ _wdctl_module()
 			OUTPUT_ALL="FLAG DESCRIPTION STATUS BOOT-STATUS DEVICE"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/zramctl b/bash-completion/zramctl
index 8c7767ce0..672d8102a 100644
--- a/bash-completion/zramctl
+++ b/bash-completion/zramctl
@@ -18,7 +18,7 @@ _zramctl_module()
 				MIGRATED MOUNTPOINT"
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OUTPUT="$WORD $OUTPUT"
+					OUTPUT="$WORD ${OUTPUT:-""}"
 				fi
 			done
 			compopt -o nospace
-- 
2.13.3

