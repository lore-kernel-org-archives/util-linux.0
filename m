Return-Path: util-linux-owner@vger.kernel.org
Received: from albireo.enyo.de ([5.158.152.32]:45444 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbcJBNQG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 2 Oct 2016 09:16:06 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Karel Zak <kzak@redhat.com>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
References: <56D7409A.6050407@suse.cz>
        <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home>
        <56DEF7A4.4090209@suse.cz>
        <20160929144015.7cij7pbva3etcqeo@ws.net.home>
Date: Sun, 02 Oct 2016 15:16:00 +0200
In-Reply-To: <20160929144015.7cij7pbva3etcqeo@ws.net.home> (Karel Zak's
        message of "Thu, 29 Sep 2016 16:40:15 +0200")
Message-ID: <87vaxaao33.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Karel Zak:

> I have applied patch based on libseccomp syscall filter:
>
>    https://github.com/karelzak/util-linux/commit/8e4925016875c6a4f2ab4f833ba66f0fc57396a2
>
> it works as expected, but IMHO it's workaround for our stupid kernel...

How does this work?

Isn't it possible to pass the descriptor to another, unrestricted
process (perhaps spawned from cron) and then run the ioctl from there?

I'd also be concerned that the seccomp filters keep stacking up if you
do it this way.
