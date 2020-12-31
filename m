Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18332C433DB
	for <util-linux@archiver.kernel.org>; Thu, 31 Dec 2020 00:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD8420B1F
	for <util-linux@archiver.kernel.org>; Thu, 31 Dec 2020 00:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgLaAee (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Dec 2020 19:34:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:45707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgLaAed (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Dec 2020 19:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609374780;
        bh=yx7YfWsbvcjxHgV+fKgR+TSb82t7Z8nuoyPFh81bVn0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MGTDuBjuQZEHNBNxOq/3op330RFmTWeWGtGnWoV7/QaxkOvoENoCGCqPT2nVxOc5Z
         kUfJX2LbPXgvqPcogh/52egPEpxrhRgpCBoDVDtBZ9uA11p1F33YpHTnXv/ZDu+Pc5
         /hx3+A6mH98Et/zJZpay0ZgDddKGXeu0SsMvqV04=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([62.143.246.89]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Ue3-1kwfhd1skb-006uLh; Thu, 31
 Dec 2020 01:33:00 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] fstab.5: NTFS and FAT volume IDs use upper case
Date:   Thu, 31 Dec 2020 01:32:54 +0100
Message-Id: <20201231003254.56902-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cxi5H2dTMi03DMGH0Efv3IcKW5nXk1HV2PdJCS7uFhqSRX+AE6a
 +4kRxhUX2uYu0OArr95J2imBan77psOKqQ6rKB20SwRCQr8A7qhjc+7BNHnHbYgmifz7lCa
 7lvJNJz7UlBH2sg/V8gU1N8GAEhfEq+byPukw86HDi7bxa0xXpaAB+5LAztVEWIx89kUMAs
 tMKYrdPx2b578oprtIcyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A897HhrHEms=:aJgv/ZL0PNN38kZ8atcI9k
 U9qZRCJJykKEhXvEb4Ie8oB2AJLefFPOisIa2izkZwqm1IT29IvKSiu76m6Psr2wqGQCvY7yh
 9yDLa4ePmHhdW/Y2eL+GleSkOz0TcnvaRlkufEATAD6EQQRefW1z6VTv/jU03iMDolxOHMKjs
 maPB23fJa2W8FbAw7bQiCqZ111I2t8oPnqkU/OFc6mBPdpccqhYlAoRQT7qZ859qbtO0gliFe
 qnaPGaZB1Zq8ZQKwmKd48iBW+89mPY9OD/QEhS4OreVGZiSNyf/3IE099gdOqDzfIlpyYaVS7
 23M5ktKzrfGWtOWZ6qyj2ikidjUAgcBLc/4bW/drjriaEjYKJBjtNRssJZ7Qcrvfzvfy8yD40
 2zpg1L2CpWjNeaTB7XbbPlek1Pz4buQHv01Z30aggH1ZS5UvIkzU1fXGoYbPIt62p+VyVRM34
 D2kSvaNew7QM/QN5hooqy6afKxOUjvsNL3VJmGSYVbrtWK7+oDt8qUnVf/urA7NX9vh/iWVMS
 3U5bqA3tdiAQ1VMaJ1nvxOAYIdMJ9FxFiiTbsvU6ETyBYfle74wrymw4Bx/tOVyUhgeKkv5/Z
 90TisgCTBi4PseKghV9+nym2FMMR+kAVyKQ9+lLkv9A5cakCmHFXzdugnKbFDL/QIkklb7JB+
 aBu8z0rHX8Z+e2rFmDRZFZ0DchZ3Nmv1gsLIenTH3w/O5UvdQ1ZopyZk4q7W4B1fjDPDW11jp
 RryEo5KjivSTpPUd/veH9PMsOfUjmIDuPNk78//A3iWeY0rZEC8YNOJb+nhLBWkCsFozYXjvt
 7Bl2Wxdx6mFTgydSQ11SgAslWRzFtWJPLlMA9Ve8Y2rBKJ5RvCe8+csw7U87FrYxwt63/fPE6
 v406aqwqbcfs4nTaeDSA==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The man-page indicates that mount expects UUIDs to be lower case.

Mention that NTFS and FAT volume IDs are to be specified in upper case.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 sys-utils/fstab.5 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 118df0d3d..2bee712d6 100644
=2D-- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -109,6 +109,8 @@ Note that
 .BR mount (8)
 uses UUIDs as strings. The string representation of the UUID should be ba=
sed on
 lower case characters.
+But when specifying the volume ID of FAT or NTFS file systems upper case
+characters are used (e.g UUID=3D"A40D-85E7" or UUID=3D"61DB7756DB7779B3")=
.
 .RE

 .B The second field
=2D-
2.29.2

