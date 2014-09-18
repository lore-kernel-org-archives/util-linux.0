Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:46887 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbaIRXhd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Sep 2014 19:37:33 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 60A5DE161
	for <util-linux@vger.kernel.org>; Fri, 19 Sep 2014 01:37:02 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 4/5] build-sys: swaplabel needs libmount
Date: Fri, 19 Sep 2014 01:36:36 +0200
Message-Id: <1411083397-8056-4-git-send-email-andreas@fatal.se>
In-Reply-To: <1411083397-8056-1-git-send-email-andreas@fatal.se>
References: <1411083397-8056-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The swaplabel utility uses libmount functionality and
thus libmount has to be available if we want to build
swaplabel. This change makes swaplabel be automatically
disabled when we don't.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index ed3a65d..f8b3397 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1143,6 +1143,7 @@ AM_CONDITIONAL([BUILD_WDCTL], [test "x$build_wdctl" = xyes])
 
 UL_BUILD_INIT([swaplabel], [check])
 UL_REQUIRES_BUILD([swaplabel], [libblkid])
+UL_REQUIRES_BUILD([swaplabel], [libmount])
 AM_CONDITIONAL([BUILD_SWAPLABEL], [test "x$build_swaplabel" = xyes])
 
 
-- 
2.1.0.rc1

