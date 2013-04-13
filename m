Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40432 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMTzL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:11 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm11so525735wib.1
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/33] bash-completion: add mount and umount
Date: Sat, 13 Apr 2013 20:54:29 +0100
Message-Id: <1365882901-11429-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/mount  | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++
 bash-completion/umount | 60 ++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 bash-completion/mount
 create mode 100644 bash-completion/umount

diff --git a/bash-completion/mount b/bash-completion/mount
new file mode 100644
index 0000000..2303cb7
--- /dev/null
+++ b/bash-completion/mount
@@ -0,0 +1,87 @@
+_mount_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-t'|'--types')
+			local TYPES
+			TYPES="
+adfs	  noadfs	hfsplus	  nohfsplus	smbfs	  nosmbfs
+affs	  noaffs	hpfs	  nohpfs	squashfs  nosquashfs
+autofs	  noautofs	iso9660	  noiso9660	sysv	  nosysv
+cifs	  nocifs	jfs	  nojfs		tmpfs	  notmpfs
+coda	  nocoda	minix	  nominix	ubifs	  noubifs
+coherent  nocoherent	msdos	  nomsdos	udf	  noudf
+cramfs	  nocramfs	ncpfs	  noncpfs	ufs	  noufs
+debugfs	  nodebugfs	nfs	  nonfs		umsdos	  noumsdos
+devpts	  nodevpts	nfs4	  nonfs4	usbfs	  nousbfs
+efs	  noefs		ntfs	  nontfs	vfat	  novfat
+ext	  noext		proc	  noproc	xenix	  noxenix
+ext2	  noext2	qnx4	  noqnx4	xfs	  noxfs
+ext3	  noext3	ramfs	  noramfs	xiafs	  noxiafs
+ext4	  noext4	reiserfs  noreiserfs
+hfs	  nohfs		romfs	  noromfs
+"
+			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
+			return 0
+			;;
+		'-L'|'--label')
+			local LABELS
+			LABELS="$(lsblk -o LABEL -nr)"
+			COMPREPLY=( $(compgen -W "$LABELS" -- $cur) )
+			return 0
+			;;
+		'-U'|'--uuid')
+			local UUIDS
+			UUIDS="$(lsblk -o UUID -nr)"
+			COMPREPLY=( $(compgen -W "$UUIDS" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="	--all
+				--no-canonicalize
+				--fake
+				--fork
+				--fstab
+				--help
+				--internal-only
+				--show-labels
+				--no-mtab
+				--options
+				--test-opts
+				--read-only
+				--types
+				--source
+				--target
+				--verbose
+				--version
+				--read-write
+				--label
+				--uuid
+				--bind
+				--move
+				--rbind
+				--make-shared
+				--make-slave
+				--make-private
+				--make-unbindable
+				--make-rshared
+				--make-rslave
+				--make-rprivate
+				--make-runbindable"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _mount_module mount
diff --git a/bash-completion/umount b/bash-completion/umount
new file mode 100644
index 0000000..f178bd7
--- /dev/null
+++ b/bash-completion/umount
@@ -0,0 +1,60 @@
+_umount_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-t'|'--types')
+			local TYPES
+			TYPES="
+adfs	  noadfs	hfsplus	  nohfsplus	smbfs	  nosmbfs
+affs	  noaffs	hpfs	  nohpfs	squashfs  nosquashfs
+autofs	  noautofs	iso9660	  noiso9660	sysv	  nosysv
+cifs	  nocifs	jfs	  nojfs		tmpfs	  notmpfs
+coda	  nocoda	minix	  nominix	ubifs	  noubifs
+coherent  nocoherent	msdos	  nomsdos	udf	  noudf
+cramfs	  nocramfs	ncpfs	  noncpfs	ufs	  noufs
+debugfs	  nodebugfs	nfs	  nonfs		umsdos	  noumsdos
+devpts	  nodevpts	nfs4	  nonfs4	usbfs	  nousbfs
+efs	  noefs		ntfs	  nontfs	vfat	  novfat
+ext	  noext		proc	  noproc	xenix	  noxenix
+ext2	  noext2	qnx4	  noqnx4	xfs	  noxfs
+ext3	  noext3	ramfs	  noramfs	xiafs	  noxiafs
+ext4	  noext4	reiserfs  noreiserfs
+"
+			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="	--all
+				--all-targets
+				--no-canonicalize
+				--detach-loop
+				--fake
+				--force
+				--internal-only
+				--no-mtab
+				--lazy
+				--test-opts
+				--recursive
+				--read-only
+				--types
+				--verbose
+				--help
+				--version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local DEVS_MPOINTS
+	DEVS_MPOINTS="$(mount | awk '{print $1, $3}')"
+	COMPREPLY=( $(compgen -W "$DEVS_MPOINTS" -- $cur) )
+	return 0
+}
+complete -F _umount_module umount
-- 
1.8.2.1

