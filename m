Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37391 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeDET5E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2018 15:57:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id r131so10442967wmb.2
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2018 12:57:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] bash-completion: setpriv --securebits argument can be comma separated list
Date: Thu,  5 Apr 2018 20:56:55 +0100
Message-Id: <20180405195656.4946-4-kerolasa@iki.fi>
In-Reply-To: <20180405195656.4946-1-kerolasa@iki.fi>
References: <20180405195656.4946-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make the option argument suggestion to match with what is allowed.  In same
go tidy shell code a little bit.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/setpriv | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/bash-completion/setpriv b/bash-completion/setpriv
index bf4737a3a..1c67f8288 100644
--- a/bash-completion/setpriv
+++ b/bash-completion/setpriv
@@ -46,10 +46,23 @@ _setpriv_module()
 			return 0
 			;;
 		'--securebits')
-			local SBITS
-			SBITS="noroot noroot_locked no_setuid_fixup no_setuid_fixup_locked keep_caps_locked
-			-noroot -noroot_locked -no_setuid_fixup -no_setuid_fixup_locked -keep_caps_locked"
-			COMPREPLY=( $(compgen -W "$SBITS" -- $cur) )
+			local prefix realcur SBITS_ALL SBITS WORD
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			SBITS_ALL="
+				{+,-}keep_caps_locked
+				{+,-}noroot
+				{+,-}noroot_locked
+				{+,-}no_setuid_fixup
+				{+,-}no_setuid_fixup_locked
+			"
+			for WORD in $SBITS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					SBITS="$WORD ${SBITS:-""}"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$SBITS" -S ',' -- $realcur) )
 			return 0
 			;;
 		'--selinux-label')
-- 
2.17.0

