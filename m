Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36326 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932074AbdBKOLB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Feb 2017 09:11:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so11041593wmd.3
        for <util-linux@vger.kernel.org>; Sat, 11 Feb 2017 06:11:00 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] bash-completion: add blkreset and blkreport completion
Date: Sat, 11 Feb 2017 14:10:52 +0000
Message-Id: <20170211141052.26154-4-kerolasa@iki.fi>
In-Reply-To: <20170211141052.26154-1-kerolasa@iki.fi>
References: <20170211141052.26154-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/blkreset | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 bash-completion/blkreset

diff --git a/bash-completion/blkreset b/bash-completion/blkreset
new file mode 100755
index 000000000..69c5f63c1
--- /dev/null
+++ b/bash-completion/blkreset
@@ -0,0 +1,34 @@
+_blkreset_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-z'|'--zone')
+			COMPREPLY=( $(compgen -W "offset" -- $cur) )
+			return 0
+			;;
+		'-c'|'--count')
+			COMPREPLY=( $(compgen -W "length" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="--zone --count --version --help"
+			if [ "$1" = 'blkreport' ]; then
+				OPTS+=' --verbose'
+			fi
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
+	return 0
+}
+complete -F _blkreset_module blkreset
+complete -F _blkreset_module blkreport
-- 
2.11.1

