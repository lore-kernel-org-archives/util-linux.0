Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdFOKJH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 06:09:07 -0400
Date: Thu, 15 Jun 2017 12:09:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Alex Ivanov <yourbestfriend@openmailbox.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: prefer earlier mounted filesystems
Message-ID: <20170615095457.dqfrwzyb4va4zqrw@ws.net.home>
References: <20170615082625.11219-1-yourbestfriend@openmailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615082625.11219-1-yourbestfriend@openmailbox.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 15, 2017 at 11:26:25AM +0300, Alex Ivanov wrote:
> fstrim --all is broken in a way that if there is a bind mount for some filesystem, 
> that filesystem will not be trimmed. This is especially critical for e.g. 
> NixOS distribution, which needs bind mount within root fs: 
> https://github.com/NixOS/nixos/blob/master/modules/system/boot/stage-2-init.sh#L55
> 
> Currently for a given filesystem during "de-duplication by source and root" phase,
> an early mounted fs path is filtered (e.g. "/"), while later mounted fs path is kept 
> (e.g. "/nix/store") though anyway discarded later (since it's an overlaying mount). 
> This leads to skipped trimming.
> 
> So flip this behaviour. Should also help for other types of overlaying mounts.

Seems good (for mountpoints we need de-duplication in backward way,
but for sources it seems like a good solution). Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
