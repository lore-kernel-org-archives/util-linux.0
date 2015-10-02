Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f49.google.com ([209.85.215.49]:36656 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbbJBJkR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 Oct 2015 05:40:17 -0400
Received: by laclj5 with SMTP id lj5so89408789lac.3
        for <util-linux@vger.kernel.org>; Fri, 02 Oct 2015 02:40:15 -0700 (PDT)
From: Alexander Kuleshov <kuleshovmail@gmail.com>
To: util-linux@vger.kernel.org
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] bash-completion/fndmt: curly brace missed
Date: Fri,  2 Oct 2015 15:38:56 +0600
Message-Id: <1443778736-29968-1-git-send-email-kuleshovmail@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch provides fix for bash-completion/fndmt script. There
is curly brace missed in the completion generation for the -M/--mountpoint
option.

In other way we will get following messages:

bash: /etc/bash_completion.d/findmnt: line 91: unexpected EOF while looking for matching `)'
bash: /etc/bash_completion.d/findmnt: line 141: syntax error: unexpected end of file

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 bash-completion/findmnt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index d7e06c8..946c22a 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -88,7 +88,7 @@ _findmnt_module()
 		'-M'|'--mountpoint')
 			local IFS=$'\n'
 			compopt -o filenames
-			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/") )
+			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/"}) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
-- 
2.6.0

