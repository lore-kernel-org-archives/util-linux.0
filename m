Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbdJBKDG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 06:03:06 -0400
Date: Mon, 2 Oct 2017 12:03:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] losetup: Add support for logical block size
Message-ID: <20171002100302.n7cckjml5vj72cyt@ws.net.home>
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
 <20170927124130.774g7kysxbdlc2wv@ws.net.home>
 <e5377128-622b-5c01-bfa8-2cbbacd513f2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e5377128-622b-5c01-bfa8-2cbbacd513f2@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 27, 2017 at 02:48:11PM +0200, Stanislav Brabec wrote:
> Karel Zak wrote:
> > Merged (with fixed get() function).
> > 
> > I'm not sure about the "BLOCKSIZE" column name. For lsblk we use
> > "LOG-SEC" (and "PHY-SEC"), it seems more explicit and shorter. What
> > about to use the same column name for losetup too? From my point of
> > view "BLOCKSIZE" is too vague it would be nice to minimize differences
> > in terminology used by the tools (losetup and lsblk).
> 
> It makes sense.
> 
> > Maybe we can also rename "--logical-blocksize" to "--log-sector".
> > 
> Maybe. But --log-* can associate logging. What about --logical-size or
> --sector-size or only --sectors?

OK, renamed to LOG-SEC and to --sector-size. We already use --sector-size
for fdisk and I guess we will never see configurable physical sector
size for loop devices.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
