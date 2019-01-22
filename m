Return-Path: <SRS0=jsub=P6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AA2C282C3
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82C420855
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 12:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfAVMEG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:04:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbfAVMEG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Jan 2019 07:04:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA4B8C05A1D9;
        Tue, 22 Jan 2019 12:04:05 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D63A26A698;
        Tue, 22 Jan 2019 12:04:04 +0000 (UTC)
Date:   Tue, 22 Jan 2019 13:04:01 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     util-linux@vger.kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] libuuid: Make the uuid_unparse functions inline
Message-ID: <20190122120401.4bppg5ikgi6svren@ws.net.home>
References: <20190121024510.GA22370@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121024510.GA22370@localhost>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 22 Jan 2019 12:04:06 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jan 20, 2019 at 06:45:16PM -0800, Josh Triplett wrote:
> Various libraries, including libblkid, depend on libuuid solely to call
> uuid_unparse, which just prints a UUID.

It seems only libblkid requires solely uuid_unparse() :-) So, I guess
all we need is to use already implemented blkid_unparse_uuid() where
is the magic snprintf. I have applied this change:

 https://github.com/karelzak/util-linux/commit/c2435b946f574880201cb41d989d8d63d4bbf87d

The another stuff (e.g. mkswap, libfdisk, ...) depends on uuid_parse()
or/and uuid_generate(). So, libuuid is required there.

> Move the uuid_unparse functions to uuid.h and make them static
> inline, so that applications depending solely on the uuid_unparse
> functions don't need to pull in libuuid. Keep the out-of-line
> symbols for compatibility with existing applications.

It seems unnecessary.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
