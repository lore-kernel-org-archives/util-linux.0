Return-Path: util-linux-owner@vger.kernel.org
Received: from hotei.ga-group.nl ([138.201.147.219]:38804 "EHLO
        hotei.ga-group.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZVQF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 26 Feb 2018 16:16:05 -0500
Received: from mail.ga-group.nl (p5780706c.dip0.t-ipconnect.de [87.128.112.108])
        by hotei.ga-group.nl (Postfix) with ESMTPS id 758F52B6E
        for <util-linux@vger.kernel.org>; Mon, 26 Feb 2018 22:16:03 +0100 (CET)
To: util-linux@vger.kernel.org
Subject: Re: ready for v2.32 ?
From: Ruediger Meier <ruediger.meier@ga-group.nl>
Date: Mon, 26 Feb 2018 22:16:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201802262216.01925.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is one test failure on big endian (ppc/ppc64)

[...]
  blkid: superblocks probing: [37] mpool               ... FAILED 
(blkid/low-probe-mpool)
[...]
---------------------------------------------------------------------
  1 tests of 199 FAILED
---------------------------------------------------------------------

--- /home/abuild/rpmbuild/BUILD/util-linux-2.32-rc1-31-79bd1/tests/expected/blkid/low-probe-mpool       
2018-02-26 20:14:24.265703542 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.32-rc1-31-79bd1/tests/output/blkid/low-probe-mpool 
2018-02-26 
20:38:14.300022547 +0000
@@ -1,6 +0,0 @@
-ID_FS_LABEL=mp1
-ID_FS_LABEL_ENC=mp1
-ID_FS_TYPE=mpool
-ID_FS_USAGE=filesystem
-ID_FS_UUID=2dfca1ea-651e-4694-976f-14654b0a8a83
-ID_FS_UUID_ENC=2dfca1ea-651e-4694-976f-14654b0a8a83
