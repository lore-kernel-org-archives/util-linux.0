Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33654 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdGOVU6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jul 2017 17:20:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id j85so16556719wmj.0
        for <util-linux@vger.kernel.org>; Sat, 15 Jul 2017 14:20:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/5] uuidparse: add bash-completion file
Date: Sat, 15 Jul 2017 22:20:45 +0100
Message-Id: <20170715212046.1655-5-kerolasa@iki.fi>
In-Reply-To: <20170715212046.1655-1-kerolasa@iki.fi>
References: <20170715212046.1655-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/uuidparse     | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 bash-completion/uuidparse

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index a884a138e..a4cd4fc36 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -183,6 +183,9 @@ endif
 if BUILD_LIBUUID
 dist_bashcompletion_DATA += bash-completion/uuidgen
 endif
+if BUILD_UUIDPARSE
+dist_bashcompletion_DATA += bash-completion/uuidparse
+endif
 if BUILD_UUIDD
 dist_bashcompletion_DATA += bash-completion/uuidd
 endif
diff --git a/bash-completion/uuidparse b/bash-completion/uuidparse
new file mode 100644
index 000000000..a646844f2
--- /dev/null
+++ b/bash-completion/uuidparse
@@ -0,0 +1,37 @@
+_uuidparse_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-o'|'--output')
+			local prefix realcur OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			for WORD in "UUID VARIANT TYPE TIME"; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD ${OUTPUT:-""}"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	OPTS="
+		--json
+		--noheadings
+		--output
+		--raw
+		--help
+		--version
+	"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+
+}
+complete -F _uuidparse_module uuidparse
-- 
2.13.3

