Return-Path: <SRS0=Hpyb=RA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA6C43381
	for <util-linux@archiver.kernel.org>; Mon, 25 Feb 2019 11:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498752147C
	for <util-linux@archiver.kernel.org>; Mon, 25 Feb 2019 11:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfBYL4L (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:56:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfBYL4L (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 25 Feb 2019 06:56:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 826D83084244;
        Mon, 25 Feb 2019 11:56:11 +0000 (UTC)
Received: from ws.net.home (ovpn-204-99.brq.redhat.com [10.40.204.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B427E5D9CC;
        Mon, 25 Feb 2019 11:56:10 +0000 (UTC)
Date:   Mon, 25 Feb 2019 12:56:07 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?5Yaw5p+v?= <ziming_cool@126.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Bug report for libfdisk
Message-ID: <20190225115607.ifeexfakaocps6zf@ws.net.home>
References: <2a76c584.126b.169188b95a6.Coremail.ziming_cool@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a76c584.126b.169188b95a6.Coremail.ziming_cool@126.com>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 25 Feb 2019 11:56:11 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Feb 23, 2019 at 12:09:54PM +0800, 冰柯 wrote:
>     You can see it still prompts for `First sector` with the same
>     range 2048-8388607, while it should be 2048-3999999. This is
>     probably caused by the code I've listed already.  I've also
>     tried using cylinders as measure unit, and the problem repeated.
>     However, it works properly when creating a GPT partition.  I
>     don't think this is correct, though it's not very important. So,
>     hope this bug will be fixed soon.

This is limitation of the original fdisk code. I'll rewrite fist/last
free sector detection...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
