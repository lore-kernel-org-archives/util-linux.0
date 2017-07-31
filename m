Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37710 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdGaTzY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so83960wmt.4
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/9] bash-completion: look for look completions
Date: Mon, 31 Jul 2017 20:55:05 +0100
Message-Id: <20170731195508.11661-7-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The look(1) uses positional arguments, where first one is a word from
dictionary.  It is reasonable to assume most of the time people search from
system word lists so propose completions from there.  The second argument is
a dictionary file, that might invalidate the first input but that only
happens to users who have an idea what the want without bash-completion.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/look | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bash-completion/look b/bash-completion/look
index 303a7565a..feafe2379 100644
--- a/bash-completion/look
+++ b/bash-completion/look
@@ -20,9 +20,16 @@ _look_module()
 			return 0
 			;;
 	esac
-	local IFS=$'\n'
-	compopt -o filenames
-	COMPREPLY=( $(compgen -f -- $cur) )
+	case $COMP_CWORD in
+		1)
+			COMPREPLY=( $(compgen -W "$(look "$cur")" -- $cur) )
+			;;
+		2)
+			local IFS=$'\n'
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			;;
+	esac
 	return 0
 }
 complete -F _look_module look
-- 
2.13.3

