Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33701 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3C0WIM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:12 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so969650wgh.13
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/10] bash-completion: fdisks
Date: Wed, 27 Mar 2013 22:07:45 +0000
Message-Id: <1364422072-23552-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 shell-completion/cfdisk | 31 +++++++++++++++++++++
 shell-completion/fdisk  | 41 ++++++++++++++++++++++++++++
 shell-completion/sfdisk | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 shell-completion/cfdisk
 create mode 100644 shell-completion/fdisk
 create mode 100644 shell-completion/sfdisk

diff --git a/shell-completion/cfdisk b/shell-completion/cfdisk
new file mode 100644
index 0000000..8da32fd
--- /dev/null
+++ b/shell-completion/cfdisk
@@ -0,0 +1,31 @@
+_cfdisk_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-c')
+			COMPREPLY=( $(compgen -W "cylinders" -- $cur) )
+			return 0
+			;;
+		'-h')
+			COMPREPLY=( $(compgen -W "heads" -- $cur) )
+			return 0
+			;;
+		'-s')
+			COMPREPLY=( $(compgen -W "sectors" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a -z -c -h -s"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')" -- $cur) )
+	return 0
+}
+complete -F _cfdisk_module cfdisk
diff --git a/shell-completion/fdisk b/shell-completion/fdisk
new file mode 100644
index 0000000..ccf2015
--- /dev/null
+++ b/shell-completion/fdisk
@@ -0,0 +1,41 @@
+_fdisk_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-s')
+			local PARTITIONS
+			PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/'; DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"
+			COMPREPLY=( $(compgen -W "$PARTITIONS" -- $cur) )
+			return 0
+			;;
+		'-b')
+			COMPREPLY=( $(compgen -W "512 1024 2048 4096" -- $cur) )
+			return 0
+			;;
+		'-c')
+			COMPREPLY=( $(compgen -W "dos nondos" -- $cur) )
+			return 0
+			;;
+		'-u')
+			COMPREPLY=( $(compgen -W "cylinders sectors" -- $cur) )
+			return 0
+			;;
+		'-C'|'-H'|'-S')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-l -s -b -c -h -u -v -C -H -S"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')" -- $cur) )
+	return 0
+}
+complete -F _fdisk_module fdisk
diff --git a/shell-completion/sfdisk b/shell-completion/sfdisk
new file mode 100644
index 0000000..041ce55
--- /dev/null
+++ b/shell-completion/sfdisk
@@ -0,0 +1,72 @@
+_sfdisk_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-u'|'--unit')
+			COMPREPLY=( $(compgen -W "S C B M" -- $cur) )
+			return 0
+			;;
+		'-n'|'-C'|'--cylinders'|'-H'|'--heads'|'-S'|'--sectors')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+		'-O'|'-I')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-s --show-size
+				-c --id
+				--change-id
+				--print-id
+				-l --list
+				-d --dump
+				-i --increment
+				-u --unit
+				-1 --one-only
+				-T --list-types
+				-D --DOS
+				-E --DOS-extended
+				-R --re-read
+				-N
+				-n
+				-O
+				-I
+				-V --verify
+				-v --version
+				-h --help
+				-f --force
+				--no-reread
+				-q --quiet
+				-L --Linux
+				-g --show-geometry
+				-G --show-pt-geometry
+				-A --activate
+				-U --unhide
+				-x --show-extended
+				--leave-last
+				--IBM
+				--in-order
+				--not-in-order
+				--inside-outer
+				--not-inside-outer
+				--nested
+				--chained
+				--onesector
+				-C --cylinders
+				-H --heads
+				-S --sectors"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')" -- $cur) )
+	return 0
+}
+complete -F _sfdisk_module sfdisk
-- 
1.8.2

