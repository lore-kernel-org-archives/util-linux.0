Return-Path: <SRS0=LZ/s=WQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242E4C3A589
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 15:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A2822DA9
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfHTPEj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfHTPEj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Aug 2019 11:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FEB218C8903;
        Tue, 20 Aug 2019 15:04:39 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 405285C541;
        Tue, 20 Aug 2019 15:04:38 +0000 (UTC)
Date:   Tue, 20 Aug 2019 17:04:35 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 0/4] Fix closing of standard text streams for non-glibc
 system
Message-ID: <20190820150435.mbubnjyqbgdev45q@10.255.255.10>
References: <cover.1565800625.git.ps@pks.im>
 <20190819133619.dtn5ch2sdbme5zir@ws.net.home>
 <20190820131742.GB50493@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131742.GB50493@ncase>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Tue, 20 Aug 2019 15:04:39 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 20, 2019 at 03:17:42PM +0200, Patrick Steinhardt wrote:
> On Mon, Aug 19, 2019 at 03:36:19PM +0200, Karel Zak wrote:
> > On Wed, Aug 14, 2019 at 06:45:03PM +0200, Patrick Steinhardt wrote:
> > > since commit 52aa1a661 (include/closestream: avoid close more
> > > than once, 2019-06-13), util-linux fails to build on musl libc
> > > based systems. The culprit here is that it introduced assignments
> > > to stderr and stdout, while the C89 standard explicitly notes
> > > that treating stderr and stdout as valid lvalues is not a
> > > requirement for any conforming C implementation. musl libc
> > > implemented these streams as `extern FILE *const`, and as a
> > > result assigning to these variables causes compiler errors.
> > 
> > The question is if close() for stdout and stderr is the right way to
> > go. 
> > 
> > In an ideal world it would be enough to use ferror()+fflush(),
> > unfortunately for example NFS has never reached an ideal world and it
> > requires fclose()... See
> > 
> >  https://lists.gnu.org/r/bug-gnulib/2019-04/msg00061.html
> > 
> > Florian (added to CC), also suggested to use dup3() for the
> > descriptors and then fclose() for the new handle. It sounds like a
> > pretty elegant solution how to avoid all the issues with NULL and it's
> > also robust enough if you accidentally call close_stream() more than
> > once.
> > 
> > See
> > 
> >  https://bugzilla.redhat.com/show_bug.cgi?id=1732450#c4
> > 
> > Maybe we can improve include/closestream.h to use dup3(), than it would
> > be possible keep all in the header file as inline functions. 
> > 
> > Comments?
> 
> I honestly don't get why we'd need to use dup3(2), though.
> Couldn't the same be achieved by using dup2(3P) followed by
> close(3P), instead? Especially considering that the former one
> isn't specified by POSIX, either, but the latter one is.

Well, I guess Florian has used dup3() as example and I don't think we
have to care about the flags (O_CLOEXEC)  as we close the descriptor
in the same function. The important thing is to have descriptor which we
can close to force filesystems to sync stuff :-)

> That being said, if we agree on a proper fix here then I'd be
> happy to post a v2.

Go ahead.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
