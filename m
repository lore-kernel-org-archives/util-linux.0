Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E5C433F5
	for <util-linux@archiver.kernel.org>; Sun, 13 Feb 2022 18:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbiBMSd0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Feb 2022 13:33:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiBMSdZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Feb 2022 13:33:25 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030A57B12
        for <util-linux@vger.kernel.org>; Sun, 13 Feb 2022 10:33:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z16so3572199pfh.3
        for <util-linux@vger.kernel.org>; Sun, 13 Feb 2022 10:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aIs+r3xYvQJDuB7F1D6O5WQi3goSamh48kmqc1jAeBQ=;
        b=qayyGK0l92XcrEO43cp7+0RX69/8PRHKZM5VYBtxYzJaRepeLj1Y/nslgRL6buej79
         uJryNQOTlejVJwppWHQK/Vz/5plKxcXM3Y17wdtEI0hqmZ2N2Fy4UNx4eMan/wxBWlR/
         quGCP0OpiLkc1pP+uy+oL0RJhmrfHDn0nouk/QH9UDYTolaxVQJPmqRn6Ulb6JHnMVZ+
         ec6RjmXV1R3VNbRNEG8XWBaG/z7Mhza798McMbDLjyMqVvbr5fzASQmCn20Yqmkz2mZg
         1mdpYpO4Rj9IdmihXQaKfpaau54IjIxa5moqDolupyiGlhRR0diPSLaQxcD2dZERiNoI
         +8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aIs+r3xYvQJDuB7F1D6O5WQi3goSamh48kmqc1jAeBQ=;
        b=dby/Mw+jTwkZgkRZXOyeU7atZlyJQc0Z7/aO4HcL0BRp+MCvXWj3EXYTAb1ay9N2xb
         OrZMT1Je5bsjDanMKRPJG3MpioS/yVI9NNyqUswxyxVvw17iojn09WMNERZvoDd5PnuC
         tNVuGApIFPNKlsnIODSYPuCnxh4DYTJv4W1/2HEXpMULmN6haUsipYQ9BUKEgMmYRs0o
         DKbFLu1aeBfGZx+VJnqXWY6jpTO7Hoo+V5klQmgzRC0ZzqhwRlrHunotiEQvL+l5jAXN
         7LaDflv9thT/PMVWVrNhz1aCMJCOWPVNkbYxWY4wIvIMb8G1S5O0rXEYJTuxwdEYoOmr
         bJbw==
X-Gm-Message-State: AOAM533NuPGstYqLWUcw4dp2B+Jd/JwaI4qKjv/MtVOkDw4YWSmPY893
        zf9V+SPIYYDhXzwYHqp7Gm1qm0BUmKHFd9LQpNevL5b/2Cg=
X-Google-Smtp-Source: ABdhPJzls/NZi3Xdd1DB9jgGv6/Hxo8NR4di/kPMF5//vCUWc7dHPncPGVCBmD/7Otb2jItuvHKKWo/9gaILvPycevk=
X-Received: by 2002:a05:6a00:22cb:: with SMTP id f11mr10937299pfj.75.1644777198896;
 Sun, 13 Feb 2022 10:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20220210192341.GA23576@Debian-50-lenny-64-minimal> <20220210203542.GA25645@Debian-50-lenny-64-minimal>
In-Reply-To: <20220210203542.GA25645@Debian-50-lenny-64-minimal>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Sun, 13 Feb 2022 19:33:07 +0100
Message-ID: <CAHi0vA_7ZWjT=BY7Tc65N4sajBjkKd1LLbd1CmmYPWfgwWvg1A@mail.gmail.com>
Subject: Re: Errors in man pages of util-linux
To:     Helge Kreutzmann <debian@helgefjell.de>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

Am Do., 10. Feb. 2022 um 21:35 Uhr schrieb Helge Kreutzmann
<debian@helgefjell.de>:
>
> Hello all,
> On Thu, Feb 10, 2022 at 08:23:41PM +0100, Helge Kreutzmann wrote:
> > I will send the issues in individual mails (like last time), without
> > this header. This will be a total of 84 mails.
> >
> > I'll wait with sending for ~ 1 hour in case you would not like to have
> > them in those e-mails.
>
> Mario asked me to provide the issues, therefor I send them to him
> directly for handling.
>

I've fixed most of the issues in my Github fork; see pull request
#1601. However, there's something left (my comments are in brackets):

--
Man page: hexdump.1
Issue:    superfluous citation around markup

"Output characters in the default character set. Non-printing characters ar=
e "
"displayed as a single \\(aqB<.>\\(aq."

"Further output by such format strings is replaced by an equivalent number =
of "
"spaces. An equivalent number of spaces is defined as the number of spaces =
"
"output by an B<s> conversion character with the same field width and "
"precision as the original conversion character or conversion string but wi=
th "
"any \\(aqB<+>\\(aq, \\(aq \\(aq, \\(aqB<#>\\(aq conversion flag characters=
 "
"removed, and referencing a NULL string."

(I think it's better to keep the citation here to keep the dot apart
from the sentence ending, otherwise we get "..")
--
Man page: hwclock.8
Issue:    date-time =E2=86=92 date time??

"There are two types of date-time clocks:"

(We have lots of occurences of this "date-time" thing. Don't know
whether it's good English or bad English =E2=80=A6)
--
Man page: lsmem.1
Issue:    The first sentence is broken

"The B<lsmem> command lists a new memory range always when the current memo=
ry "
"block distinguish from the previous block by some output column. This "
"default behavior is possible to override by the B<--split> option (e.g., "
"B<lsmem --split=3DZONES>). The special word \"none\" may be used to ignore=
 all "
"differences between memory blocks and to create as large as possible "
"continuous ranges. The opposite semantic is B<--all> to list individual "

(Not sure what this means. I can't remember anymore why I wrote this
comment more than three years ago =E2=80=A6)
--
Man page: mount.8
Issue:    ftp://ftp.namesys.com/pub/reiserfsprogs does not allow login

"A remount option which permits online expansion of reiserfs partitions. "
"Instructs reiserfs to assume that the device has I<number> blocks. This "
"option is designed for use with devices which are under logical volume "
"management (LVM). There is a special I<resizer> utility which can be "
"obtained from"

(The link gives a 404 error. I found a similar tool in the kernel
wiki: https://reiser4.wiki.kernel.org/index.php/Resize_reiserfs)
--
Man page: scriptreplay.1
Issue:    output doesn't match the real output exactly

"% script --log-timing file.tm --log-out script.out\n"
"Script started, file is script.out\n"
"% ls\n"
"E<lt>etc, etcE<gt>\n"
"% exit\n"
--
Man page: setarch.8
Issue:    arch =E2=86=92 setarch?

"B<arch> [options] [I<program> [I<argument>...]]"

(Is "arch" still a synonym for "setarch"? With --help, I don't get "arch".)
----
Man page: unshare.1
Issue:    B<sleep> =E2=86=92 B<sleep>(1)

"The B<pidof>(1) command prints no output, because the B<sleep> processes "
"have been killed. More precisely, when the B<sleep> process that has PID 1=
 "
"in the namespace (i.e., the namespace\\(cqs init process) was killed, this=
 "
"caused all other processes in the namespace to be killed. By contrast, a "
"similar series of commands where the B<--kill-child> option is not used "
"shows that when B<unshare> terminates, the processes in the PID namespace =
"
"are not killed:"

(It's not about the "sleep" command, rather the processes; don't think it's
needed here to link to the man page.)
----

Your comments are welcome.

Best Regards,
Mario
