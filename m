Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f47.google.com ([209.85.210.47]:62504 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3BFBHf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Feb 2013 20:07:35 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so329913dak.20
        for <util-linux@vger.kernel.org>; Tue, 05 Feb 2013 17:07:34 -0800 (PST)
From: Andy Lutomirski <luto@amacapital.net>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Sami Kerola <kerolasa@iki.fi>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] setpriv: Fix an error message typo
Date: Tue,  5 Feb 2013 17:07:26 -0800
Message-Id: <14de6354fd3639e8535cf0e927de20bc30a40db7.1360112785.git.luto@amacapital.net>
In-Reply-To: <20130205105153.GA24170@x2.net.home>
References: <20130205105153.GA24170@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 sys-utils/setpriv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 1662daf..921ce03 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -689,7 +689,7 @@ int main(int argc, char **argv)
 		case INHCAPS:
 			if (opts.caps_to_inherit)
 				errx(EXIT_FAILURE,
-				     _("duplicate --caps option"));
+				     _("duplicate --inh-caps option"));
 			opts.caps_to_inherit = optarg;
 			break;
 		case CAPBSET:
-- 
1.8.1

