Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50637 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115Ab2C2Qpt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:49 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DF25E8FE2D
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:48 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 16/20] libuuid: fix typo in uuid_compare manpage
Date: Thu, 29 Mar 2012 18:45:24 +0200
Message-Id: <1333039528-24784-17-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libuuid/man/uuid_compare.3 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libuuid/man/uuid_compare.3 b/libuuid/man/uuid_compare.3
index e748eac..9300c51 100644
--- a/libuuid/man/uuid_compare.3
+++ b/libuuid/man/uuid_compare.3
@@ -47,7 +47,7 @@ to each other.
 .SH RETURN VALUE
 Returns an integer less than, equal to, or greater than zero if
 .I uu1
-is found,  respectively, to be lexigraphically less than, equal, or
+is found,  respectively, to be lexicographically less than, equal, or
 greater than
 .IR uu2 .
 .SH AUTHOR
-- 
1.7.7

