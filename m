Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:34283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934745AbcHELFk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 5 Aug 2016 07:05:40 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id A45A2AAD1
	for <util-linux@vger.kernel.org>; Fri,  5 Aug 2016 11:05:39 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] deprecated.txt: Add sfdisk --show-pt-geometry
Message-ID: <62c52d8b-6ef8-7ca9-34d8-6a8fedab24ba@suse.cz>
Date: Fri, 5 Aug 2016 13:05:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 Documentation/deprecated.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index e63675a..81a4122 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -23,6 +23,11 @@ why:    unnecessary option, only 'S'ector unit is supported
 
 --------------------------
 
+what:   sfdisk --show-pt-geometry
+why:    equal to --show-geometry for a long time
+
+--------------------------
+
 what:  "swapon --summary" output format
 why:   does not provide control on output data formatting. The recommended solution
        is to use --show=<columns> in all scripts.
-- 
2.9.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
