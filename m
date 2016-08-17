Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48230 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbcHQMrz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2016 08:47:55 -0400
Date: Wed, 17 Aug 2016 14:47:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/8] losetup: re-use loop device
Message-ID: <20160817124741.hwsm2nqdedjywd24@ws.net.home>
References: <aaabe320-5552-8963-4143-989e63ae3833@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aaabe320-5552-8963-4143-989e63ae3833@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 02, 2016 at 07:55:03PM +0200, Stanislav Brabec wrote:
> Here is a patch set that is based on a "safe implementation of loop
> reuse" patch set sent three weeks ago.
> 
> It addresses the same loop device issues in losetup.
> 
> Issues not addressed:
> Calling losetup twice still fails (and it is probably correct):
> losetup /dev/loop0 loop.img
> losetup /dev/loop0 loop.img
> 
> "[PATCH 6/8] losetup: Prevent rare detach race" needs a careful review,
> as I don't have a test case for it. It is even possible to skip it. It
> addresses a theoretical race problem:
> 
> LOOPDEV=$(losetup -f --show loop.img)
> losetup -d $LOOPDEV
> sleep {a very special amount of time}
> losetup -f --show loop.img

I have merged this feature, but it's not enabled by default. You have
to use --nooverlap

    losetup --find --nooverlap file.img

or

    losetup --nooverlap /dev/loopN file.img


The man page has been also updated to make it more obvious for users
that --nooverlap is a good idea.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
