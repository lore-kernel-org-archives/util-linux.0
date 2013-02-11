Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f52.google.com ([74.125.83.52]:56229 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760000Ab3BKXX0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Feb 2013 18:23:26 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so3422966eek.39
        for <util-linux@vger.kernel.org>; Mon, 11 Feb 2013 15:23:25 -0800 (PST)
Message-ID: <51197D69.6050901@gmail.com>
Date: Tue, 12 Feb 2013 01:23:21 +0200
From: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: lslocks =?UTF-8?B?4oCTICJmYWlsZWQgdG8gcGFyc2UgcGlkOiAnV1JJVEU=?=
 =?UTF-8?B?JyI=?=
References: <kf0ehe$q7h$1@ger.gmane.org> <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
In-Reply-To: <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2013-02-12 00:42, Sami Kerola wrote:
> Karel, and others, what do you think about adding a mode
> to output listing which some might say is not a mode at all?

Just tested the patch and it works here, but wouldn't it be better to
add a "waiting" flag to the mode display, or something like that?
("WAIT-READ" and "WAIT-WRITE"?)



Side note: It seems that fs/locks.c:lock_get_status can output many
other variations – e.g. mandatory locks have a third type called
"ACCESS", shown when a program tries to simply read/write a locked file;
in this case listing the R/W mode might be more useful than "WAITING".
Mandatory locks can apparently say "RW" as well, although I haven't
found a way to create a "RW" lock yet.

Also, while I haven't yet seen this in practice either, the same
fs/locks.c can output lock type "LEASE", which has completely different
values for the 3rd field, and cannot be represented by a binary
"M[andatory] = 0/1" column.

-- 
Mantas Mikulėnas <grawity@gmail.com>
