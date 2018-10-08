Return-Path: <SRS0=4QkE=MU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C499C65C20
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 12:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C9F20858
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 12:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C9F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeJHTmL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeJHTmK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 8 Oct 2018 15:42:10 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8B6774F17;
        Mon,  8 Oct 2018 12:30:41 +0000 (UTC)
Received: from ws.net.home (ovpn-117-176.ams2.redhat.com [10.36.117.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 024352010D06;
        Mon,  8 Oct 2018 12:30:40 +0000 (UTC)
Date:   Mon, 8 Oct 2018 14:30:39 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/2] unshare: add some chroot magic
Message-ID: <20181008123039.nsqyt3wosdv2koj5@ws.net.home>
References: <20181005110930.14615-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005110930.14615-1-laurent@vivier.eu>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 08 Oct 2018 12:30:41 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Oct 05, 2018 at 01:09:28PM +0200, Laurent Vivier wrote:
> v2: allow to use --wd without --root
>     fix a bug when we use --mount-proc with --root
>     -> don't remount /proc to none
>     fix tabulation

Seems good. Thanks.

I'm going to merge it later after release v2.33.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
