Return-Path: <SRS0=hTuh=YY=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41438CA9ECB
	for <util-linux@archiver.kernel.org>; Thu, 31 Oct 2019 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182F420873
	for <util-linux@archiver.kernel.org>; Thu, 31 Oct 2019 16:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTSjVatg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfJaQvw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:51:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21479 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727715AbfJaQvv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 31 Oct 2019 12:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572540711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/4m0eWbXFhGE2ZsLsrPeOxnOWBrFxeo/0wFiaBh9jIc=;
        b=CTSjVatg1gxvmyyq3jNxNkknOVfR0vECFTA/yrYVqp1lqtC4n6AkKzLtIffP1JfqDigKnv
        bx1w4p2qo4zi6hm3px+V2ZfQ6TucZFbgpVP3EJFe1X6eh7I9TcuqnSzmEdoB25oFBhOmns
        sHkSZm9BTqHHRnkN0bgLNzhxDtt2Oio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ma5fXHEGPiO8eyNWNqkRWw-1; Thu, 31 Oct 2019 12:51:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B1145EA
        for <util-linux@vger.kernel.org>; Thu, 31 Oct 2019 16:51:48 +0000 (UTC)
Received: from cicero.redhat.com (unknown [10.33.36.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C2E31001B09
        for <util-linux@vger.kernel.org>; Thu, 31 Oct 2019 16:51:46 +0000 (UTC)
From:   Andrew Price <anprice@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] fallocate.1: List gfs2 as supporting punch-hole
Date:   Thu, 31 Oct 2019 16:51:44 +0000
Message-Id: <20191031165144.1877-1-anprice@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ma5fXHEGPiO8eyNWNqkRWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 sys-utils/fallocate.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index fe5072ae8..0fc2ec97b 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -134,7 +134,7 @@ Also, when using this option,
 is implied.
 .sp
 Supported for XFS (since Linux 2.6.38), ext4 (since Linux 3.0),
-Btrfs (since Linux 3.7) and tmpfs (since Linux 3.5).
+Btrfs (since Linux 3.7), tmpfs (since Linux 3.5) and gfs2 (since Linux 4.1=
6).
 .TP
 .BR \-v ", " \-\-verbose
 Enable verbose mode.
--=20
2.21.0

