Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:50018 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756843Ab3DJJhB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 10 Apr 2013 05:37:01 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] bash-completion: add swapoff
Date: Wed, 10 Apr 2013 11:36:21 +0200
Message-Id: <1365586581-30512-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 bash-completion/swapoff | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 bash-completion/swapoff

diff --git a/bash-completion/swapoff b/bash-completion/swapoff
new file mode 100644
index 0000000..badc1de
--- /dev/null
+++ b/bash-completion/swapoff
@@ -0,0 +1,56 @@
+_swapoff_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-a'|'--all')
+			return 0
+			;;
+		'-U'|'UUID=')
+			# only works for block devices, i.e., not for swap files.
+			local SWAPS
+			SWAPS="$(swapon --show=TYPE,NAME --raw --noheading | \
+				awk '$1 !~ /file/ { print $2 }')"
+			[ -z "$SWAPS" ] && return 0
+			local UUIDS
+			UUIDS="$(lsblk -nrp -o UUID "$SWAPS")"
+			COMPREPLY=( $(compgen -W "$UUIDS" -- $cur) )
+			return 0
+			;;
+		'-L'|'LABEL=')
+			# only works for block devices, i.e., not for swap files.
+			local SWAPS
+			SWAPS="$(swapon --show=TYPE,NAME --raw --noheading | \
+				awk '$1 !~ /file/ { print $2 }')"
+			[ -z "$SWAPS" ] && return 0
+			local LABELS
+			LABELS="$(lsblk -nrp -o LABEL "$SWAPS")"
+			COMPREPLY=( $(compgen -W "$LABELS" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a
+				-L
+				-U
+				-v
+				--all
+				--verbose
+				--help
+				--version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local DEVS
+	DEVS="$(swapon --show=NAME --raw --noheading)"
+	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	return 0
+}
+complete -F _swapoff_module swapoff
-- 
1.8.1.3.619.g7b6e784

