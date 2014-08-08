Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:57676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbaHHRa5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:57 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id D8C70AD81
	for <util-linux@vger.kernel.org>; Fri,  8 Aug 2014 17:30:55 +0000 (UTC)
Message-ID: <1407519055.7862.32.camel@oct.suse.cz>
Subject: [PATCH] Fix bash-completion Makemodule options
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Fri, 08 Aug 2014 19:30:55 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 bash-completion/Makemodule.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 8d6431b..a6d357d 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -122,7 +122,7 @@ endif
 if BUILD_FDFORMAT
 dist_bashcompletion_DATA += bash-completion/fdformat
 endif
-if LINUX
+if BUILD_BLOCKDEV
 dist_bashcompletion_DATA += bash-completion/blockdev
 endif
 
-- 
1.8.4.5

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

