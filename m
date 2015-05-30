Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33680 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbbE3SB2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 30 May 2015 14:01:28 -0400
Received: by lbcue7 with SMTP id ue7so64965750lbc.0
        for <util-linux@vger.kernel.org>; Sat, 30 May 2015 11:01:26 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH] bash-completion: handle comma-separated options in findmnt
Date: Sun, 31 May 2015 00:01:16 +0600
Message-Id: <1433008876-8622-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So, I discovered a way to complete comma-separated options. This
solution can become messy when you have too many values listed.

Similar fixes for other utils follow if this one will be merged.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 bash-completion/findmnt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index cf66565..3ad9147 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -43,15 +43,23 @@ _findmnt_module()
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="SOURCE TARGET FSTYPE OPTIONS VFS-OPTIONS
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+
+			OUTPUT_ALL="SOURCE TARGET FSTYPE OPTIONS VFS-OPTIONS
 				FS-OPTIONS LABEL UUID PARTLABEL PARTUUID
 				MAJ\:MIN ACTION OLD-TARGET OLD-OPTIONS
 				SIZE AVAIL USED USE% FSROOT TID ID
 				OPT-FIELDS PROPAGATION FREQ PASSNO"
+
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-t'|'--types')
-- 
2.1.4

