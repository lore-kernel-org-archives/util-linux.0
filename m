Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35042 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdCWWF1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 23 Mar 2017 18:05:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so1970660wmb.2
        for <util-linux@vger.kernel.org>; Thu, 23 Mar 2017 15:05:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] bash-completion: update fincore to have latest options
Date: Thu, 23 Mar 2017 22:05:23 +0000
Message-Id: <20170323220523.15309-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also include --output smartcols fields.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/fincore | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/bash-completion/fincore b/bash-completion/fincore
index d213586ca..9b1aed8f3 100644
--- a/bash-completion/fincore
+++ b/bash-completion/fincore
@@ -5,14 +5,35 @@ _fincore_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
+		'-o'|'--output')
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL='PAGES SIZE FILE'
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- "$realcur") )
+			return 0
+			;;
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
 	esac
 	case $cur in
 	    -*)
-			OPTS="--help
-				--version"
+			OPTS="
+				--json
+				--bytes
+				--noheadings
+				--output
+				--raw
+				--help
+				--version
+			"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
-- 
2.12.1

