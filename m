Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E27C433DB
	for <util-linux@archiver.kernel.org>; Mon, 15 Mar 2021 19:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C07564F4A
	for <util-linux@archiver.kernel.org>; Mon, 15 Mar 2021 19:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhCOTaB convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Mar 2021 15:30:01 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:45946 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCOT3l (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 15 Mar 2021 15:29:41 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 12FJTZWb074209;
        Mon, 15 Mar 2021 12:29:38 -0700
Message-ID: <604FB5A1.3010404@tlinx.org>
Date:   Mon, 15 Mar 2021 12:29:37 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>
CC:     util-linux@vger.kernel.org
Subject: Re: is there a util, or can findmnt be enhanced...(RFE?)
References: <604A8111.8090100@tlinx.org> <20210312075543.jei3secawflwrw6b@ws.net.home> <604C4427.3040501@tlinx.org> <20210315110221.fpz66zkpwqp6ebva@ws.net.home>
In-Reply-To: <20210315110221.fpz66zkpwqp6ebva@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Sorry, thought this was something simple, but when I thought
about it I ended up with a few more details 😓

On 2021/03/15 04:02, Karel Zak wrote:
>  On Fri, Mar 12, 2021 at 08:48:39PM -0800, L A Walsh wrote:
> > Why does it
> > produce no output when a non-mount-point is entered?  I.e. -- is that
> > behavior something that is currently relied upon?
>
>  Do you mean the default output (when --target is not specified)?
>
>  The problem is that findmnt follows mount(8) behavior when search for
>  filesystem. It means you do not have to be explicit and you can use
>  source as well as target...
---
  Note: commenting from mount manpage:

|   For more robust and customizable output  use  findmnt(8),  espe-
|   cially  in  your  scripts.   Note that control characters in the
|   mountpoint name are replaced with '?'.
---
  I.e. "findmnt" was created because the behavior of 'mount' was
lacking. 😉   In 'mount', if you give a non-mount point, you get
mount's idea of useful:

  mount: /dev/sda: can't find in /etc/fstab
  mount /home/karel: can't find in /etc/fstab

  Since findmnt was created because the output of 'mount' is
lacking, findmnt shouldn't need to push off output to another
util because it, itself is lacking! 😟

Ex:
>  $ findmnt --target /dev/sda3
>  TARGET SOURCE   FSTYPE   OPTIONS
>  /dev   devtmpfs devtmpfs 
rw,nosuid,noexec,size=8144964k,nr_inodes=2036241,mode=755,inode64
----
    1st comment: unix philosophy, less is more: findmnt should only
list headers when asked for them.  Two reasons:  Since the output
doesn't fit on 1 line, it will be wrapped and will be confusing
for interactive use, and for script use -- they don't need it and
can adjust output for exactly what they want.  Usually, headers
need removing so data fields can be processed.

    2nd comment -- options should remain optional and not
listed by default (use --verbose to display all options).

    2a) default options should be suppressed by default (else
--expand-defaults could be used if really needed).  At most, display
'default' for an actual mountpoint (+ deltas from default)

   3rd comment -- don't truncate by default, but do allow
field width specifiers (%.20SOURCE\t %.30TARGET...).  To
truncate, maybe have -w[maxwidth], with default being screen
width if to tty?


>  now try to imagine --target is the default, you will get always any
>  answer for arbitrary path ... IMHO very confusing for many users.
---
  Honestly, isn't the default output likely confusing for many
users?  😉  Alternatively,

if device w/mount point, show:

# findmnt /dev/sdb
/dev/sdb1   [not] mounted on  /boot
# findmnt /boot
/dev/sdb1   [not] mounted on  /boot

(i.e. ^^ keep same behavior of allowing dev or /mntpnt)

if device w/no mountpoint in /etc/fstab, then same as 'mount':

# findmnt /dev/sda
findmnt: /dev/sda: can't find in /etc/fstab

if not device and not mountpoint (I'm not 100% certain about
the exact text, but something like):

# findmnt /boot/sbin/v86d
sbin/v86d   in /boot      (/dev/sdb1)
  -or-
/boot/[sbin/v86d]   on    /dev/sdb1

Or if format specified, for above 2:
# findmnt --format "%-40SUBPATH in TARGET\t(SOURCE)
# findmnt --format "TARGET/[SUBPATH]\ton\tSOURCE"


Having 'no output' for the default, is also a bit
confusing for users



>  I have doubts we can change this default behavior due to backward
>  compatibility (yes, the proper way how to use findmnt in scripts is to
>  use --target, --sources or --mountpoint, but people do not use it
>  ...).
---
  That's just the thing... who/what could be relying on "no output"?



>  It would be probably better to introduce a small new util "path2fs" to
>  get mountpoint (or source), but without any other findmnt functionality.
---
See comment about why findmnt was needed in the 1st place... 😁


>  We have mountpoint(1), but it returns TRUE/FALSE if the given path is
>  a mountpoint.
---

  Ya, sorta unrelated, but that's where "no output" might be
expected since it's only used for its return value, but I can't
see how findmnt would be similarly used...

*cheers*!
😱


