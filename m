Return-Path: <SRS0=vtrZ=3S=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BDC33C9E
	for <util-linux@archiver.kernel.org>; Wed, 29 Jan 2020 00:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEB822522
	for <util-linux@archiver.kernel.org>; Wed, 29 Jan 2020 00:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgA2AdX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 28 Jan 2020 19:33:23 -0500
Received: from ishtar.tlinx.org ([173.164.175.65]:38556 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgA2AdX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2020 19:33:23 -0500
X-Greylist: delayed 1086 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 19:33:23 EST
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 00T0F7AI057066;
        Tue, 28 Jan 2020 16:15:09 -0800
Message-ID: <5E30CE8B.1080007@tlinx.org>
Date:   Tue, 28 Jan 2020 16:15:07 -0800
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>
CC:     "Theodore Ts'o" <tytso@mit.edu>, util-linux@vger.kernel.org,
        LKML <linux-lkml@vger.kernel.org>
Subject: Re: [PATCH] build-sys: fix configure --without-systemd
References: <20200124172947.877099-1-tytso@mit.edu> <20200128120733.s3n7f5gidsorwii7@ws.net.home>
In-Reply-To: <20200128120733.s3n7f5gidsorwii7@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2020/01/28 04:07, Karel Zak wrote:
> On Fri, Jan 24, 2020 at 12:29:47PM -0500, Theodore Ts'o wrote:
>   
>>  AC_ARG_WITH([systemd],
>>    AS_HELP_STRING([--without-systemd], [do not build with systemd support]),
>> -  [], [with_systemd=check]
>> +  [], [with_systemd=no]
>>     
>
> The current default is to check for the libraries, if installed than
> enable systemd support. This is generic way we use for many libs and
> features. Why do you think that explicit --enable-* will be better?
>   
---

    Perhaps Ted didn't realize that the line he replaced
was only the default action (1st bracket pair empty => no option).
Initially, I thought the same until I read further
down (two lines):

have_systemd=no
AS_IF([test "x$with_systemd" != xno], [ ...
   test for positive case ]

If any of the tests fail, then 'have_systemd=no'
is the option passed along.

I don't _think_ Ted is asking for for the default to be
changed, as the subject of his note states it is
to fix the "--without-systemd" case, but a
fix was added for a bug that wasn't present,
so I don't think he knowingly did what he
intended to do.







