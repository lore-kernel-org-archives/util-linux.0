Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36627 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbbGCSDQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Jul 2015 14:03:16 -0400
Received: by widjy10 with SMTP id jy10so115417276wid.1
        for <util-linux@vger.kernel.org>; Fri, 03 Jul 2015 11:03:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] bash-completion: cal: add --twelve and --color options
Date: Fri,  3 Jul 2015 19:03:08 +0100
Message-Id: <1435946588-895-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/cal | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/bash-completion/cal b/bash-completion/cal
index 1510eb1..3b65e8e 100644
--- a/bash-completion/cal
+++ b/bash-completion/cal
@@ -3,15 +3,22 @@ _cal_module()
 	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
-	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	case $prev in
-		'-h'|'--help'|'-V'|'--version')
-			return 0
-			;;
-	esac
 	case $cur in
 		-*)
-			OPTS="--one --three --sunday --monday --julian --year --week --version --help"
+			OPTS="	--one
+				--three
+				--months
+				--sunday
+				--monday
+				--julian
+				--year
+				--twelve
+				--week
+				--color=auto
+				--color=always
+				--color=never
+				--version
+				--help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
-- 
2.4.5

