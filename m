Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:49671 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbaJZWHZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Oct 2014 18:07:25 -0400
Received: by mail-wi0-f173.google.com with SMTP id ex7so4896424wid.6
        for <util-linux@vger.kernel.org>; Sun, 26 Oct 2014 15:07:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] bash-completion: stop being clever when listing block devices
Date: Sun, 26 Oct 2014 22:07:08 +0000
Message-Id: <1414361229-23921-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
References: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Various commands such as blkid, cfdisk, fdisk, delpart, and so on listed
only partitions and missed for example disks and volume groups.  The
right thing to do is to list all block devices in all for all commands
performing operations with them.  This might occasionally list unexpected
devices that I think is lesser bad than missing some.

Addresses: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=764488
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/addpart    |  4 +---
 bash-completion/blkdiscard |  4 +---
 bash-completion/blkid      |  6 +-----
 bash-completion/blockdev   |  2 +-
 bash-completion/cfdisk     |  6 +-----
 bash-completion/delpart    |  6 +-----
 bash-completion/fdisk      | 12 ++----------
 bash-completion/fsck       |  3 +--
 bash-completion/fsck.minix |  3 +--
 bash-completion/lsblk      |  3 +--
 bash-completion/mkfs       |  3 +--
 bash-completion/mkfs.bfs   |  3 +--
 bash-completion/mkfs.minix |  3 +--
 bash-completion/partx      |  6 +-----
 bash-completion/resizepart |  6 +-----
 bash-completion/sfdisk     |  6 +-----
 bash-completion/wipefs     |  4 +---
 17 files changed, 18 insertions(+), 62 deletions(-)

diff --git a/bash-completion/addpart b/bash-completion/addpart
index 2b1e6bb..e9ed793 100644
--- a/bash-completion/addpart
+++ b/bash-completion/addpart
@@ -5,9 +5,7 @@ _addpart_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	case $COMP_CWORD in
 		1)
-			local DEVS=''
-			while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-			OPTS="--help --version $DEVS"
+			OPTS="--help --version $(lsblk -pnro name)"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
diff --git a/bash-completion/blkdiscard b/bash-completion/blkdiscard
index 310cdfb..aa2f6f6 100644
--- a/bash-completion/blkdiscard
+++ b/bash-completion/blkdiscard
@@ -20,9 +20,7 @@ _blkdiscard_module()
 			return 0
 			;;
 	esac
-	local DEVS
-	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _blkdiscard_module blkdiscard
diff --git a/bash-completion/blkid b/bash-completion/blkid
index 9f97dd9..26e414a 100644
--- a/bash-completion/blkid
+++ b/bash-completion/blkid
@@ -58,11 +58,7 @@ _blkid_module()
 			return 0
 			;;
 	esac
-	local DEV TYPE DEVICES=''
-	while read DEV TYPE; do
-		[ $TYPE = 'part' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
-	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _blkid_module blkid
diff --git a/bash-completion/blockdev b/bash-completion/blockdev
index ce986cb..8050c0f 100644
--- a/bash-completion/blockdev
+++ b/bash-completion/blockdev
@@ -4,7 +4,7 @@ _blockdev_module()
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	DEVS="$(lsblk -pnro name)"
 	OPTS="-h -V -q
 		--report
 		--getsz
diff --git a/bash-completion/cfdisk b/bash-completion/cfdisk
index 025b044..8921fa3 100644
--- a/bash-completion/cfdisk
+++ b/bash-completion/cfdisk
@@ -23,11 +23,7 @@ _cfdisk_module()
 			return 0
 			;;
 	esac
-	local DEV TYPE DEVICES=''
-	while read DEV TYPE; do
-		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro "name,type")
-	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _cfdisk_module cfdisk
diff --git a/bash-completion/delpart b/bash-completion/delpart
index a4b20c8..d5a92ef 100644
--- a/bash-completion/delpart
+++ b/bash-completion/delpart
@@ -11,11 +11,7 @@ _delpart_module()
 	esac
 	case $COMP_CWORD in
 		1)
-			local DEV TYPE DEVICES=''
-			while read DEV TYPE; do
-				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-			done < <(lsblk -pnro name,type)
-			OPTS="--help --version $DEVICES"
+			OPTS="--help --version $(lsblk -pnro name)"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
diff --git a/bash-completion/fdisk b/bash-completion/fdisk
index 28cdda6..72a2b42 100644
--- a/bash-completion/fdisk
+++ b/bash-completion/fdisk
@@ -6,11 +6,7 @@ _fdisk_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-s'|'--getsz')
-			local DEV TYPE DEVICES=''
-			while read DEV TYPE; do
-				[ $TYPE = 'part' ] && DEVICES+="$DEV "
-			done < <(lsblk -pnro name,type)
-			COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 			return 0
 			;;
 		'-b'|'--sector-size')
@@ -55,11 +51,7 @@ _fdisk_module()
 			return 0
 			;;
 	esac
-	local DEV TYPE DEVICES=''
-	while read DEV TYPE; do
-		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
-	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _fdisk_module fdisk
diff --git a/bash-completion/fsck b/bash-completion/fsck
index 04899a0..d61b37f 100644
--- a/bash-completion/fsck
+++ b/bash-completion/fsck
@@ -32,8 +32,7 @@ _fsck_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _fsck_module fsck
diff --git a/bash-completion/fsck.minix b/bash-completion/fsck.minix
index 1ec9a78..4ed5110 100644
--- a/bash-completion/fsck.minix
+++ b/bash-completion/fsck.minix
@@ -9,9 +9,8 @@ _fsck.minix_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	OPTS="-l -a -r -v -s -m -f --version"
-	COMPREPLY=( $(compgen -W "${OPTS[*]} $DEVS" -- $cur) )
+	COMPREPLY=( $(compgen -W "${OPTS[*]} $(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _fsck.minix_module fsck.minix
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index c270255..b5dcb40 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -70,8 +70,7 @@ _lsblk_module()
 			;;
 	esac
 	local DEVS
-	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _lsblk_module lsblk
diff --git a/bash-completion/mkfs b/bash-completion/mkfs
index 4e6e175..4edc6f0 100644
--- a/bash-completion/mkfs
+++ b/bash-completion/mkfs
@@ -21,8 +21,7 @@ _mkfs_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name) /path/to/file" -- $cur) )
 	return 0
 }
 complete -F _mkfs_module mkfs
diff --git a/bash-completion/mkfs.bfs b/bash-completion/mkfs.bfs
index 4f2923d..1bd67a0 100644
--- a/bash-completion/mkfs.bfs
+++ b/bash-completion/mkfs.bfs
@@ -24,8 +24,7 @@ _mkfs.bfs_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name) /path/to/file" -- $cur) )
 	return 0
 }
 complete -F _mkfs.bfs_module mkfs.bfs
diff --git a/bash-completion/mkfs.minix b/bash-completion/mkfs.minix
index 78c986f..c84a237 100644
--- a/bash-completion/mkfs.minix
+++ b/bash-completion/mkfs.minix
@@ -29,8 +29,7 @@ _mkfs.minix_module()
 			;;
 	esac
 	local DEVS
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _mkfs.minix_module mkfs.minix
diff --git a/bash-completion/partx b/bash-completion/partx
index 7b08fa8..5d662fc 100644
--- a/bash-completion/partx
+++ b/bash-completion/partx
@@ -31,11 +31,7 @@ _partx_module()
 			return 0
 			;;
 	esac
-	local DEV TYPE DEVICES=''
-	while read DEV TYPE; do
-		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
-	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _partx_module partx
diff --git a/bash-completion/resizepart b/bash-completion/resizepart
index c78af15..7e38503 100644
--- a/bash-completion/resizepart
+++ b/bash-completion/resizepart
@@ -11,11 +11,7 @@ _resizepart_module()
 	esac
 	case $COMP_CWORD in
 		1)
-			local DEV TYPE DEVICES=''
-			while read DEV TYPE; do
-				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-			done < <(lsblk -pnro name,type)
-			OPTS="--help --version $DEVICES"
+			OPTS="--help --version $(lsblk -pnro name)"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
diff --git a/bash-completion/sfdisk b/bash-completion/sfdisk
index 609104c..16ada3f 100644
--- a/bash-completion/sfdisk
+++ b/bash-completion/sfdisk
@@ -73,11 +73,7 @@ _sfdisk_module()
 			return 0
 			;;
 	esac
-	local DEV TYPE DEVICES=''
-	while read DEV TYPE; do
-		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
-	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _sfdisk_module sfdisk
diff --git a/bash-completion/wipefs b/bash-completion/wipefs
index e0e3286..d735b5a 100644
--- a/bash-completion/wipefs
+++ b/bash-completion/wipefs
@@ -26,9 +26,7 @@ _wipefs_module()
 			return 0
 			;;
 	esac
-	local DEVS
-	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _wipefs_module wipefs
-- 
2.1.2

