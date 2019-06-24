Return-Path: <SRS0=Vkmh=UX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052AC43613
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 07:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5342089F
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 07:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfFXHlR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfFXHlR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Jun 2019 03:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E58F3001803;
        Mon, 24 Jun 2019 07:41:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D39A319722;
        Mon, 24 Jun 2019 07:41:16 +0000 (UTC)
Date:   Mon, 24 Jun 2019 09:41:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     unixmania@gmail.com
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] hwclock: define cmos_interface only if necessary
Message-ID: <20190624074114.oqz6s64pxgep562a@ws.net.home>
References: <20190623223052.3345-1-unixmania@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623223052.3345-1-unixmania@gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 24 Jun 2019 07:41:17 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jun 23, 2019 at 07:30:52PM -0300, unixmania@gmail.com wrote:
> Make the static declaration of the cmos_interface struct and related
> functions conditional to i386/x86_64, preventing several "defined but
> not used" compiler warnings.

I think we have to be more aggressive :-) It would be better to:

./configure.ac:
 * add --disable-hwclock-cmos
 * add USE_HWCLOCK_CMOS (enabled by default for i386/x86_64)
 * add define(USE_HWCLOCK_CMOS) 

sys-utils/Makemodule.am:
 * compile hwclock-cmos.c only "if USE_HWCLOCK_CMOS"

hwclock:
 * remove all unnecessary #ifdefs from hwclock-cmos.c
 * add #ifdef USE_HWCLOCK_CMOS to hwclock.c:determine_clock_access_method()


Note that we already use the same for RTC (which is linux only).

The result will be more readable hwclock-cmos.c and only optional cmos
code compilation.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
