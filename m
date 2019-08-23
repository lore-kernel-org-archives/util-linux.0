Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A7FC3A5A2
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E252166E
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xJzrG7VY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m2sVWIJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfHWNdX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:33:23 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54691 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389164AbfHWNdW (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 09:33:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 92FB83AE;
        Fri, 23 Aug 2019 09:33:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 09:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=/Js9xNTDMK3Br
        0ZUiGVitPd/jVCwdIqlnox8ouYz3Jk=; b=xJzrG7VYoZn7JVP+3e02YZqtflD/s
        Gep8LXDz32pxttqaoDY0j5ev31lVzNlDXDTm4OMr+tpWfquxIoo4TTVcZ3zJmxsS
        JyEwGNY3d/21jzWQhuTikaulqdRcNtElK073UXAr7sPZou6pG0ys7EIuNXgtXV23
        AkXx0V1YiemOcl5rFUQHdNxA+vCPh+PLw10Wy0rCcFOYBEnnPCNmxSks6VF7/7Xw
        CN07qy9BdkmSZlatRfAInbhkuS4MABEPZxYuGigpb+QLbtveMaRc1hw4WVhq4HiW
        jV1QunZwVGnpHD329b75i5HqZm9X+AsGT7UJm7VvKVuhHQXeVo/5dVMkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/Js9xNTDMK3Br0ZUiGVitPd/jVCwdIqlnox8ouYz3Jk=; b=m2sVWIJW
        ExrooeRbMJQF1z1qT7LfvR93DtVEob856NJQhyCzLTmKNxOWGvc4FPsBvhgnQtsz
        8rgcOh65MAuwjWBqi/Dz8qbvW3G0GLB4OTpchTNQc0SSP15kelSUMUREwaR+eoia
        XKkKMguhCvxvvri4Sl1F8L7yQTAwLSrIbBRr/kAX2CyL+vaSmH9YO9ePK1f79f/F
        2P+EevbKx4OwHuIJ1WJwYWQo3hsIVrDa8oJ9s3ti6AvUI+zVfUGqtYlgZrOJdE93
        09xKXKq5aYMU5RVeX/vsmaHXeuO91fbVkyRBlH+VeBsnTYrNTbnA7J9jHAu6ulH/
        +fLyWR9RHj5bQA==
X-ME-Sender: <xms:IetfXTq5jN8rp45M9Kk2SRAigX4aM2jhQ6Dm5qbuD7oakHGl6IJR1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddule
    durddvudefrddvtddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    necuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:IetfXam3WT4xoePwz2ssJ0lZNx9RL28nZhhIi5ZJkhudsbmPXm65IA>
    <xmx:IetfXb0m6nkH7mNO2GjnAjhq0uVS5gchz7nj2M8BQ-h0EipoEwei6w>
    <xmx:IetfXfTa-gtv5Fs9NpwzFwZV_f1jxohyE-M4ZBL9I96j2HwGEjGlWA>
    <xmx:IetfXZ76eiuW3XUytWH3SSY0ET3Hu5ZvSWC1qVB07YiK_lex2FIaoQ>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7465F8005B;
        Fri, 23 Aug 2019 09:33:20 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id c9630727 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 13:33:20 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 6/6] tests: fdisk: avoid hardcoding of errno string
Date:   Fri, 23 Aug 2019 15:32:58 +0200
Message-Id: <89b7734b4bf0f4d61e6b3bc75bd35524c510eefb.1566566906.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566566906.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im> <cover.1566566906.git.ps@pks.im>
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

