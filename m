Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33161 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933066AbdGTGaP (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Jul 2017 02:30:15 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, kzak@redhat.com,
        mail@bernhard-voelker.de
Subject: [PATCH] setpriv: document accepted formats for naming caps
Date: Thu, 20 Jul 2017 08:30:04 +0200
Message-Id: <0eb0244be9842935dbe92e0c5b383b8563626424.1500532177.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since commit fbd15c4d4 (setpriv: support setting unnamed capabilities,
2017-07-17), it is possible to name capabilities not only by name, but
also by their index. While using the human-readable name is usually
recommended, using the index may be required in case new capabilities
have been introduced to the kernel for which we have no name yet. The
newly introduce format format is not documented inside of setpriv(1),
though, which is being fixed in this commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/setpriv.1 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index b0cc33a2b..75dadeca8 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -34,7 +34,12 @@ The argument is a comma-separated list of
 .BI + cap
 and
 .BI \- cap
-entries, which add or remove an entry respectively.
+entries, which add or remove an entry respectively. \fIcap\fR can either be a
+human-readable name as seen in
+.BR capabilities (7)
+without the \fIcap_\fR prefix or of the format
+.BI cap_N ,
+where \fIN\fR is the internal capability index used by Linux.
 .B +all
 and
 .B \-all
-- 
2.13.3

