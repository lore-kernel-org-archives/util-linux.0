Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64622 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771Ab1ANPpr convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 14 Jan 2011 10:45:47 -0500
Received: by bwz15 with SMTP id 15so2635846bwz.19
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2011 07:45:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110114142012.GA26786@alittletooquiet.net>
References: <AANLkTimJJDm-9vu_xcMjh0uQSghZE44Miz1XaHcx=p7j@mail.gmail.com> <20110114142012.GA26786@alittletooquiet.net>
From: =?UTF-8?B?UHJ6ZW15c8WCYXcgJ1ByemVtb2MnIFBhd2XFgmN6eWs=?=
	<przemoc@gmail.com>
Date: Fri, 14 Jan 2011 16:45:22 +0100
Message-ID: <AANLkTikuZY9D6R4BQxDmM68Be=sAmC8FtEUdFrbEptXj@mail.gmail.com>
Subject: Re: sfdisk enhancement proposal - offset/shift support
To: Forest Bond <forest@alittletooquiet.net>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

2011/1/14 Forest Bond <forest@alittletooquiet.net>:
> On Fri, Jan 14, 2011 at 02:31:55PM +0100, Przemysław 'Przemoc' Pawełczyk wrote:
>> I have following suggestion for sfdisk:
>> - adding offset/shift support for cumbersome raw disk images (like
>> fixed-size VDI), that don't start at the beginning of the file.
>>
>> Required changes?
>> IMO straightforward way is just adding another option (below is an
>> example), global variable (e.g. shift) and fixing sseek() code and
>> R.total_size in get_geometry() to take it into account.
>>
>>     -t# [or --offset #]  ignore the number of bytes at the beginning
>
> Isn't this something you can just use a loopback device for?
>
>  losetup -f -o $offset $image

To some degree -- yes. It requires BLK_DEV_LOOP (Loopback device
support) built-in in the kernel or compiled as a module though. This
is IMHO unneeded kernel dependency that can be avoided.

Regards.

P.S. mount() and umount() should have their own capability, because
requiring CAP_SYS_ADMIN is pretty insane. But it's not the scope of
this ML.

-- 
Przemysław 'Przemoc' Pawełczyk
http://przemoc.net/
