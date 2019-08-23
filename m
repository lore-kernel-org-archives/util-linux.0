Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA3C3A5A2
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3221726
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AA94+tFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3qVFzws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbfHWKRQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:17:16 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42699 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731077AbfHWKRQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 06:17:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E7DDC3B4
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 06:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=/Js9xNTDMK3Br
        0ZUiGVitPd/jVCwdIqlnox8ouYz3Jk=; b=AA94+tFxxIJldiLfe9i74M6O9cVkz
        7T+Mrah8QaNcaJLCSGsX5Y4h0HQdF4yvoB3e05Jx7+wsm0HFY6jsUYvNq6D+I9gG
        ndCh4ZA17RrSJCZYKhbN2e+iK1NNkHDszgx9/878vHpSYyw1FQLvw/10bikyvOJn
        Sb9zYGuOaHsXDxjOxpqHFomqB4nW+XzsO9aL/FW/NcosFeQNCki+vh3oPVcxFCXq
        49Y0eyDRCVXmQIuJuAtxVK/+lPF+oLxSXnTQHraEg6V4cDmG+R8Wnle3OwZT/nJh
        eekCdjLmLE6blvif63z7gY/iw2n2iRNapuWnbXn8t59U1j6CLrvxOkpnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/Js9xNTDMK3Br0ZUiGVitPd/jVCwdIqlnox8ouYz3Jk=; b=k3qVFzws
        sssjpwOwsBkKWNm5LiihlBtyhSikrj6ilAw9QjJ0fA8fzvCvCZOSoB50x3RZeKXm
        weVQ2JgIQNoYOSqMYXOfGhRbqwBYTcIFw5U+vFNdmaRf6xITwJDIWmBuH8uL63V1
        Fd9JWBoCd0S8XpxsvAekFcLbfYXQKsD1fyXcdtl9q86PGuBmvMfG67vWBftuIhMS
        fiDqFxvXurhQd96o1h974FFxUe1YdALLoM+eeSsHQJekRB8JnAA7bsFyYdM2oX9o
        LgeYFY+MUdl6oPATua3IK03LGuCfyMOo6StSIWvVvUIuzHwunZhKhJq8EbCu6cQW
        nTUsZ8oWxOA8SA==
X-ME-Sender: <xms:Kr1fXU16DEhYiyamWxGCZ1Ny7DKIgZyov4q8QYAeV0BsFhdQf_6HAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecukfhppeejjedrudeluddrvddufedrvddttdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:Kr1fXUuqzJR7SLYxDd-DC723LbzxOk6thdWACG_bBnlPki27wXd4aA>
    <xmx:Kr1fXU-ZH3lf4BPlhCwYYfeYKW4s5n1mQkEppXH2VxwV-A5nbMJ8rA>
    <xmx:Kr1fXWgbVRuczjjPnHB6EYIXeW4uMiguOhhyjOSsokw51s5LrMJnEQ>
    <xmx:Kr1fXSl8O1JjyJgPqviFbqar79qDSXzdEt-QCx4an_ZpEOqksD3O4g>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14A88D60057
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:13 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 2a73f3d2 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 10:17:13 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/6] tests: fdisk: avoid hardcoding of errno string
Date:   Fri, 23 Aug 2019 12:17:02 +0200
Message-Id: <54d1893f4aa9b0326d4e7984f66341081c5d50c1.1566555078.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566555078.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The test fdisk/oddinput hardcodes strings returned by strerror(3P) for
both the errors ENOENT and ENOTTY. As these strings are unportable,
convert the tests to use the test_strerror helper instead to convert
them with sed(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tests/expected/fdisk/oddinput | 4 ++--
 tests/helpers/test_strerror.c | 2 ++
 tests/ts/fdisk/oddinput       | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
index 2fccc6cd5..219e98b67 100644
--- a/tests/expected/fdisk/oddinput
+++ b/tests/expected/fdisk/oddinput
@@ -6,6 +6,6 @@ Units: cylinders of 16065 * 512 = 8225280 bytes
 Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Nonexistent file
-fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
+fdisk: cannot open _a_file_that_does_not_exist_: ENOENT
 Too small file
-fdisk: cannot open oddinput.toosmall: Inappropriate ioctl for device
+fdisk: cannot open oddinput.toosmall: ENOTTY
diff --git a/tests/helpers/test_strerror.c b/tests/helpers/test_strerror.c
index 1919698eb..a063b1165 100644
--- a/tests/helpers/test_strerror.c
+++ b/tests/helpers/test_strerror.c
@@ -18,6 +18,8 @@ static struct {
 	const char *str;
 	int error;
 } errors[] = {
+	E(ENOENT),
+	E(ENOTTY),
 	E(EILSEQ)
 };
 
diff --git a/tests/ts/fdisk/oddinput b/tests/ts/fdisk/oddinput
index 067924264..7b0c8bfd4 100755
--- a/tests/ts/fdisk/oddinput
+++ b/tests/ts/fdisk/oddinput
@@ -38,10 +38,12 @@ ts_log "Empty image listing" # this should report empty partition table
 $TS_CMD_FDISK -c=dos -u=cylinders -l ${TEST_IMAGE_NAME} 2>&1 | sed -e "s/${TEST_IMAGE_NAME//\//\\/}/testimage/" >> $TS_OUTPUT
 
 ts_log "Nonexistent file" # this originally does absolutely nothing
-$TS_CMD_FDISK -c=dos -u=cylinders -l _a_file_that_does_not_exist_ >> $TS_OUTPUT 2>&1
+$TS_CMD_FDISK -c=dos -u=cylinders -l _a_file_that_does_not_exist_ 2>&1 |
+    sed -e "s@$($TS_HELPER_STRERROR ENOENT)@ENOENT@" >> $TS_OUTPUT
 
 ts_log "Too small file" # same here
 echo  "This file is too small" >> oddinput.toosmall
-$TS_CMD_FDISK -c=dos -u=cylinders -l oddinput.toosmall >> $TS_OUTPUT 2>&1
+$TS_CMD_FDISK -c=dos -u=cylinders -l oddinput.toosmall 2>&1 |
+    sed -e "s@$($TS_HELPER_STRERROR ENOTTY)@ENOTTY@" >> $TS_OUTPUT
 rm oddinput.toosmall
 ts_finalize
-- 
2.23.0

