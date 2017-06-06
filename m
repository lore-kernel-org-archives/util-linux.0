Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49457 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751399AbdFFPVW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Jun 2017 11:21:22 -0400
Message-Id: <1496762476.3406840.1000540040.654CDA1A@webmail.messagingengine.com>
From: Tilman Schmidt <tilman@imap.cc>
To: L A Walsh <lkml@tlinx.org>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: Bug: mount doing bad security check: only root can use -types,
 (effective EUID is 5013)
References: <5935E44B.8000405@tlinx.org>
 <20170606093607.xrxel4ny4hjoe4iv@ws.net.home>
 <5936B8E5.8050901@tlinx.org> <5936C623.4030205@tlinx.org>
In-Reply-To: <5936C623.4030205@tlinx.org>
Date: Tue, 06 Jun 2017 17:21:16 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

What does "ls -l /bin/mount" say?
Is its owner the user with UID 5013, by any chance?

On Tue, Jun 6, 2017, at 17:11, L A Walsh wrote:
> L A Walsh wrote:
> >
> >    But my EUID isn't 5013 ("LOGINUID" is). That's the complaint/bug.
> ---
> FWIW, I display them in perl, and they also show 0/0:
>  sudo bash -c 'perl -e "use P;P \"UID=$<, EUID=$>\""; /bin/mount devpts 
> /tmp/mnt -t devpts'   
> UID=0, EUID=0
> mount: only root can use "--types" option (effective UID is 5013)
> 
> I.e. both bash & perl show UID/EUID being 0 before I call mount.
> I don't get it.
> 
> I looked at mount's src-code, and have no idea why it's not
> returning the right value.

-- 
Tilman Schmidt
tilman@imap.cc
