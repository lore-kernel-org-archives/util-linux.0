Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbbJ2Pci (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Oct 2015 11:32:38 -0400
Date: Thu, 29 Oct 2015 16:32:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Lennart Poettering <lennart@poettering.net>
Cc: Olaf Hering <olaf@aepfle.de>, util-linux@vger.kernel.org
Subject: Re: regression in logger output to syslog
Message-ID: <20151029153235.GD19508@ws.net.home>
References: <20151009082541.GA9068@aepfle.de>
 <20151012104414.GF2356@ws.net.home>
 <20151012133451.GA6825@aepfle.de>
 <20151021093743.GA6552@aepfle.de>
 <20151029103532.GC19508@ws.net.home>
 <20151029142021.GA9487@aepfle.de>
 <20151029143615.GA27684@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029143615.GA27684@gardel-login>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 29, 2015 at 03:36:16PM +0100, Lennart Poettering wrote:
> On Thu, 29.10.15 15:20, Olaf Hering (olaf@aepfle.de) wrote:
> > +                   && geteuid() == 0 && kill(ctl->pid, 0) == 0) {
> > 
> > For me its required to run logger as non-root and still get the
> > specified number, like it used to do it years ago.
> 
> Sorry, but this is something we are unlikely to support in
> systemd. Allowing unprivileged processes to fake arbitrary UIDs is
> a security problem, and it's really nothing we should provide support
> for.

I think the problem is how Olaf see the log (e.g. by journal -f),
because journal contains *both* (fake and real) PIDs:

as non-root:

 $ echo $PPID
 1550

 $ logger -p info --id=$PPID "This is message baby!"


in the log:

 # journalctl -n 1
 Oct 29 16:23:26 ws kzak[30917]: This is message baby!


 # journalctl --output json-pretty -n 1
 {
        "__CURSOR" : "s=bbb763e3c9a144809dfe81e768d5a062;i=272c4;b=4f6802931e38450fa2bfd5f549f5103d;m=2c1ada2db1;t=5233fe472ce01;x=aaadb4455972d31",
        "__REALTIME_TIMESTAMP" : "1446132206194177",
        "__MONOTONIC_TIMESTAMP" : "189429067185",
        "_BOOT_ID" : "4f6802931e38450fa2bfd5f549f5103d",
        "PRIORITY" : "6",
        "_UID" : "1000",
        "_GID" : "1000",
        "_MACHINE_ID" : "160952cecfb7413db963a880ce10c399",
        "_HOSTNAME" : "ws",
        "_TRANSPORT" : "syslog",
        "SYSLOG_FACILITY" : "1",
        "SYSLOG_IDENTIFIER" : "kzak",
        "_COMM" : "logger",
        "SYSLOG_PID" : "1550",
        "MESSAGE" : "This is message baby!",
        "_PID" : "30917",
        "_SOURCE_REALTIME_TIMESTAMP" : "1446132206193526"
 }


_PID is the real PID, SYSLOG_PID is what has been specified by --id on
logger command line.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
