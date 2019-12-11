Return-Path: <SRS0=hwxx=2B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D1AC43603
	for <util-linux@archiver.kernel.org>; Wed, 11 Dec 2019 12:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DDC214D8
	for <util-linux@archiver.kernel.org>; Wed, 11 Dec 2019 12:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfLKMRF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:17:05 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:54100
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbfLKMRF (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 11 Dec 2019 07:17:05 -0500
X-IronPort-AV: E=Sophos;i="5.69,301,1571695200"; 
   d="scan'208";a="332811941"
Received: from unknown (HELO function) ([193.50.111.121])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2019 13:17:03 +0100
Received: from samy by function with local (Exim 4.92.3)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1if0vP-000VQH-04; Wed, 11 Dec 2019 13:17:03 +0100
Date:   Wed, 11 Dec 2019 13:17:02 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35-rc1
Message-ID: <20191211121702.337bssjynpupiimz@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20191211101831.ei3qksv6c2qk4aii@10.255.255.10>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3x43o42umwx3g6gn"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211101831.ei3qksv6c2qk4aii@10.255.255.10>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--3x43o42umwx3g6gn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Karel Zak, le mer. 11 déc. 2019 11:18:31 +0100, a ecrit:
> The util-linux release v2.35-rc1 is available at
> 
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.35
> 
> Feedback and bug reports, as always, are welcomed.

scriptlive is made conditional on pty support, but was still hardcoded
as [yes], the attached patch makes it [check] like all others having
such kind of condition.

Samuel

--3x43o42umwx3g6gn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/configure.ac b/configure.ac
index 40352a0fb..c187927e1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1845,7 +1845,7 @@ AM_CONDITIONAL([BUILD_SCRIPT], [test "x$build_script" = xyes])
 UL_BUILD_INIT([scriptreplay], [yes])
 AM_CONDITIONAL([BUILD_SCRIPTREPLAY], [test "x$build_scriptreplay" = xyes])
 
-UL_BUILD_INIT([scriptlive], [yes])
+UL_BUILD_INIT([scriptlive], [check])
 UL_REQUIRES_HAVE([scriptlive], [pty])
 AM_CONDITIONAL([BUILD_SCRIPTLIVE], [test "x$build_scriptlive" = xyes])
 

--3x43o42umwx3g6gn--
