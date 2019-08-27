Return-Path: <SRS0=xJlx=WX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3523C3A5A3
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749C1206BF
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfH0MqZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:46:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfH0MqY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Aug 2019 08:46:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1C30308339B;
        Tue, 27 Aug 2019 12:46:24 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06C18600D1;
        Tue, 27 Aug 2019 12:46:23 +0000 (UTC)
Date:   Tue, 27 Aug 2019 14:46:21 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: use env and support both unbuffer/stdbuf
Message-ID: <20190827124621.4vs4y2my2nrpc34v@10.255.255.10>
References: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
 <219cbcaeb173a07e97dbac8e1b653904369d91e0.1566907983.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219cbcaeb173a07e97dbac8e1b653904369d91e0.1566907983.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 27 Aug 2019 12:46:24 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 27, 2019 at 02:26:08PM +0200, Patrick Steinhardt wrote:
> Triggered by commit f612c4c67 (tests: fix --unbuffered mode with
> ASAN, 2019-08-27), which says:
> 
>     Well, this patch sucks. It would be nice to have things in
>     the way how it has been original expected by Patrick's patch,
>     but ...
> 
> So this commit here effectively reverts it and instead tries to
> improve the shortcomings of the original patch. First, it uses
> env(1) to set ASAN_OPTIONS instead of directly adding it to the
> args array to fix execution of "${args[@]}" "$@".

BTW, it's strange that ${args[@]} is interpreted in another way than
when we write "FOO=bar command" directly to the script. Sounds like
bash disadvantage.

> Second, it now supports both unbuffer(1) and stdbuf(1). The
> latter uses LD_PRELOAD tricks, which doesn't play nicely with
> ASAN, so it will not be used if ASAN has been requested. It's
> still valuable to have support for both, as many more systems
> will have stdbuf(1) from coreutils installed but not unbuffer(1)
> from expect.
> 
> ---
> 
> I wouldn't have minded, but as you state that your own patch
> sucks I thought my initial approach might be preferable and thus
> deemed it worthwhile to try and fix my original shortcomings.

OK, I'll try to play with it tomorrow :-)  Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
