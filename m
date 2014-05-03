Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:50063 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbaECCcu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 May 2014 22:32:50 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 19/21] login-utils/last-deprecated.1: Improve the typesetting of the manual
Date: Sat,  3 May 2014 02:32:37 +0000
Message-Id: <1399084359-28425-3-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Change \(em to \- in the NAME section

  Add a space character in front of an ellipsis

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 login-utils/last-deprecated.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/last-deprecated.1 b/login-utils/last-deprecated.1
index beb6917..3176885 100644
--- a/login-utils/last-deprecated.1
+++ b/login-utils/last-deprecated.1
@@ -1,6 +1,6 @@
 .TH LAST 1 "March 1992" "util-linux" "User Commands"
 .SH NAME
-last \(em indicate last logins by user or terminal
+last \- indicate last logins by user or terminal
 .SH SYNOPSIS
 .ad l
 .B last
@@ -15,7 +15,7 @@ last \(em indicate last logins by user or terminal
 .IR address ]
 .RB [ \-l ]
 .RB [ \-y ]
-.RI [ name ...]
+.RI [ name " ...]
 .ad b
 .SH DESCRIPTION
 \fBLast\fP looks back in the \fBwtmp\fP file which records all logins
-- 
1.9.0

