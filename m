Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:49319 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMTzV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:21 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so3621113wgh.27
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/33] bash-completion: prefer bash 3.x 'here string' syntax
Date: Sat, 13 Apr 2013 20:54:33 +0100
Message-Id: <1365882901-11429-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The '< <' syntax is bash 2.x trick, and <<< does the same job when bash
3.x is in use.  For some unknown reason my bash 4.2.45(2)-release became
allergic to old syntax today(?).

Reference: http://linuxshellaccount.blogspot.co.uk/2008/08/using-bash-to-feed-command-output-to.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/addpart    | 2 +-
 bash-completion/blkdiscard | 2 +-
 bash-completion/blkid      | 2 +-
 bash-completion/blockdev   | 2 +-
 bash-completion/delpart    | 2 +-
 bash-completion/fdisk      | 4 ++--
 bash-completion/findmnt    | 2 +-
 bash-completion/fsck       | 2 +-
 bash-completion/fsck.minix | 2 +-
 bash-completion/lsblk      | 2 +-
 bash-completion/mkfs       | 2 +-
 bash-completion/mkfs.bfs   | 2 +-
 bash-completion/mkfs.minix | 2 +-
 bash-completion/partx      | 2 +-
 bash-completion/resizepart | 2 +-
 bash-completion/sfdisk     | 2 +-
 bash-completion/wipefs     | 2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/bash-completion/addpart b/bash-completion/addpart
index 2b1e6bb..3b4e603 100644
--- a/bash-completion/addpart
+++ b/bash-completion/addpart
@@ -6,7 +6,7 @@ _addpart_module()
 	case $COMP_CWORD in
 		1)
 			local DEVS=''
-			while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+			while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 			OPTS="--help --version $DEVS"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
diff --git a/bash-completion/blkdiscard b/bash-completion/blkdiscard
index 310cdfb..9e2e262 100644
--- a/bash-completion/blkdiscard
+++ b/bash-completion/blkdiscard
@@ -21,7 +21,7 @@ _blkdiscard_module()
 			;;
 	esac
 	local DEVS
-	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	DEVS=''; while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/blkid b/bash-completion/blkid
index b439328..de8b8ce 100644
--- a/bash-completion/blkid
+++ b/bash-completion/blkid
@@ -60,7 +60,7 @@ _blkid_module()
 	local DEV TYPE DEVICES=''
 	while read DEV TYPE; do
 		[ $TYPE = 'part' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
+	done <<<"$(lsblk -pnro name,type)"
 	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/blockdev b/bash-completion/blockdev
index ce986cb..4c86cda 100644
--- a/bash-completion/blockdev
+++ b/bash-completion/blockdev
@@ -4,7 +4,7 @@ _blockdev_module()
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	OPTS="-h -V -q
 		--report
 		--getsz
diff --git a/bash-completion/delpart b/bash-completion/delpart
index a4b20c8..6fa7006 100644
--- a/bash-completion/delpart
+++ b/bash-completion/delpart
@@ -14,7 +14,7 @@ _delpart_module()
 			local DEV TYPE DEVICES=''
 			while read DEV TYPE; do
 				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-			done < <(lsblk -pnro name,type)
+			done <<<"$(lsblk -pnro name,type)"
 			OPTS="--help --version $DEVICES"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
diff --git a/bash-completion/fdisk b/bash-completion/fdisk
index b800f8d..4a59070 100644
--- a/bash-completion/fdisk
+++ b/bash-completion/fdisk
@@ -9,7 +9,7 @@ _fdisk_module()
 			local DEV TYPE DEVICES=''
 			while read DEV TYPE; do
 				[ $TYPE = 'part' ] && DEVICES+="$DEV "
-			done < <(lsblk -pnro name,type)
+			done <<<"$(lsblk -pnro name,type)"
 			COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 			return 0
 			;;
@@ -43,7 +43,7 @@ _fdisk_module()
 	local DEV TYPE DEVICES=''
 	while read DEV TYPE; do
 		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
+	done <<<"$(lsblk -pnro name,type)"
 	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index 9386d8f..4cb0be8 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -37,7 +37,7 @@ _findmnt_module()
 				for I in ${TMP_ARR[@]}; do
 					MNT_OPTS[$I]='1'
 				done
-			done < <(findmnt -rno OPTIONS)
+			done <<<"$(findmnt -rno OPTIONS)"
 			COMPREPLY=( $(compgen -W "${!MNT_OPTS[@]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/fsck b/bash-completion/fsck
index 04899a0..448b6b7 100644
--- a/bash-completion/fsck
+++ b/bash-completion/fsck
@@ -32,7 +32,7 @@ _fsck_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/fsck.minix b/bash-completion/fsck.minix
index 1ec9a78..b9ff739 100644
--- a/bash-completion/fsck.minix
+++ b/bash-completion/fsck.minix
@@ -9,7 +9,7 @@ _fsck.minix_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	OPTS="-l -a -r -v -s -m -f --version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]} $DEVS" -- $cur) )
 	return 0
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 07e9368..2beb8a5 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -61,7 +61,7 @@ _lsblk_module()
 			;;
 	esac
 	local DEVS
-	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	DEVS=''; while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/mkfs b/bash-completion/mkfs
index 4e6e175..daa9ea5 100644
--- a/bash-completion/mkfs
+++ b/bash-completion/mkfs
@@ -21,7 +21,7 @@ _mkfs_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/mkfs.bfs b/bash-completion/mkfs.bfs
index 8adbc60..4f56403 100644
--- a/bash-completion/mkfs.bfs
+++ b/bash-completion/mkfs.bfs
@@ -24,7 +24,7 @@ _bfs_module()
 			return 0
 			;;
 	esac
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/mkfs.minix b/bash-completion/mkfs.minix
index 78c986f..e7b60a3 100644
--- a/bash-completion/mkfs.minix
+++ b/bash-completion/mkfs.minix
@@ -29,7 +29,7 @@ _mkfs.minix_module()
 			;;
 	esac
 	local DEVS
-	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/partx b/bash-completion/partx
index 7b08fa8..9b382fd 100644
--- a/bash-completion/partx
+++ b/bash-completion/partx
@@ -34,7 +34,7 @@ _partx_module()
 	local DEV TYPE DEVICES=''
 	while read DEV TYPE; do
 		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
+	done <<<"$(lsblk -pnro name,type)"
 	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/resizepart b/bash-completion/resizepart
index c78af15..08a95f0 100644
--- a/bash-completion/resizepart
+++ b/bash-completion/resizepart
@@ -14,7 +14,7 @@ _resizepart_module()
 			local DEV TYPE DEVICES=''
 			while read DEV TYPE; do
 				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-			done < <(lsblk -pnro name,type)
+			done <<<"$(lsblk -pnro name,type)"
 			OPTS="--help --version $DEVICES"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
diff --git a/bash-completion/sfdisk b/bash-completion/sfdisk
index 0226b04..d39e2ba 100644
--- a/bash-completion/sfdisk
+++ b/bash-completion/sfdisk
@@ -75,7 +75,7 @@ _sfdisk_module()
 	local DEV TYPE DEVICES=''
 	while read DEV TYPE; do
 		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
+	done <<<"$(lsblk -pnro name,type)"
 	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/wipefs b/bash-completion/wipefs
index e0e3286..f0a3ba6 100644
--- a/bash-completion/wipefs
+++ b/bash-completion/wipefs
@@ -27,7 +27,7 @@ _wipefs_module()
 			;;
 	esac
 	local DEVS
-	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
+	DEVS=''; while read dev; do DEVS+="$dev " ; done <<<"$(lsblk -pnro name)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
-- 
1.8.2.1

