Return-Path: <SRS0=DPLT=WP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FB6C3A5A0
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 13:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55E32085A
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 13:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHSNgX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfHSNgW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Aug 2019 09:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAC7A81F1B;
        Mon, 19 Aug 2019 13:36:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0E37831B3;
        Mon, 19 Aug 2019 13:36:21 +0000 (UTC)
Date:   Mon, 19 Aug 2019 15:36:19 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 0/4] Fix closing of standard text streams for non-glibc
 system
Message-ID: <20190819133619.dtn5ch2sdbme5zir@ws.net.home>
References: <cover.1565800625.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565800625.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 19 Aug 2019 13:36:22 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Aug 14, 2019 at 06:45:03PM +0200, Patrick Steinhardt wrote:
> since commit 52aa1a661 (include/closestream: avoid close more
> than once, 2019-06-13), util-linux fails to build on musl libc
> based systems. The culprit here is that it introduced assignments
> to stderr and stdout, while the C89 standard explicitly notes
> that treating stderr and stdout as valid lvalues is not a
> requirement for any conforming C implementation. musl libc
> implemented these streams as `extern FILE *const`, and as a
> result assigning to these variables causes compiler errors.

The question is if close() for stdout and stderr is the right way to
go. 

In an ideal world it would be enough to use ferror()+fflush(),
unfortunately for example NFS has never reached an ideal world and it
requires fclose()... See

 https://lists.gnu.org/r/bug-gnulib/2019-04/msg00061.html

Florian (added to CC), also suggested to use dup3() for the
descriptors and then fclose() for the new handle. It sounds like a
pretty elegant solution how to avoid all the issues with NULL and it's
also robust enough if you accidentally call close_stream() more than
once.

See

 https://bugzilla.redhat.com/show_bug.cgi?id=1732450#c4

Maybe we can improve include/closestream.h to use dup3(), than it would
be possible keep all in the header file as inline functions. 

Comments?

> Attached is a fix for this. Instead of assigning `NULL` to the
> streams, util-linux now uses a static variable `streams_closed`.

I don't think we need to check if we already performed this operation
as it's always called only once by atexit() and with dup3() it will be
robust enough.

> Unfortunately, this fix necessitated some shifting around as
> closestream was previously implemented as header, only, and
> implementing static variables inside of a header is not going to
> work due to them being static to the single compilation unit,
> only. Thus I converted the code to move the implementation into
> "lib/closestream.c".

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
