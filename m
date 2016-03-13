Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33593 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcCMKcH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:32:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id n186so10019496wmn.0
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:32:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/10] bash-completion: lsns: add missing completion file
Date: Sun, 13 Mar 2016 10:31:48 +0000
Message-Id: <1457865109-2881-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/lsns          | 56 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 bash-completion/lsns

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 9479087..56fdd32 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -51,6 +51,9 @@ endif
 if BUILD_LSIPC
 dist_bashcompletion_DATA += bash-completion/lsipc
 endif
+if BUILD_LSNS
+dist_bashcompletion_DATA += bash-completion/lsns
+endif
 if BUILD_MCOOKIE
 dist_bashcompletion_DATA += bash-completion/mcookie
 endif
diff --git a/bash-completion/lsns b/bash-completion/lsns
new file mode 100644
index 0000000..8e6a335
--- /dev/null
+++ b/bash-completion/lsns
@@ -0,0 +1,56 @@
+_lsns_module()
+{
+	local cur prev OPTS LSNS_COLS_ALL
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	LSNS_COLS_ALL="
+		NS TYPE PATH NPROCS PID PPID COMMAND UID USER
+	"
+	case $prev in
+		'-o'|'--output')
+			local prefix realcur LSNS_COLS
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			for WORD in $LSNS_COLS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					LSNS_COLS="$WORD $LSNS_COLS"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$LSNS_COLS" -S ',' -- $realcur) )
+			return 0
+			;;
+		'-p'|'--task')
+			COMPREPLY=( $(compgen -W "$(cd /proc && echo [0-9]*)" -- $cur) )
+			return 0
+			;;
+		'-t'|'--type')
+			COMPREPLY=( $(compgen -W "mnt net ipc user pid uts" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			COMPREPLY=( $(compgen -W "
+					--json
+					--list
+					--noheadings
+					--output
+					--task
+					--raw
+					--notruncate
+					--type
+					--help
+					--version
+				" -- $cur) )
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "mnt net pid uts ipc user" -- $cur ) )
+	return 0
+}
+complete -F _lsns_module lsns
-- 
2.7.2

