Return-Path: <SRS0=c7ae=57=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A83C3815B
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 07:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A5520768
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 07:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COYgSvhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404457AbgDOHIV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:08:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45826 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404415AbgDOHIS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Apr 2020 03:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586934497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4uNc9ZPD5yV6zDgguZ1dFlb25HnGYyR+qhlhiJC+qTE=;
        b=COYgSvhW5/5iyOe2qN2uJrljZxIfKbr19kQ8ZgTPPf20P0K1IPq02caSmT/Us2LOfaZTYA
        orqofN1Sk1A2mqvr4cHwAJ2sLLrdzvukBv6qufKDEX3p+oRC697oKe8rQ//Eb7WVyAXjKF
        ghsBYNxNzbUIisPPFCtzEX+eJDRcNEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-WoNvOwUvO-mWTT4oKea7Lg-1; Wed, 15 Apr 2020 03:08:15 -0400
X-MC-Unique: WoNvOwUvO-mWTT4oKea7Lg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9A21800D53;
        Wed, 15 Apr 2020 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 233A59F9B0;
        Wed, 15 Apr 2020 07:08:13 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Patrick Oppenlander <patrick.oppenlander@gmail.com>
Subject: [PATCH] blkdiscard: (man) offset and length must be sector aligned
Date:   Wed, 15 Apr 2020 09:08:12 +0200
Message-Id: <20200415070812.25574-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Update blkdiscard manual page. Length and offset values must be aligned
to the device sector size.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
---
 sys-utils/blkdiscard.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
index 98c6f36a9..bd3950b1f 100644
--- a/sys-utils/blkdiscard.8
+++ b/sys-utils/blkdiscard.8
@@ -43,11 +43,11 @@ The force option disables the exclusive access mode.
 .TP
 .BR \-o , " \-\-offset \fIoffset"
 Byte offset into the device from which to start discarding.  The provide=
d value
-will be aligned to the device sector size.  The default value is zero.
+must be aligned to the device sector size.  The default value is zero.
 .TP
 .BR \-l , " \-\-length \fIlength"
 The number of bytes to discard (counting from the starting point).  The =
provided value
-will be aligned to the device sector size.  If the specified value exten=
ds past
+must be aligned to the device sector size.  If the specified value exten=
ds past
 the end of the device,
 .B blkdiscard
 will stop at the device size boundary.  The default value extends to the=
 end
--=20
2.21.1

