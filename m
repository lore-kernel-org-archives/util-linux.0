Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752160AbdI0Mle (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 27 Sep 2017 08:41:34 -0400
Date: Wed, 27 Sep 2017 14:41:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] losetup: Add support for logical block size
Message-ID: <20170927124130.774g7kysxbdlc2wv@ws.net.home>
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 26, 2017 at 04:14:51PM +0200, Stanislav Brabec wrote:
>  include/loopdev.h   |  4 ++++
>  lib/loopdev.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++
>  sys-utils/losetup.8 |  3 +++
>  sys-utils/losetup.c | 55 ++++++++++++++++++++++++++++++++++++++++-------------
>  4 files changed, 95 insertions(+), 13 deletions(-)

Merged (with fixed get() function).

I'm not sure about the "BLOCKSIZE" column name. For lsblk we use
"LOG-SEC" (and "PHY-SEC"), it seems more explicit and shorter. What
about to use the same column name for losetup too? From my point of
view "BLOCKSIZE" is too vague it would be nice to minimize differences
in terminology used by the tools (losetup and lsblk).

Maybe we can also rename "--logical-blocksize" to "--log-sector".

Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
