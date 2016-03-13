Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33589 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413AbcCMKcG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:32:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id n186so10019466wmn.0
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:32:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/10] bash-completion: lslogins: add missing completion file
Date: Sun, 13 Mar 2016 10:31:47 +0000
Message-Id: <1457865109-2881-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 ++
 bash-completion/lslogins      | 76 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100755 bash-completion/lslogins

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index e4196a3..9479087 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -150,6 +150,9 @@ endif
 if BUILD_LAST
 dist_bashcompletion_DATA += bash-completion/last
 endif
+if BUILD_LSLOGINS
+dist_bashcompletion_DATA += bash-completion/lslogins
+endif
 if BUILD_NEWGRP
 dist_bashcompletion_DATA += bash-completion/newgrp
 endif
diff --git a/bash-completion/lslogins b/bash-completion/lslogins
new file mode 100755
index 0000000..967b644
--- /dev/null
+++ b/bash-completion/lslogins
@@ -0,0 +1,76 @@
+_lslogins_module()
+{
+	local cur prev OPTS LSLOGINS_COLS_ALL
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	LSLOGINS_COLS_ALL="
+		USER UID GECOS HOMEDIR SHELL NOLOGIN PWD-LOCK PWD-EMPTY
+		PWD-DENY GROUP GID SUPP-GROUPS SUPP-GIDS LAST-LOGIN LAST-TTY
+		LAST-HOSTNAME FAILED-LOGIN FAILED-TTY HUSHED PWD-WARN
+		PWD-CHANGE PWD-MIN PWD-MAX PWD-EXPIR CONTEXT PROC
+	"
+	case $prev in
+		'-g'|'--groups')
+			COMPREPLY=( $(compgen -W "$(getent group | awk -F: '{print $1}')" -- $cur) )
+			return 0
+			;;
+		'-l'|'--logins')
+			COMPREPLY=( $(compgen -W "$(getent passwd | awk -F: '{print $1}')" -- $cur) )
+			return 0
+			;;
+		'--time-format')
+			COMPREPLY=( $(compgen -W "short full iso" -- $cur) )
+			return 0
+			;;
+		'--wtmp-file'|'--btmp-file')
+			local IFS=$'\n'
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'-o'|'--output')
+			local prefix realcur LSLOGINS_COLS
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			for WORD in $LSLOGINS_COLS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					LSLOGINS_COLS="$WORD $LSLOGINS_COLS"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$LSLOGINS_COLS" -S ',' -- $realcur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "
+			--acc-expiration
+			--colon-separate
+			--export
+			--failed
+			--supp-groups
+			--groups
+			--last
+			--logins
+			--newline
+			--noheadings
+			--notruncate
+			--output
+			--pwd
+			--raw
+			--system-accs
+			--time-format
+			--user-accs
+			--context
+			--print0
+			--wtmp-file
+			--btmp-file
+			--help
+			--version
+		" -- $cur) )
+	return 0
+}
+complete -F _lslogins_module lslogins
-- 
2.7.2

