Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57657 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308AbaDHHs4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:56 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387mt35007704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:55 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTm004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:55 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/10] sulogin: minor man page improvements
Date: Tue,  8 Apr 2014 09:48:43 +0200
Message-Id: <1396943329-22347-5-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 login-utils/sulogin.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index a401446..57a7118 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -76,7 +76,7 @@ or
 to determine what shell to start.  If the environment variable is not set, it
 will try to execute root's shell from
 .IR /etc/passwd .
-If that fails it
+If that fails, it
 will fall back to
 .IR /bin/sh .
 .SH AUTHOR
-- 
1.8.5.1

