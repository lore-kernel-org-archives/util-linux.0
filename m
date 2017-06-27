Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20449 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752836AbdF0M25 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jun 2017 08:28:57 -0400
Date: Tue, 27 Jun 2017 14:28:52 +0200
From: Karel Zak <kzak@redhat.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 5/8] sys-utils/mount.8: Drop systemd paragraph from
 x-* entry
Message-ID: <20170627122852.cxhcaaiqdzvrxpvd@ws.net.home>
References: <cover.1498252231.git.wking@tremily.us>
 <f6bcd3c58828ee2b3e321d6c3c0b6f002c63d400.1498252231.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6bcd3c58828ee2b3e321d6c3c0b6f002c63d400.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 23, 2017 at 02:30:23PM -0700, W. Trevor King wrote:
> Removing the second paragraph from the x-* entry in favor of a "since
> util-linux v2.30" parenthetical.  While the motivation for the
> userspace storage is interesting, it's covered in more detail in the
> 0a14cc8b (libmount: revert X-* and x-* meaning, 2016-12-09) commit
> message.
> 
> For example, the "keep existing fstab configurations usable" wording
> I'm removing was a bit confusing, because fstabs using x-* and
> expecting the options to be preserved in userspace were broken before
> util-linux v2.30.  The clearer language from 0a14cc8b's commit message
> is:
> 
>   The systemd and dracut users will get the new (=fixed) functionality
>   without a change in fstab configuration.
> 
> It's not clear to me if there was an earlier version of util-linux
> that also preserved x-* options.  Without that, the existing fstabs
> using x-* and intending to have the options preserved *become* usable
> with v2.30; they weren't usable before.

Before v2.30 the options x-* has been interpreted as pure comment, it
means not stored in userspace (and not available for umount). 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
