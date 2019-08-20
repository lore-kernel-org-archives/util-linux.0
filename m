Return-Path: <SRS0=LZ/s=WQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C9C3A589
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 15:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934EC20C01
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 15:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHTPL6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:11:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfHTPL6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05D468980FD;
        Tue, 20 Aug 2019 15:11:58 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E7FC7E53;
        Tue, 20 Aug 2019 15:11:57 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     Patrick Steinhardt <ps@pks.im>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix closing of standard text streams for non-glibc system
References: <cover.1565800625.git.ps@pks.im>
        <20190819133619.dtn5ch2sdbme5zir@ws.net.home>
        <20190820131742.GB50493@ncase>
        <20190820150435.mbubnjyqbgdev45q@10.255.255.10>
Date:   Tue, 20 Aug 2019 17:11:55 +0200
In-Reply-To: <20190820150435.mbubnjyqbgdev45q@10.255.255.10> (Karel Zak's
        message of "Tue, 20 Aug 2019 17:04:35 +0200")
Message-ID: <87tvabna6c.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 20 Aug 2019 15:11:58 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

* Karel Zak:

> On Tue, Aug 20, 2019 at 03:17:42PM +0200, Patrick Steinhardt wrote:
>> On Mon, Aug 19, 2019 at 03:36:19PM +0200, Karel Zak wrote:
>> > On Wed, Aug 14, 2019 at 06:45:03PM +0200, Patrick Steinhardt wrote:
>> > > since commit 52aa1a661 (include/closestream: avoid close more
>> > > than once, 2019-06-13), util-linux fails to build on musl libc
>> > > based systems. The culprit here is that it introduced assignments
>> > > to stderr and stdout, while the C89 standard explicitly notes
>> > > that treating stderr and stdout as valid lvalues is not a
>> > > requirement for any conforming C implementation. musl libc
>> > > implemented these streams as `extern FILE *const`, and as a
>> > > result assigning to these variables causes compiler errors.
>> > 
>> > The question is if close() for stdout and stderr is the right way to
>> > go. 
>> > 
>> > In an ideal world it would be enough to use ferror()+fflush(),
>> > unfortunately for example NFS has never reached an ideal world and it
>> > requires fclose()... See
>> > 
>> >  https://lists.gnu.org/r/bug-gnulib/2019-04/msg00061.html
>> > 
>> > Florian (added to CC), also suggested to use dup3() for the
>> > descriptors and then fclose() for the new handle. It sounds like a
>> > pretty elegant solution how to avoid all the issues with NULL and it's
>> > also robust enough if you accidentally call close_stream() more than
>> > once.
>> > 
>> > See
>> > 
>> >  https://bugzilla.redhat.com/show_bug.cgi?id=1732450#c4
>> > 
>> > Maybe we can improve include/closestream.h to use dup3(), than it would
>> > be possible keep all in the header file as inline functions. 
>> > 
>> > Comments?
>> 
>> I honestly don't get why we'd need to use dup3(2), though.
>> Couldn't the same be achieved by using dup2(3P) followed by
>> close(3P), instead? Especially considering that the former one
>> isn't specified by POSIX, either, but the latter one is.
>
> Well, I guess Florian has used dup3() as example and I don't think we
> have to care about the flags (O_CLOEXEC)  as we close the descriptor
> in the same function. The important thing is to have descriptor which we
> can close to force filesystems to sync stuff :-)

Even in that case, dup3 would still be relevant to multi-threaded
programs.  I don't know about the context, it may not be relevant to
util-linux.

Thanks,
Florian
