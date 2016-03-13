Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33892 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcCMKcE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:32:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id p65so10013873wmp.1
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:32:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/10] bash-completion: ipcmk: add missing completion file
Date: Sun, 13 Mar 2016 10:31:46 +0000
Message-Id: <1457865109-2881-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/ipcmk         | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 bash-completion/ipcmk

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 5372ed0..e4196a3 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -30,6 +30,9 @@ endif
 if BUILD_HEXDUMP
 dist_bashcompletion_DATA += bash-completion/hexdump
 endif
+if BUILD_IPCMK
+dist_bashcompletion_DATA += bash-completion/ipcmk
+endif
 if BUILD_IPCRM
 dist_bashcompletion_DATA += bash-completion/ipcrm
 endif
diff --git a/bash-completion/ipcmk b/bash-completion/ipcmk
new file mode 100644
index 0000000..696266c
--- /dev/null
+++ b/bash-completion/ipcmk
@@ -0,0 +1,27 @@
+_ipcmk_module()
+{
+	local cur prev
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-M'|'--shmem')
+			COMPREPLY=( $(compgen -W "size" -- $cur) )
+			return 0
+			;;
+		'-S'|'--semaphore')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+		'-p'|'--mode')
+			COMPREPLY=( $(compgen -W "mode" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "--shmem --semaphore --queue --mode --help --version" -- $cur) )
+	return 0
+}
+complete -F _ipcmk_module ipcmk
-- 
2.7.2

