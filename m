Return-Path: <SRS0=qkB4=7X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BAFC433E0
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0B9206F4
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFJW1m (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgFJW1l (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 18:27:41 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145DAC03E96B
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 15:27:40 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05AMRdIA012204
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 22:27:39 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05AMRdIA012204
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05AMRd6h020084
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 22:27:39 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05AMRdNp020083
        for util-linux@vger.kernel.org; Wed, 10 Jun 2020 22:27:39 GMT
Date:   Wed, 10 Jun 2020 22:27:39 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: libuuid/man/*: Fix some warnings from "mandoc -T lint"
Message-ID: <20200610222739.GA20040@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./libuuid/man/uuid_generate.3:44:101: STYLE: unterminated quoted argument

mandoc: ./libuuid/man/uuid_generate.3:45:102: STYLE: unterminated quoted argument

####

  There is no change in the output of "nroff" or "groff".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 libuuid/man/uuid_generate.3 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index e06df48f6..0043c625f 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -41,8 +41,8 @@ uuid_generate_time_safe \- create a new unique UUID value
 .BI "void uuid_generate_random(uuid_t " out );
 .BI "void uuid_generate_time(uuid_t " out );
 .BI "int uuid_generate_time_safe(uuid_t " out );
-.BI "void uuid_generate_md5(uuid_t " out ", const uuid_t " ns ", const char " *name ", size_t " len ");
-.BI "void uuid_generate_sha1(uuid_t " out ", const uuid_t " ns ", const char " *name ", size_t " len ");
+.BI "void uuid_generate_md5(uuid_t " out ", const uuid_t " ns ", const char " *name ", size_t " len );
+.BI "void uuid_generate_sha1(uuid_t " out ", const uuid_t " ns ", const char " *name ", size_t " len );
 .fi
 .SH DESCRIPTION
 The
-- 
2.26.2
