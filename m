Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718C3C3A5A3
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2822CEC
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 11:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfHWLwS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:52:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393337AbfHWLwR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 07:52:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 943C23083392;
        Fri, 23 Aug 2019 11:52:17 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EAA8600CD;
        Fri, 23 Aug 2019 11:52:15 +0000 (UTC)
Date:   Fri, 23 Aug 2019 13:52:13 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH 0/4] Fix closing of standard text streams for non-glibc
 system
Message-ID: <20190823115213.wkrwcxnru2hzbz2a@10.255.255.10>
References: <cover.1565800625.git.ps@pks.im>
 <20190819133619.dtn5ch2sdbme5zir@ws.net.home>
 <20190820131742.GB50493@ncase>
 <20190820150435.mbubnjyqbgdev45q@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820150435.mbubnjyqbgdev45q@10.255.255.10>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 23 Aug 2019 11:52:17 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 20, 2019 at 05:04:39PM +0200, Karel Zak wrote:
> On Tue, Aug 20, 2019 at 03:17:42PM +0200, Patrick Steinhardt wrote:
> > That being said, if we agree on a proper fix here then I'd be
> > happy to post a v2.
> 
> Go ahead.

Note that Bernhard Voelker sent me (off list, but thanks;-) another to
link the original coreutils discussion:

 https://lists.gnu.org/archive/html/bug-gnulib/2019-05/msg00156.html

where is something about close() and dup(). My note:

It seems there is no ideal solution which is portable and reliable
on all platforms (kernels).  

The current solution with std{out,err} close is also not elegant as the 
close makes it useless with things like ASAN or another built-in debuggers,
and it's incompatible with some libc.

The question is what does it mean for util-linux. I don't think we
need 100% reliability on all platforms; the primary target is Linux,
commonly used filesystems, standard use-cases and code (=!behavior)
portability -- everything else is bonus. From this point of view
dup()+close() sounds like better than the current solution.

From my point of view all this game with the streams is just a way how
to detect some basic users' mistakes. I don't think we can detect
serious I/O errors without fsync(), and close() itself does not
guarantee anything. So, it does not make sense trying to make it
super durable, reliable and portable to all operation systems if at
the end you rely on poor close() ...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
