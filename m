Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34718 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbdHZMpQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 26 Aug 2017 08:45:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id y14so1353642wrd.1
        for <util-linux@vger.kernel.org>; Sat, 26 Aug 2017 05:45:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] bash-completion: simplify pid listing
Date: Sat, 26 Aug 2017 13:45:13 +0100
Message-Id: <20170826124513.7823-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Changing directory in subshell does not effect parent process, so this is
better and possibly quicker way to list pids.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/nsenter | 2 +-
 bash-completion/prlimit | 2 +-
 bash-completion/renice  | 2 +-
 bash-completion/taskset | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bash-completion/nsenter b/bash-completion/nsenter
index ceea61001..ad56f06e4 100644
--- a/bash-completion/nsenter
+++ b/bash-completion/nsenter
@@ -15,7 +15,7 @@ _nsenter_module()
 			;;
 		'-t'|'--target')
 			local PIDS
-			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
+			PIDS=$(cd /proc && echo [0-9]*)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/prlimit b/bash-completion/prlimit
index f5e00bb16..fc60c6461 100644
--- a/bash-completion/prlimit
+++ b/bash-completion/prlimit
@@ -6,7 +6,7 @@ _prlimit_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-p'|'--pid')
-			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
+			PIDS=$(cd /proc && echo [0-9]*)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/renice b/bash-completion/renice
index c3e9331b0..2495f3785 100644
--- a/bash-completion/renice
+++ b/bash-completion/renice
@@ -17,7 +17,7 @@ _renice_module()
 			;;
 		'-p'|'--pid')
 			local PIDS
-			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
+			PIDS=$(cd /proc && echo [0-9]*)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/taskset b/bash-completion/taskset
index 8e62a3b67..453b17b4a 100644
--- a/bash-completion/taskset
+++ b/bash-completion/taskset
@@ -25,7 +25,7 @@ _taskset_module()
 			# setting an affinity the optarg has to be cpu
 			# mask.  The following is good only for getting
 			# affinity.
-			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
+			PIDS=$(cd /proc && echo [0-9]*)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
-- 
2.14.1

