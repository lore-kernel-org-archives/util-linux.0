Return-Path: <SRS0=Xth9=23=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8531EC32771
	for <util-linux@archiver.kernel.org>; Mon,  6 Jan 2020 10:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4582072C
	for <util-linux@archiver.kernel.org>; Mon,  6 Jan 2020 10:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5A6A+ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAFKxD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:53:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53096 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbgAFKxD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Jan 2020 05:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578307982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nutLL9cl16bOhXVOP8fyYAoEnFe2ZaFJVYE1+depOWM=;
        b=K5A6A+yeFXNPiWCGQdPl9pARGHmDcSM9D3FyjYRcjjznqw+W8e1JzHeg5XaBXNMbJLfTfl
        ST6tPLJ9CLMkvxVTYoxliJQNDAA4IxmdlWxs0CdXOm4o8tauZEzzTuJFjNy3h4/cvTSJL8
        12/MKXwRYSOvAH0TnyqToGYwcQKZUkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-b6wKHrooN-ODkcd49US0iw-1; Mon, 06 Jan 2020 05:53:01 -0500
X-MC-Unique: b6wKHrooN-ODkcd49US0iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E393210054E3;
        Mon,  6 Jan 2020 10:52:59 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 037EC5D9E5;
        Mon,  6 Jan 2020 10:52:58 +0000 (UTC)
Date:   Mon, 6 Jan 2020 11:52:56 +0100
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [Phishing Risk] [External] irqtop todo note
Message-ID: <20200106105256.3phh5bdgs4qgqzpp@10.255.255.10>
References: <CAG27Bk0x4LZJSb-0PXKR8VLTmoPiZdKBPtfB4N2HPnPjxbrSKQ@mail.gmail.com>
 <3e1bf9df-b530-738b-fc7f-00e4cf144420@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1bf9df-b530-738b-fc7f-00e4cf144420@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jan 05, 2020 at 11:36:26AM +0800, zhenwei pi wrote:
> On 1/4/20 6:20 PM, Sami Kerola wrote:
> 
> > Hello,
> > 
> > I notice irqtop to todo file, so I decided to look into that. Changes
> > in my branch are nowhere near ready to be considered to upstream
> > ready, so no pull request yet maybe sometime later January or early
> > February. Meanwhile if someone else is working with the same I'm sure
> > efforts can be combined.
> > 
> > https://github.com/kerolasa/util-linux/commits/irqtop
> > 
> > Things to fix with my work.
> > 
> > * Save git history from https://github.com/pacepi/irqtop
> > * Write proper commit messages
> > * Use smartcolums
> > * Change output header to include hostname and iso timestamp
> > * Use signalfd to catch signals
> > * Use timerfd  for periodic execution
> > * Make main() shorter / simpler by moving bits and bobs to functions
> > * And the things I don't know yet, but without doubt there will be some
> > 
> Thanks for these works. Maybe it's ready to be merged into upstream.
> Hey, Karel, how do you think about this?

Later, for v2.35 is too late ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

