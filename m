Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A693EC43217
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 15:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiDYPMK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiDYPMJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 11:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D3266E4DE
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650899343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oo9Cdxw062n0FQjxnxA3V6rrAmqbilo8oDAPWPqZpVA=;
        b=CcN3DslAYHIcexV7SlTP/RRw2hqucd7uLXIXuaAn24MT1vyDL9F8PSaLYeWxF3c9TUpGGv
        l8fhQoqppQTCMjTdLgB7dtXmRc8llroX6+fS6iIQJ9+XJwm8qEJDQL9+rnlqggwpjgrMMg
        wNDfLxQ9wvPn1H1/IIYVV3CZ36KlCHY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-cpNcxckWMROkO2wlgzuHHQ-1; Mon, 25 Apr 2022 11:09:01 -0400
X-MC-Unique: cpNcxckWMROkO2wlgzuHHQ-1
Received: by mail-ed1-f70.google.com with SMTP id cz24-20020a0564021cb800b00425dfdd7768so1891174edb.2
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oo9Cdxw062n0FQjxnxA3V6rrAmqbilo8oDAPWPqZpVA=;
        b=GX0ZyqjUBvNf8esynZ+NvlJ4TTn0KZdU9QPJhl033LPDlASWmOh1VmWho8LLotvA98
         EQQ/PAXxXm8jDvnAzuLveC89fh7+bYSObcHdsCrRaX6XbPgSu5vPC6NCA9txfTuMg5pP
         HceJ3SMF/LFWSmu7P23bnWNJ3ugvgYKzEL0Wo37zlk83KxJ2iJQqO822ClUcw5FSOPtR
         uP3TEFn7o2sAEkkO4jE+egqVzjI+Jg9QhA5nojBUum0QyvlYflVdVeQrKX0sYtsVJYQn
         FzT+A4sx32T446RcXXUPg9+iAQ7qNbZ/TE3X5RRHwkgfI3ajNlcGR8W65V5XzAQqjMZE
         vPNg==
X-Gm-Message-State: AOAM532ZHvAYT2qCzl1AfyLUWmWqjBLYON11SXv4S1wwDn26ycp1zgC+
        ijcJcQ0LRvAMKHl4y/4NnyT4+DduDdWPp+dH1fNHgrHwmMN/8y3NNOupiFBZr58gOI31cda/E+V
        RbBuLg+WzRb+yb3c6PubAaXUUfZjNq4CRWELZ53fteYlhfh+HxcLckWSGPzg1NtNfVeAZWubI
X-Received: by 2002:a17:907:9506:b0:6da:b4cd:515b with SMTP id ew6-20020a170907950600b006dab4cd515bmr16859611ejc.602.1650899340231;
        Mon, 25 Apr 2022 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwzYEJ2Ea61g1aDWRMS2ycfBmFHVEc8QflPbgrPUKZTGkn/9h5VYreWJp4qwATCybfk1Xbuw==
X-Received: by 2002:a17:907:9506:b0:6da:b4cd:515b with SMTP id ew6-20020a170907950600b006dab4cd515bmr16859594ejc.602.1650899340030;
        Mon, 25 Apr 2022 08:09:00 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i19-20020a1709061cd300b006f38920dbeesm1776878ejh.134.2022.04.25.08.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:08:59 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 3/3] blkid: add FSSIZE tag with tests for XFS
Date:   Mon, 25 Apr 2022 17:08:39 +0200
Message-Id: <20220425150838.151020-4-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425150838.151020-1-aalbersh@redhat.com>
References: <20220425150838.151020-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The FSSIZE tag was added to the libblkid. Enable this tag in blkid
and update tests golden output for XFS test cases.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 misc-utils/blkid.c                    | 3 ++-
 tests/expected/blkid/low-probe-xfs    | 1 +
 tests/expected/blkid/low-probe-xfs-v5 | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index d79527e3f..2edcd2b41 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -921,7 +921,8 @@ int main(int argc, char **argv)
 			blkid_probe_set_superblocks_flags(pr,
 				BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID |
 				BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE |
-				BLKID_SUBLKS_USAGE | BLKID_SUBLKS_VERSION);
+				BLKID_SUBLKS_USAGE | BLKID_SUBLKS_VERSION |
+				BLKID_SUBLKS_FSSIZE);
 
 
 			if (fltr_usage &&
diff --git a/tests/expected/blkid/low-probe-xfs b/tests/expected/blkid/low-probe-xfs
index 6eb1b4600..a91e92bcc 100644
--- a/tests/expected/blkid/low-probe-xfs
+++ b/tests/expected/blkid/low-probe-xfs
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=512
+ID_FS_FSSIZE=11862016
 ID_FS_LABEL=test-xfs
 ID_FS_LABEL_ENC=test-xfs
 ID_FS_TYPE=xfs
diff --git a/tests/expected/blkid/low-probe-xfs-v5 b/tests/expected/blkid/low-probe-xfs-v5
index 513a3818f..129b41f26 100644
--- a/tests/expected/blkid/low-probe-xfs-v5
+++ b/tests/expected/blkid/low-probe-xfs-v5
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=512
+ID_FS_FSSIZE=17469440
 ID_FS_LABEL=test-xfs-v5
 ID_FS_LABEL_ENC=test-xfs-v5
 ID_FS_TYPE=xfs
-- 
2.27.0

