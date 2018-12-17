Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC3CC43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A4520675
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeLQJnH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:43:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbeLQJnH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 04:43:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17C907AE81;
        Mon, 17 Dec 2018 09:43:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.118.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58A3B6012D;
        Mon, 17 Dec 2018 09:43:05 +0000 (UTC)
Date:   Mon, 17 Dec 2018 10:43:03 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Rick van Rein <rick@openfortress.nl>
Cc:     util-linux@vger.kernel.org
Subject: Re: PATCH: script: Introduced a streaming output command
Message-ID: <20181217094303.2il4cwbok2u5luld@ws.net.home>
References: <5C090B46.5090200@openfortress.nl>
 <20181210114634.ee5jamwllimdmrdc@ws.net.home>
 <5C0E7C8D.2030307@openfortress.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C0E7C8D.2030307@openfortress.nl>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Dec 2018 09:43:07 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Dec 10, 2018 at 03:47:41PM +0100, Rick van Rein wrote:
> Hi Karel,
> 
> >>  #define DEFAULT_TYPESCRIPT_FILENAME "typescript"
> >> +#define DEFAULT_TYPESCRIPT_COMMAND  "scriptstream"
> > 
> > Do we really need the default command? ;-) 
> 
> Trying without, but then users end up typing things like
> 
> script -s -- nc -q0 seashells.io 1337 | sed 's/$/\\r/'
> 
> There's a lot that can go wrong, and I would complain about that kind of

I think explain the basic concept and possible limits in man page is
good enough. The user has to understand what role the terminal plays 
in the session, how things are isolated and where it prints output.

We probably need to improve the man page and merge NOTES into
DESCRIPTION and be more verbose about all the details.

> interactive experimentation and required shell trickery.  That's why I
> proposed to capture these problems in a default command and issue
> 
> script -s

but in your patch the default command has been only hardcoded path to
non-existing binary. I don't think it resolves anything. I think we
can do the same in the man page ;-)

> Alternatively, we can expect users to wrap such complexity around script
> and invent their own little tools.  What --stream adds over piping is
> then limited, still better but to me it feels incomplete.  I haven't
> tested if it works at all, isatty() inside scripts and such.

Not sure if I fully understand here, but inside interactive script session 
isatty() works as expected as it's standard terminal.

> Your choice?

KISS - keep it simple and stupid :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
