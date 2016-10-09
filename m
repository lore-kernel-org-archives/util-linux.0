Return-Path: util-linux-owner@vger.kernel.org
Received: from albireo.enyo.de ([5.158.152.32]:38698 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbcJILJe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 9 Oct 2016 07:09:34 -0400
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
        <87vaxaao33.fsf@mid.deneb.enyo.de>
        <20161003102830.mczd6omz6lqftrzy@ws.net.home>
        <20161003132918.lkgiqv2oejtuy6xo@ws.net.home>
Date: Sun, 09 Oct 2016 13:09:28 +0200
In-Reply-To: <20161003132918.lkgiqv2oejtuy6xo@ws.net.home> (Karel Zak's
        message of "Mon, 3 Oct 2016 15:29:18 +0200")
Message-ID: <87wphhhj87.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Karel Zak:

>  I have tried to send tty FD to another process by unix socket and the 
>  ioctl result is EPERM. See the test_tiocsti below. It seems only root
>  can do it (try suid the test program).
>
>  session A:
>     ./test_tiocsti --receive

I think the recipient has to give up its controlling terminal, become
a session leader, and then reopen the passed terminal (from
/proc/self/fd, if it's not reachable from /dev/pts).  This way, you
should be able to do away with the root requirement.

>  session B:
>     runuser -u kzak -- ./test_tiocsti --send
>
>>  The ioctl should be fired in the hell... :-)
>
>  This is still true.

The kernel implementation doesn't even do error checking.  Surely it
can fail if there isn't enough memory in the destination buffer ...
