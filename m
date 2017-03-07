Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbdCGC7Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Mar 2017 21:59:25 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 4/4] bash-completion: add a function for fincore command
Date: Tue,  7 Mar 2017 11:33:52 +0900
Message-Id: <20170307023352.7340-5-yamato@redhat.com>
In-Reply-To: <20170307023352.7340-1-yamato@redhat.com>
References: <20170307023352.7340-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/fincore       | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 bash-completion/fincore

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 3ffd124..ff7b052 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -18,6 +18,9 @@ endif
 if BUILD_COLUMN
 dist_bashcompletion_DATA += bash-completion/column
 endif
+if BUILD_FINCORE
+dist_bashcompletion_DATA += bash-completion/fincore
+endif
 if BUILD_FINDMNT
 dist_bashcompletion_DATA += bash-completion/findmnt
 endif
diff --git a/bash-completion/fincore b/bash-completion/fincore
new file mode 100644
index 0000000..d213586
--- /dev/null
+++ b/bash-completion/fincore
@@ -0,0 +1,25 @@
+_fincore_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+	    -*)
+			OPTS="--help
+				--version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local IFS=$'\n'
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- ${cur:-"/"}) )
+	return 0
+}
+complete -F _fincore_module fincore
-- 
2.9.3

