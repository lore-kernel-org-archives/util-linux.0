Return-Path: util-linux-owner@vger.kernel.org
Received: from inpost.hi.is ([130.208.165.62]:36228 "EHLO inpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFC5s (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 5 Aug 2018 22:57:48 -0400
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id w760pDC0009629
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Mon, 6 Aug 2018 00:51:13 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w760pDf8005523
        for <util-linux@vger.kernel.org>; Mon, 6 Aug 2018 00:51:13 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w760pDfx005522
        for util-linux@vger.kernel.org; Mon, 6 Aug 2018 00:51:13 GMT
Date: Mon, 6 Aug 2018 00:51:13 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] agetty.8: Avoid a warning about an unbreakable line
Message-ID: <20180806005113.GA5494@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Make the indent depend on the formatting command, nroff or troff.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>

---

Warning from "test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z"

  [ "test-groff" is a developmental version of "groff" ]

Input file is ././term-utils/agetty.8

.../git/groff/build/../tmac/an-old.tmac:382: backtrace: macro 'B'
troff: <./term-utils/agetty.8>:330: warning [p 5, 8.7i]: can't break line

 term-utils/agetty.8 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 5a480808d..1ef938769 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -326,7 +326,8 @@ For a Hayes modem with a fixed 115200 bps interface to the machine
 modem/computer DCD track modem/modem DCD, makes a DTR drop cause a
 disconnection, and turns on auto-answer after 1 ring):
 
-.RS
+.ie n .RS 0
+.el .RS
 .B /sbin/agetty\ \-\-wait\-cr\ \-\-init\-string\ 'ATE0Q1&D2&C1S0=1\\015'\ 115200\ ttyS1
 .RE
 
-- 
2.18.0

-- 
Bjarni I. Gislason
