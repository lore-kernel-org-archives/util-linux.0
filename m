Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58118 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756320AbaDHHs6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:58 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387mwOF017081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:58 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTp004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:57 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/10] vipw: minor man page improvements
Date: Tue,  8 Apr 2014 09:48:46 +0200
Message-Id: <1396943329-22347-8-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 login-utils/vipw.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/vipw.8 b/login-utils/vipw.8
index 62dcc85..ab7b76c 100644
--- a/login-utils/vipw.8
+++ b/login-utils/vipw.8
@@ -58,7 +58,7 @@ edits the group file in the same manner as
 .B vipw
 does the passwd file.
 .SH ENVIRONMENT
-If the following environment variable exists it will be utilized by
+If the following environment variable exists, it will be utilized by
 .B vipw
 and
 .BR vigr :
-- 
1.8.5.1

