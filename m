Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33072 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbLNVzF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:55:05 -0500
Received: by mail-wm0-f52.google.com with SMTP id n186so67536305wmn.0
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:55:05 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/8] bash-completion: fsck.cramfs, isosize: find files an argument
Date: Mon, 14 Dec 2015 21:54:48 +0000
Message-Id: <1450130093-12108-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier completion suggested only options for the command, this changes
options to be proposed when first character of an argument is dash.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/fsck.cramfs | 10 +++++++++-
 bash-completion/isosize     | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/bash-completion/fsck.cramfs b/bash-completion/fsck.cramfs
index 0d27b1c..afae495 100644
--- a/bash-completion/fsck.cramfs
+++ b/bash-completion/fsck.cramfs
@@ -15,7 +15,15 @@ _fsck.cramfs_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(fsck.cramfs --print-long-opts)" -S ' ' -- $cur) )
+	case $cur in
+		-*)
+			COMPREPLY=( $(compgen -W "$(fsck.cramfs --print-long-opts)" -- $cur) )
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
index 57f99c6..c38ff97 100644
--- a/bash-completion/isosize
+++ b/bash-completion/isosize
@@ -13,7 +13,15 @@ _isosize_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(isosize --print-long-opts)" -- $cur) )
+	case $cur in
+		-*)
+			COMPREPLY=( $(compgen -W "$(isosize --print-long-opts)" -- $cur) )
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
2.6.4

