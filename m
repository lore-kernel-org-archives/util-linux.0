Return-Path: util-linux-owner@vger.kernel.org
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:51583 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaKOUoG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 15 Nov 2014 15:44:06 -0500
Received: from localhost.localdomain (85-76-7-159-nat.elisa-mobile.fi [85.76.7.159])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id EAD199000C
	for <util-linux@vger.kernel.org>; Sat, 15 Nov 2014 22:36:09 +0200 (EET)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH] bash-completion: Invoke actual commands to be completed, not basenames
Date: Sat, 15 Nov 2014 22:36:04 +0200
Message-Id: <1416083764-15187-2-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Addresses partially: http://bugs.debian.org/769462
Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 bash-completion/chsh    | 2 +-
 bash-completion/eject   | 2 +-
 bash-completion/findmnt | 8 ++++----
 bash-completion/losetup | 4 ++--
 bash-completion/lsblk   | 2 +-
 bash-completion/setarch | 2 +-
 bash-completion/setpriv | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bash-completion/chsh b/bash-completion/chsh
index 7064194..fbf8add 100644
--- a/bash-completion/chsh
+++ b/bash-completion/chsh
@@ -6,7 +6,7 @@ _chsh_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-s'|'--shell')
-			COMPREPLY=( $(compgen -W "$(chsh -l)" -- $cur) )
+			COMPREPLY=( $(compgen -W "$($1 -l)" -- $cur) )
 			return 0
 			;;
 		'-u'|'--help'|'-v'|'--version')
diff --git a/bash-completion/eject b/bash-completion/eject
index bb7187f..123829e 100644
--- a/bash-completion/eject
+++ b/bash-completion/eject
@@ -15,7 +15,7 @@ _eject_module()
 			return 0
 			;;
 		'-x'|'--cdspeed')
-			COMPREPLY=( $(compgen -W "$(eject -X)" -- $cur) )
+			COMPREPLY=( $(compgen -W "$($1 -X)" -- $cur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index a7df4a0..cf66565 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -38,7 +38,7 @@ _findmnt_module()
 				for I in ${TMP_ARR[@]}; do
 					MNT_OPTS[$I]='1'
 				done
-			done < <(findmnt -rno OPTIONS)
+			done < <($1 -rno OPTIONS)
 			COMPREPLY=( $(compgen -W "${!MNT_OPTS[@]}" -- $cur) )
 			return 0
 			;;
@@ -67,13 +67,13 @@ _findmnt_module()
 			;;
 		'-S'|'--source')
 			local DEV_MPOINT
-			DEV_MPOINT=$(findmnt -rno SOURCE | grep ^/dev)
+			DEV_MPOINT=$($1 -rno SOURCE | grep ^/dev)
 			COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
 			return 0
 			;;
 		'-T'|'--target')
 			local DEV_MPOINT
-			DEV_MPOINT=$(findmnt -rno TARGET)
+			DEV_MPOINT=$($1 -rno TARGET)
 			COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
 			return 0
 			;;
@@ -117,7 +117,7 @@ _findmnt_module()
 			;;
 	esac
 	local DEV_MPOINT
-	DEV_MPOINT=$(findmnt -rno TARGET,SOURCE)
+	DEV_MPOINT=$($1 -rno TARGET,SOURCE)
 	COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/losetup b/bash-completion/losetup
index 874c549..d2b7418 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -6,12 +6,12 @@ _losetup_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-d'|'--detach')
-			ARG="$(losetup --output NAME | awk '{if (1 < NR) {print}}')"
+			ARG="$($1 --output NAME | awk '{if (1 < NR) {print}}')"
 			COMPREPLY=( $(compgen -W "$ARG" -- $cur) )
 			return 0
 			;;
 		'-j'|'--associated')
-			ARG="$(losetup --output BACK-FILE | awk '{if (1 < NR) {print}}')"
+			ARG="$($1 --output BACK-FILE | awk '{if (1 < NR) {print}}')"
 			COMPREPLY=( $(compgen -W "$ARG" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index b5dcb40..af8b9ad 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -70,7 +70,7 @@ _lsblk_module()
 			;;
 	esac
 	local DEVS
-	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
+	COMPREPLY=( $(compgen -W "$($1 -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _lsblk_module lsblk
diff --git a/bash-completion/setarch b/bash-completion/setarch
index b2c6a07..771de98 100644
--- a/bash-completion/setarch
+++ b/bash-completion/setarch
@@ -10,7 +10,7 @@ _setarch_module()
 			;;
 	esac
 	if [ $COMP_CWORD -eq 1 ]; then
-		COMPREPLY=( $(compgen -W "$(setarch --list)" -- $cur) )
+		COMPREPLY=( $(compgen -W "$($1 --list)" -- $cur) )
 		return 0
 	fi
 	case $cur in
diff --git a/bash-completion/setpriv b/bash-completion/setpriv
index 3be5ccd..7c21dee 100644
--- a/bash-completion/setpriv
+++ b/bash-completion/setpriv
@@ -8,7 +8,7 @@ _setpriv_module()
 		'--inh-caps'|'--bounding-set')
 			# FIXME: how to append to a string with compgen?
 			local INHERIT
-			INHERIT=$(setpriv --list-caps| awk '{print $1, "-" $1}')
+			INHERIT=$($1 --list-caps| awk '{print $1, "-" $1}')
 			compopt -o nospace
 			COMPREPLY=( $(compgen -W "all $INHERIT" -S ',' -- $cur) )
 			return 0
-- 
1.9.3

