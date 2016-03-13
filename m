Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34934 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413AbcCMKcD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:32:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id n205so9980257wmf.2
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:32:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/10] bash-completion: fsck.cramfs, isosize: find files an argument
Date: Sun, 13 Mar 2016 10:31:45 +0000
Message-Id: <1457865109-2881-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier completion suggested only options for the command, this changes
options to be proposed when first character of an argument is dash.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/fsck.cramfs | 11 +++++++++--
 bash-completion/isosize     | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/bash-completion/fsck.cramfs b/bash-completion/fsck.cramfs
index acf6564..b3276b9 100644
--- a/bash-completion/fsck.cramfs
+++ b/bash-completion/fsck.cramfs
@@ -15,8 +15,15 @@ _fsck.cramfs_module()
 			return 0
 			;;
 	esac
-	OPTS='--verbose --destination --help --version file'
-	COMPREPLY=( $(compgen -W "${OPTS[*]}" -S ' ' -- $cur) )
+	case $cur in
+		-*)
+			COMPREPLY=( $(compgen -W "--verbose --blocksize --extract --help --version" -- $cur) )
+			return 0
+			;;
+	esac
+	local IFS=$'\n'
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
 	return 0
 }
 complete -F _fsck.cramfs_module fsck.cramfs
diff --git a/bash-completion/isosize b/bash-completion/isosize
index 13d4d29..fec2f8b 100644
--- a/bash-completion/isosize
+++ b/bash-completion/isosize
@@ -13,8 +13,15 @@ _isosize_module()
 			return 0
 			;;
 	esac
-	OPTS='--divisor --sectors --help --version'
-	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	case $cur in
+		-*)
+			COMPREPLY=( $(compgen -W "--divisor --sectors --help --version" -- $cur) )
+			return 0
+			;;
+	esac
+	local IFS=$'\n'
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
 	return 0
 }
 complete -F _isosize_module isosize
-- 
2.7.2

