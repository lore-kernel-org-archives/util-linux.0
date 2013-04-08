Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40482 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTda (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:30 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so2949883wid.6
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/14] bash-completion: swapon: add options and fix argument
Date: Mon,  8 Apr 2013 20:32:48 +0100
Message-Id: <1365449579-13238-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The initial bash-completion missed swapon options -L and -U.  Use of
block device was proposed to be more appropriate than a path to a file.

Requested-by: Karel Zak <kzak@redhat.com>
References: http://marc.info/?l=util-linux-ng&m=136517310727426&w=2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/swapon | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/bash-completion/swapon b/bash-completion/swapon
index e127153..7656d4e 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -19,6 +19,18 @@ _swapon_module()
 			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
 			return 0
 			;;
+		'-U')
+			local UUIDS
+			UUIDS="$(lsblk -nrp -o FSTYPE,UUID | awk '$1 ~ /swap/ { print $2 }')"
+			COMPREPLY=( $(compgen -W "$UUIDS" -- $cur) )
+			return 0
+			;;
+		'-L')
+			local LABELS
+			LABELS="$(lsblk -nrp -o FSTYPE,LABEL | awk '$1 ~ /swap/ { print $2 }')"
+			COMPREPLY=( $(compgen -W "$LABELS" -- $cur) )
+			return 0
+			;;
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
@@ -42,10 +54,9 @@ _swapon_module()
 			return 0
 			;;
 	esac
-	# FIXME: compgen will split SPEC= from '=' point.  The append
-	# comma separated value problem is very similar.
-	compopt -o filenames
-	COMPREPLY=( $(compgen -f -- $cur) )
+	local DEVS
+	DEVS="$(lsblk -nrp -o FSTYPE,NAME | awk '$1 ~ /swap/ { print $2 }')"
+	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
 complete -F _swapon_module swapon
-- 
1.8.2.1

