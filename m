Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.103]:40532 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbaKWUJI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 23 Nov 2014 15:09:08 -0500
Message-ID: <54723AE9.9030905@zoho.com>
Date: Sun, 23 Nov 2014 20:52:09 +0100
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Joshua Rogers <megamansec@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: off-by-one issues in login-utils
References: <54703C81.7000902@gmail.com>
In-Reply-To: <54703C81.7000902@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22/11/14 08:34, Joshua Rogers wrote:
> Hi,
>
> I've noticed a few off-by-one issues in login-utils..
>
> login.c:963: strncpy(ut.ut_user, username, sizeof(ut.ut_user));
> It should be sizeof(ut.ut_user) - 1.
> Or, something like
> ut.ut_user[sizeof(ut.ut_user) -1] = '\0';
>
>
> And on line 275:
>
>          memset(&ut, 0, sizeof(ut));
>
>          strncpy(ut.ut_user, username ? username : "(unknown)",
>                  sizeof(ut.ut_user));
>
> I can't see anywhere that adds the final NUL-byte to ut.ut_user.
> If I've missed something though, feel free to ignore this.
>
> Thanks,

It's not needed. The reader of utmp(5) shall read up to 
sizeof(ut.ut_user) bytes.

 From utmp(5):
> String fields are terminated by a null byte ('\0') if they are
> shorter than the size of the field.

Thus it is allowed to have non-NUL-terminated fields on the file.

