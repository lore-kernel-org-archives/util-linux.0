Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51865 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaJZWH1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Oct 2014 18:07:27 -0400
Received: by mail-wg0-f52.google.com with SMTP id y10so1837935wgg.11
        for <util-linux@vger.kernel.org>; Sun, 26 Oct 2014 15:07:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] bash-completion: use swapon label and uuid listing support
Date: Sun, 26 Oct 2014 22:07:09 +0000
Message-Id: <1414361229-23921-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
References: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Simplifies the script, and makes swapoff to work for files when get
requests by label or uuid.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/swapoff | 22 +++-------------------
 bash-completion/swapon  |  2 +-
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/bash-completion/swapoff b/bash-completion/swapoff
index 60d8572..40dcf05 100644
--- a/bash-completion/swapoff
+++ b/bash-completion/swapoff
@@ -9,25 +9,11 @@ _swapoff_module()
 			return 0
 			;;
 		'-U'|'UUID=')
-			# only works for block devices, i.e., not for swap files.
-			local SWAPS
-			SWAPS="$(swapon --show=TYPE,NAME --raw --noheading | \
-				awk '$1 !~ /file/ { print $2 }')"
-			[ -z "$SWAPS" ] && return 0
-			local UUIDS
-			UUIDS="$(lsblk -nrp -o UUID "$SWAPS")"
-			COMPREPLY=( $(compgen -W "$UUIDS" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(swapon --show=UUID --noheading)" -- $cur) )
 			return 0
 			;;
 		'-L'|'LABEL=')
-			# only works for block devices, i.e., not for swap files.
-			local SWAPS
-			SWAPS="$(swapon --show=TYPE,NAME --raw --noheading | \
-				awk '$1 !~ /file/ { print $2 }')"
-			[ -z "$SWAPS" ] && return 0
-			local LABELS
-			LABELS="$(lsblk -nrp -o LABEL "$SWAPS")"
-			COMPREPLY=( $(compgen -W "$LABELS" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(swapon --show=LABEL --noheading)" -- $cur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
@@ -46,9 +32,7 @@ _swapoff_module()
 			return 0
 			;;
 	esac
-	local DEVS
-	DEVS="$(swapon --show=NAME --raw --noheading)"
-	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(swapon --show=NAME --raw --noheading)" -- $cur) )
 	return 0
 }
 complete -F _swapoff_module swapoff
diff --git a/bash-completion/swapon b/bash-completion/swapon
index 7656d4e..f471e07 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -14,7 +14,7 @@ _swapon_module()
 		'--show')
 			# FIXME: how to append to a string with compgen?
 			local OUTPUT
-			OUTPUT="NAME TYPE SIZE USED PRIO"
+			OUTPUT="NAME TYPE SIZE USED PRIO UUID LABEL"
 			compopt -o nospace
 			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
 			return 0
-- 
2.1.2

