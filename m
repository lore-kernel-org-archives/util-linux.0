Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35694 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbbHBUYT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Aug 2015 16:24:19 -0400
Received: by wibxm9 with SMTP id xm9so95617885wib.0
        for <util-linux@vger.kernel.org>; Sun, 02 Aug 2015 13:24:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] bash-completion: update few options changed since v2.26
Date: Sun,  2 Aug 2015 21:24:08 +0100
Message-Id: <1438547048-31949-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Attempt to find and update all changes to command line options that has
not been reflected in bash-completion files in between versions v2.26 to
v2.27-rc1.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/fdisk   |  1 +
 bash-completion/findmnt |  8 ++++++
 bash-completion/logger  | 27 +++++++++++++++++++-
 bash-completion/lslocks |  1 +
 bash-completion/sfdisk  | 66 ++++++++++++++++++++-----------------------------
 5 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/bash-completion/fdisk b/bash-completion/fdisk
index 72a2b42..0ba522e 100644
--- a/bash-completion/fdisk
+++ b/bash-completion/fdisk
@@ -36,6 +36,7 @@ _fdisk_module()
 	case $cur in
 		-*)
 			OPTS="--sector-size
+				--protect-boot
 				--compatibility
 				--color
 				--list
diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index 3ad9147..d7e06c8 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -85,6 +85,12 @@ _findmnt_module()
 			COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
 			return 0
 			;;
+		'-M'|'--mountpoint')
+			local IFS=$'\n'
+			compopt -o filenames
+			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/") )
+			return 0
+			;;
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
@@ -105,6 +111,7 @@ _findmnt_module()
 				--tab-file
 				--first-only
 				--invert
+				--json
 				--list
 				--task
 				--noheadings
@@ -118,6 +125,7 @@ _findmnt_module()
 				--submounts
 				--source
 				--target
+				--mountpoint
 				--help
 				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
diff --git a/bash-completion/logger b/bash-completion/logger
index dcbfa9b..7f7f086 100644
--- a/bash-completion/logger
+++ b/bash-completion/logger
@@ -31,13 +31,38 @@ _logger_module()
 			COMPREPLY=( $(compgen -W "$(awk '$NF ~ /^\// {print $NF}' /proc/net/unix)" -- $cur) )
 			return 0
 			;;
+		'--msgid')
+			COMPREPLY=( $(compgen -W "msgid" -- $cur) )
+			return 0
+			;;
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
 	esac
 	case $cur in
 		-*)
-			OPTS="--journald --udp --id --file --help --server --skip-empty --port --priority --rfc3164 --rfc5424 --stderr --tag --size --socket --version"
+			OPTS="
+				--file
+				--help
+				--id
+				--journald
+				--msgid
+				--no-act
+				--octet-count
+				--port
+				--prio-prefix
+				--priority
+				--rfc3164
+				--rfc5424
+				--server
+				--size
+				--skip-empty
+				--socket
+				--stderr
+				--tag
+				--udp
+				--version
+			"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/lslocks b/bash-completion/lslocks
index 6ad6c05..0fd0acd 100644
--- a/bash-completion/lslocks
+++ b/bash-completion/lslocks
@@ -34,6 +34,7 @@ _lslocks_module()
 	case $cur in
 		-*)
 			OPTS="--pid
+				--json
 				--output
 				--noheadings
 				--raw
diff --git a/bash-completion/sfdisk b/bash-completion/sfdisk
index 9128313..f8ae1f1 100644
--- a/bash-completion/sfdisk
+++ b/bash-completion/sfdisk
@@ -5,14 +5,14 @@ _sfdisk_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'-u'|'--unit')
-			COMPREPLY=( $(compgen -W "S C B M" -- $cur) )
-			return 0
-			;;
 		'-n'|'-C'|'--cylinders'|'-H'|'--heads'|'-S'|'--sectors')
 			COMPREPLY=( $(compgen -W "number" -- $cur) )
 			return 0
 			;;
+		'--color')
+			COMPREPLY=( $(compgen -W "auto never always" -- $cur) )
+			return 0
+			;;
 		'-O'|'-I')
 			local IFS=$'\n'
 			compopt -o filenames
@@ -28,48 +28,36 @@ _sfdisk_module()
 			cur=${cur#=}
 			;;
 		-*)
-			OPTS="--show-size
-				--id
-				--change-id
-				--print-id
+			OPTS="
+				--activate
+				--dump
+				--json
+				--show-geometry
 				--list
 				--list-free
-				--dump
-				--increment
-				--unit
-				--one-only
+				--show-size
 				--list-types
-				--DOS
-				--DOS-extended
-				--re-read
-				-N
-				-n
-				-O
-				-I
 				--verify
-				--version
-				--help
+				--part-label
+				--part-type
+				--part-uuid
+				--part-attrs
+				--append
+				--backup
+				--bytes
 				--force
+				--color
+				--partno
+				--no-act
 				--no-reread
+				--backup-file
+				--output
 				--quiet
-				--Linux
-				--show-geometry
-				--show-pt-geometry
-				--activate=
-				--unhide=
-				--show-extended
-				--leave-last
-				--IBM
-				--in-order
-				--not-in-order
-				--inside-outer
-				--not-inside-outer
-				--nested
-				--chained
-				--onesector
-				--cylinders
-				--heads
-				--sectors"
+				--label
+				--label-nested
+				--help
+				--version
+			"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
-- 
2.5.0

