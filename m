Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdFFQDW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Jun 2017 12:03:22 -0400
Date: Tue, 6 Jun 2017 18:03:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: L A Walsh <lkml@tlinx.org>, util-linux@vger.kernel.org
Subject: Re: Bug: mount doing bad security check: only root can use -types,
 (effective EUID is 5013)
Message-ID: <20170606160302.5fhtqpbak65g2xqw@ws.net.home>
References: <5935E44B.8000405@tlinx.org>
 <20170606093607.xrxel4ny4hjoe4iv@ws.net.home>
 <5936B8E5.8050901@tlinx.org>
 <5936C623.4030205@tlinx.org>
 <1496762476.3406840.1000540040.654CDA1A@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496762476.3406840.1000540040.654CDA1A@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 06, 2017 at 05:21:16PM +0200, Tilman Schmidt wrote:
> What does "ls -l /bin/mount" say?
> Is its owner the user with UID 5013, by any chance?

Yes, sounds like executed by root, but suid to non-root.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
