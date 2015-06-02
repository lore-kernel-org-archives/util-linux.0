Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f52.google.com ([209.85.215.52]:36005 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759716AbbFBR7T (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Jun 2015 13:59:19 -0400
Received: by laei3 with SMTP id i3so43881266lae.3
        for <util-linux@vger.kernel.org>; Tue, 02 Jun 2015 10:59:18 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 2/3] bash-completion: sync lscpu completion with code
Date: Tue,  2 Jun 2015 23:59:02 +0600
Message-Id: <1433267943-2276-3-git-send-email-egorov@linux.com>
In-Reply-To: <1433267943-2276-1-git-send-email-egorov@linux.com>
References: <1433267943-2276-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove unexistent option, add two not listed in completion.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 bash-completion/lscpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/lscpu b/bash-completion/lscpu
index ecadd24..d28599d 100644
--- a/bash-completion/lscpu
+++ b/bash-completion/lscpu
@@ -12,7 +12,7 @@ _lscpu_module()
 			prefix="${cur%$realcur}"
 			OPTS_ALL="CPU CORE SOCKET NODE
 				BOOK CACHE POLARIZATION ADDRESS
-				CONFIGURED ONLINE MMHZ"
+				CONFIGURED ONLINE MAXMHZ MINMHZ"
 			for WORD in $OPTS_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
 					OPTS="$WORD $OPTS"
-- 
2.1.4

