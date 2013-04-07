Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:58381 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929Ab3DGIMM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Apr 2013 04:12:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri6.pp.htv.fi (Postfix) with ESMTP id 61B4456F03F
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
	with ESMTP id Fk3Iq5HAQcUZ for <util-linux@vger.kernel.org>;
	Sun,  7 Apr 2013 11:12:08 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id DF1C65BC015
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:08 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] bash-completion: Avoid some unnecessary subshells.
Date: Sun,  7 Apr 2013 11:12:05 +0300
Message-Id: <1365322328-1607-2-git-send-email-ville.skytta@iki.fi>
In-Reply-To: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
References: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 bash-completion/findmnt |  2 +-
 bash-completion/flock   |  2 +-
 bash-completion/ionice  |  4 ++--
 bash-completion/logger  |  2 +-
 bash-completion/renice  |  2 +-
 bash-completion/setterm | 10 +++++-----
 bash-completion/swapon  |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index cdc4861..a6d526f 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -38,7 +38,7 @@ _findmnt_module()
 					MNT_OPTS[$I]='1'
 				done
 			done < <(findmnt -rno OPTIONS)
-			COMPREPLY=( $(compgen -W "$(echo ${!MNT_OPTS[@]})" -- $cur) )
+			COMPREPLY=( $(compgen -W "${!MNT_OPTS[@]}" -- $cur) )
 			return 0
 			;;
 		'-o'|'--output')
diff --git a/bash-completion/flock b/bash-completion/flock
index 3f094e3..918a7d8 100644
--- a/bash-completion/flock
+++ b/bash-completion/flock
@@ -10,7 +10,7 @@ _flock_module()
 			return 0
 			;;
 		'-E'|'--conflict-exit-code')
-			COMPREPLY=( $(compgen -W "$(echo {0..255})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{0..255}" -- $cur) )
 			return 0
 			;;
 		'-c'|'--command')
diff --git a/bash-completion/ionice b/bash-completion/ionice
index e7a8ac8..4d55968 100644
--- a/bash-completion/ionice
+++ b/bash-completion/ionice
@@ -6,11 +6,11 @@ _ionice_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-c'|'--class')
-			COMPREPLY=( $(compgen -W "$(echo {0..3}) none realtime best-effort idle" -- $cur) )
+			COMPREPLY=( $(compgen -W "{0..3} none realtime best-effort idle" -- $cur) )
 			return 0
 			;;
 		'-n'|'--classdata')
-			COMPREPLY=( $(compgen -W "$(echo {0..7})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{0..7}" -- $cur) )
 			return 0
 			;;
 		'-p'|'--pid')
diff --git a/bash-completion/logger b/bash-completion/logger
index 1f89e2d..7a2b460 100644
--- a/bash-completion/logger
+++ b/bash-completion/logger
@@ -19,7 +19,7 @@ _logger_module()
 			return 0
 			;;
 		'-p'|'--priority')
-			COMPREPLY=( $(compgen -W "$(echo {auth,authpriv,cron,daemon,ftp,lpr,mail,news,security}.{alert,crit,debug,emerg,err,error})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{auth,authpriv,cron,daemon,ftp,lpr,mail,news,security}.{alert,crit,debug,emerg,err,error}" -- $cur) )
 			return 0
 			;;
 		'-t'|'--tag')
diff --git a/bash-completion/renice b/bash-completion/renice
index deb9793..9693590 100644
--- a/bash-completion/renice
+++ b/bash-completion/renice
@@ -12,7 +12,7 @@ _renice_module()
 			return 0
 			;;
 		'-n'|'--priority')
-			COMPREPLY=( $(compgen -W "$(echo {-20..20})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{-20..20}" -- $cur) )
 			return 0
 			;;
 		'-p'|'--pid')
diff --git a/bash-completion/setterm b/bash-completion/setterm
index ae07d1e..7fa0a4e 100644
--- a/bash-completion/setterm
+++ b/bash-completion/setterm
@@ -31,17 +31,17 @@ _setterm_module()
 			return 0
 			;;
 		'-regtabs')
-			COMPREPLY=( $(compgen -W "$(echo {1..160})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{1..160}" -- $cur) )
 			return 0
 			;;
 		'-blank')
-			COMPREPLY=( $(compgen -W "$(echo {0..60}) force poke" -- $cur) )
+			COMPREPLY=( $(compgen -W "{0..60} force poke" -- $cur) )
 			return 0
 			;;
 		'-dump'|'-append')
 			local NUM_CONS
 			NUM_CONS=(/sys/class/tty/*)
-			COMPREPLY=( $(compgen -W "$(echo {1..${#NUM_CONS[*]}})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{1..${#NUM_CONS[*]}}" -- $cur) )
 			return 0
 			;;
 		'-file')
@@ -50,7 +50,7 @@ _setterm_module()
 			return 0
 			;;
 		'-msglevel')
-			COMPREPLY=( $(compgen -W "$(echo {1..8})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{1..8}" -- $cur) )
 			return 0
 			;;
 		'-powersave')
@@ -58,7 +58,7 @@ _setterm_module()
 			return 0
 			;;
 		'-powerdown')
-			COMPREPLY=( $(compgen -W "$(echo {0..60})" -- $cur) )
+			COMPREPLY=( $(compgen -W "{0..60}" -- $cur) )
 			return 0
 			;;
 		'-blength')
diff --git a/bash-completion/swapon b/bash-completion/swapon
index 0e7c200..6e05b6e 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -8,7 +8,7 @@ _swapon_module()
 		'-p'|'--priority')
 			# Priority range is -1 to 32767.  Perhaps these
 			# few are enough.
-			COMPREPLY=( $(compgen -W "$(echo {-1..9} 32767)" -- $cur) )
+			COMPREPLY=( $(compgen -W "{-1..9} 32767" -- $cur) )
 			return 0
 			;;
 		'--show')
-- 
1.7.11.7

