Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:41378 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2GaLdQ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 Jul 2012 07:33:16 -0400
Received: by weyx8 with SMTP id x8so4257606wey.19
        for <util-linux@vger.kernel.org>; Tue, 31 Jul 2012 04:33:15 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAPWNY8WgsNT_kNTu4jtfBga4Ry-mWzS09qQgW01TAMSMcgtFhA@mail.gmail.com>
References: <20120730212010.GA56766@rain.home>
	<5017A673.2050902@bernhard-voelker.de>
	<CAPWNY8WgsNT_kNTu4jtfBga4Ry-mWzS09qQgW01TAMSMcgtFhA@mail.gmail.com>
Date: Tue, 31 Jul 2012 13:33:15 +0200
Message-ID: <CAG27Bk2TU_xvT8sY8RpncqGX92UGG_uGxaM-GJk4oQ2SN2gpZA@mail.gmail.com>
Subject: Re: vipw does not work with some editors
From: Sami Kerola <kerolasa@iki.fi>
To: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 31, 2012 at 12:46 PM, Mantas Mikulėnas <grawity@gmail.com> wrote:
> On Tue, Jul 31, 2012 at 12:33 PM, Bernhard Voelker
> <mail@bernhard-voelker.de> wrote:
>>
>>
>> On 07/30/2012 11:20 PM, Mantas M. wrote:
>>> Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
>>> save" in which the old file is deleted and a new one with the same name
>>> created in its place.
>>
>> Why's that "atomic"?
>> I see a race in between the unlink and the creat call.
>> I'd tend to consider such editor mode "unlucky" for use with vipw.
>
> Perhaps I picked the wrong name for it. Some other editors actually implement it
> atomically using rename(). Meanwhile, Vim has three settings with at least 36
> different combinations, some of which copy and overwrite, others
> rename and recreate, etc.
>
> I did find this paragraph in `:help crontab`, however:
>
>                                                 *'backupcopy'* *'bkc'*
> 'backupcopy' 'bkc'      string  (Vi default for Unix: "yes", otherwise: "auto")
>         [snip]
>                                                         *crontab*
>         One situation where "no" and "auto" will cause problems: A program
>         that opens a file, invokes Vim to edit that file, and then tests if
>         the open file was changed (through the file descriptor) will check the
>         backup file instead of the newly created file.  "crontab -e" is an
>         example.
>
> Seems like I could :set bkc=yes and avoid this problem with `vipw`.
>
> I don't know anymore if this is better fixed in vim or vipw...

Perhaps the vipw could check hard link count to open file handle. If
hard link count is zero vipw code should stat(), and inform user a
file with similar path, was put in place of passwd. That might make
vim backupcopy to work, but might also cause some sort of security
issue. At least in theory one could replace temporary file with
malicious copy while root is editing (although that requires root
permissions to begin with, which makes this exploit a bit dumb).

BTW I have some time management challenges at the moment, so I leave
implementing that for later (or someone quicker than me).

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
