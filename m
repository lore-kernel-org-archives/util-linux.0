Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36048 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcDCIfh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Apr 2016 04:35:37 -0400
Received: by mail-lb0-f195.google.com with SMTP id q4so16196008lbq.3
        for <util-linux@vger.kernel.org>; Sun, 03 Apr 2016 01:35:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] bash-completion: update chrt completion
Date: Sun,  3 Apr 2016 09:35:28 +0100
Message-Id: <1459672529-2278-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add couple missing options, and make the completion overall work better.

That said completion is still incomplete, pardon the pun.  After user has
specified policy then giving a hint what priority needs to be specified is
theoretically possible, but such hint is not given.  There does not seem to
be easy way to know when user wants stops specifying options and move to
defining priority in: chrt [options] [prio] [command|pid].

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/chrt | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/bash-completion/chrt b/bash-completion/chrt
index 388d298..ce0b915 100644
--- a/bash-completion/chrt
+++ b/bash-completion/chrt
@@ -8,31 +8,45 @@ _chrt_module()
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
+		'-T'|'--sched-runtime'|'-P'|'--sched-period'|'-D'|'--sched-deadline')
+			COMPREPLY=( $(compgen -W "nanoseconds" -- $cur) )
+			return 0
+			;;
 	esac
-	# FIXME: -p is ambiguous, it takes either pid or priority as an
-	# argument depending on whether user wanted to get or set the
-	# values.  Perhaps the command interface should be reconsidered.
 	case $cur in
 		-*)
-			OPTS="--batch
-				--fifo
-				--idle
-				--other
-				--rr
-				--reset-on-fork
+			OPTS="
 				--all-tasks
+				--batch
+				--deadline
+				--fifo
 				--help
+				--idle
 				--max
+				--other
 				--pid
+				--reset-on-fork
+				--rr
+				--sched-deadline
+				--sched-period
+				--sched-runtime
 				--verbose
-				--version"
+				--version
+			"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
 	esac
-	local PIDS
-	PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
-	COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
+	local i
+	for i in ${COMP_WORDS[*]}; do
+		case $i in
+		'-p'|'--pid')
+			COMPREPLY=( $(compgen -W "$(cd /proc && echo [0-9]*)" -- $cur) )
+			return 0
+			;;
+		esac
+	done
+	COMPREPLY=( $(compgen -c -- $cur) )
 	return 0
 }
 complete -F _chrt_module chrt
-- 
2.8.0

