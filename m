Return-Path: <SRS0=qI5U=TW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3787C282CE
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CDF208C3
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 13:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfEVNzP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 May 2019 09:55:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfEVNzO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 22 May 2019 09:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E7AB21BA4;
        Wed, 22 May 2019 13:55:14 +0000 (UTC)
Received: from ws.net.home (ovpn-204-64.brq.redhat.com [10.40.204.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE685B2D7;
        Wed, 22 May 2019 13:55:13 +0000 (UTC)
Date:   Wed, 22 May 2019 15:55:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     L A Walsh <lkml@tlinx.org>, util-linux@vger.kernel.org
Subject: Re: Using the upcoming fsinfo()
Message-ID: <20190522135510.cpd2abfddfgmqzhb@ws.net.home>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
 <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
 <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
 <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
 <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
 <5CE44FA5.9000700@tlinx.org>
 <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
 <5CE4CFEF.5020100@tlinx.org>
 <562668febcf41e61ab2477235ee7ce4610bc1e8d.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <562668febcf41e61ab2477235ee7ce4610bc1e8d.camel@themaw.net>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 22 May 2019 13:55:14 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 22, 2019 at 09:14:37PM +0800, Ian Kent wrote:
> On Tue, 2019-05-21 at 21:28 -0700, L A Walsh wrote:
> > On 2019/05/21 19:59, Ian Kent wrote:
> > > I hadn't planned on producing a utility but I do have code that I've
> > > been using to learn how to use the call.
> > > 
> > > I could turn that into a utility for use from scripts at some point.
> > >   
> > 
> > ---
> >      not required, but thought it might allow for more types of
> > tests/usages.
> > If it is really of limited or no benefit, I'm not gonna lose sleep.
> > > Avoiding having to parse string output (from the proc file system
> > > mount tables) is one of the key reasons to use a system call for
> > > this.
> > > 
> > > So this isn't the point of doing it.
> > >   
> > 
> > I get that....this wasn't intended as an 'endpoint' just a way for those
> > not
> > implementing and using the calls to get a feel for the call.Â  It may
> > not serve
> > a useful purpose in this case, but some system calls have direct
> > user-utils that
> > are very useful.Â  The lack of a system util to manipulate the pty calls
> > forced
> > me to write a few-line 'C' prog just to make 1 call to approve
> > something.Â  Eventually switched to a more robust interface in perl.
> 
> We will see, I will end up with something that's more or less example
> usage anyway.

I'd like to write something like "mountsh" one day. The idea is to
have very low-level tool that is able to provide command line
interface to the all fragments of the new mount API in the same
granularity as provided by kernel (mount(8) is too high-level in this
case).

Anyway, the primary goal is to use the new syscalls on standard
places (e.g. libmount) where it improves performance.

> > I.e. why not subdirs for 'by-mountpoint', or by-device, or
> > whole-dev-vs.partition, or by UUID....like some things are listed
> > in /dev.  That would allow you to narrow in on the mount you want for
> > doing whatever.
> 
> TBH, I can't see that amount of code being added to the VFS
> for this.
> 
> Simple annoyances like some mounts won't have a UUID, or won't
> have partition devices associated with them will also cause
> inconsistent views of the mounts.

or more filesystems mounted on the same mountpoint, mountpoint is
deleted, etc...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
