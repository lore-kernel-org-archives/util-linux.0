Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33983 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaHCOSD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 10:18:03 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so3653095wib.14
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 07:18:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/7] zramctl: add bash completion script
Date: Sun,  3 Aug 2014 15:17:43 +0100
Message-Id: <1407075463-19586-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/zramctl       | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 bash-completion/zramctl

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 8d6431b..eafbedf 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -252,6 +252,9 @@ endif
 if BUILD_SETARCH
 dist_bashcompletion_DATA += bash-completion/setarch
 endif
+if BUILD_ZRAMCTL
+dist_bashcompletion_DATA += bash-completion/zramctl
+endif
 
 if BUILD_MESG
 dist_bashcompletion_DATA += bash-completion/mesg
diff --git a/bash-completion/zramctl b/bash-completion/zramctl
new file mode 100644
index 0000000..90ed608
--- /dev/null
+++ b/bash-completion/zramctl
@@ -0,0 +1,51 @@
+_zramctl_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-a'|'--algorithm')
+			COMPREPLY=( $(compgen -W "lzo lz4" -- $cur) )
+			return 0
+			;;
+		'-o'|'--output')
+			# FIXME: how to append to a string with compgen?
+			local OUTPUT
+			OUTPUT="NAME DISKSIZE DATA COMPR ALGORITHM STREAMS ZERO-PAGES TOTAL MOUNTPOINT"
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			return 0
+			;;
+		'-s'|'--size')
+			COMPREPLY=( $(compgen -W "size" -- $cur) )
+			return 0
+			;;
+		'-t'|'--streams')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="	--algorithm
+				--bytes
+				--find
+				--noheadings
+				--output
+				--raw
+				--reset
+				--size
+				--streams
+				--help
+				--version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local IFS=$'\n'
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- ${cur:-"/dev/zram"}) )
+	return 0
+}
+complete -F _zramctl_module zramctl
-- 
2.0.3

