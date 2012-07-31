Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61566 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab2GaKq1 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 Jul 2012 06:46:27 -0400
Received: by vbbff1 with SMTP id ff1so5587728vbb.19
        for <util-linux@vger.kernel.org>; Tue, 31 Jul 2012 03:46:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5017A673.2050902@bernhard-voelker.de>
References: <20120730212010.GA56766@rain.home> <5017A673.2050902@bernhard-voelker.de>
From: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Date: Tue, 31 Jul 2012 13:46:06 +0300
Message-ID: <CAPWNY8WgsNT_kNTu4jtfBga4Ry-mWzS09qQgW01TAMSMcgtFhA@mail.gmail.com>
Subject: Re: vipw does not work with some editors
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 31, 2012 at 12:33 PM, Bernhard Voelker
<mail@bernhard-voelker.de> wrote:
>
>
> On 07/30/2012 11:20 PM, Mantas M. wrote:
>> Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
>> save" in which the old file is deleted and a new one with the same name
>> created in its place.
>
> Why's that "atomic"?
> I see a race in between the unlink and the creat call.
> I'd tend to consider such editor mode "unlucky" for use with vipw.

Perhaps I picked the wrong name for it. Some other editors actually implement it
atomically using rename(). Meanwhile, Vim has three settings with at least 36
different combinations, some of which copy and overwrite, others
rename and recreate, etc.

I did find this paragraph in `:help crontab`, however:

						*'backupcopy'* *'bkc'*
'backupcopy' 'bkc'	string	(Vi default for Unix: "yes", otherwise: "auto")
	[snip]
							*crontab*
	One situation where "no" and "auto" will cause problems: A program
	that opens a file, invokes Vim to edit that file, and then tests if
	the open file was changed (through the file descriptor) will check the
	backup file instead of the newly created file.  "crontab -e" is an
	example.

Seems like I could :set bkc=yes and avoid this problem with `vipw`.

I don't know anymore if this is better fixed in vim or vipw...

-- 
Mantas Mikulėnas
