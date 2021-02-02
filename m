Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A7FC433E0
	for <util-linux@archiver.kernel.org>; Tue,  2 Feb 2021 11:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E6E64DD4
	for <util-linux@archiver.kernel.org>; Tue,  2 Feb 2021 11:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBBLDP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:03:15 -0500
Received: from foss.arm.com ([217.140.110.172]:47752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBBLDO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Feb 2021 06:03:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE7C1396;
        Tue,  2 Feb 2021 03:02:28 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A086E3F7D7;
        Tue,  2 Feb 2021 03:02:27 -0800 (PST)
Date:   Tue, 2 Feb 2021 11:02:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/5] Add uclampset schedutil
Message-ID: <20210202110225.bhddyfcu43v34y7e@e107158-lin>
References: <20210130205039.581764-1-qais.yousef@arm.com>
 <20210130205039.581764-3-qais.yousef@arm.com>
 <20210201161252.3suz2dbihpdxyg5x@ws.net.home>
 <20210201173202.jrsd6mbhbm2hhebm@e107158-lin>
 <20210202080131.lyvsda3rtp7btc3q@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210202080131.lyvsda3rtp7btc3q@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 02/02/21 09:01, Karel Zak wrote:
> On Mon, Feb 01, 2021 at 05:32:02PM +0000, Qais Yousef wrote:
> > On 02/01/21 17:12, Karel Zak wrote:
> > > On Sat, Jan 30, 2021 at 08:50:36PM +0000, Qais Yousef wrote:
> > > 
> > > Now I see that you have reused chrt concept of --pid. We keep it for
> > > chrt due to backward compatibility, but for new util it would be
> > > better to use standard 'required_argument' for --pid.
> > 
> > Hmm what does required mean here? --pid is optional. But if passed, a value
> > is required to be passed indeed.
> 
> It means a value required if --pid specified.
> 
> > > > +	static const struct option longopts[] = {
> > > > +		{ "all-tasks",		no_argument, NULL, 'a' },
> > > > +		{ "pid",		no_argument, NULL, 'p' },
> > > 
> > >  { "pid", required_argument, NULL, 'p' },
> > 
> > Assuming this means --pid must be followed by a value then indeed that's what
> > we expect to happen.
> 
>  Yes.
> 
> > will fix this and the 2 other occurrences below to include in v3.
> 
> You don't have to send it to the mailing list, juts update your
> github repo and I'll merge it :-) Thanks.

Thanks a lot Karel. Pushed a new uclampset-v3 branch so that you can easily
review the diff against v2 before merging.

Cheers

--
Qais Yousef
