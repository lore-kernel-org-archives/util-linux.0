Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56991 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788Ab1KVJDd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Nov 2011 04:03:33 -0500
Received: by qyk2 with SMTP id 2so8410qyk.19
        for <util-linux@vger.kernel.org>; Tue, 22 Nov 2011 01:03:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1321913175.3253.8.camel@offbook>
References: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com>
	<1321913175.3253.8.camel@offbook>
Date: Tue, 22 Nov 2011 10:03:32 +0100
Message-ID: <CAMtsiiDrWGKthY52+HT5r19g9EFRG2NHKMD3vni-SeaMNfuGDg@mail.gmail.com>
Subject: Re: mkfs.minix V3 is broken
From: Maurizio Lombardi <m.lombardi85@gmail.com>
To: dave@gnu.org
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 21, 2011 at 11:06 PM, Davidlohr Bueso <dave@gnu.org> wrote:
>
> Most of the work I did on supporting v3 was based on the kernel's
> implementation and the mkfs shipped with minix (by ast), so a lot of
> what you say makes sense. I've taken a quick look at the changes and
> most are bugs are pretty straightforward, except:
>
> - mkfs.minix: The total number of zones is limited to 65536 only on V1
> filesystems
>
> Unless I'm missing something, this doesn't really change any logic.

Sorry, probably the commit message is not very well written... However
this commit fixes a very nasty bug, let me explain why....
Look at what the code did *before* my patch:

if (fs_version == 3)
     magic = MINIX3_SUPER_MAGIC;
if (fs_version == 2) {
     if (namelen == 14)
       magic = MINIX2_SUPER_MAGIC;
     else
       magic = MINIX2_SUPER_MAGIC2;
} else {
    if (BLOCKS > MINIX_MAX_INODES)
       BLOCKS = MINIX_MAX_INODES;
}

Can you see what happens if fs_version is == 3 ?
The total number of blocks is restricted to a maximum of 65536 both
with V1 and V3 filesystems, this is wrong because the total number of
blocks in V3 is a 32 bit number (the same of V2). With this
realization, it is really simple to fix the bug, and this is exactly
what I did:

if (fs_version == 3)
     magic = MINIX3_SUPER_MAGIC;
- if (fs_version == 2) {
+else if (fs_version == 2) {
     if (namelen == 14)
       magic = MINIX2_SUPER_MAGIC;
     else
       magic = MINIX2_SUPER_MAGIC2;
} else {
    if (BLOCKS > MINIX_MAX_INODES)
       BLOCKS = MINIX_MAX_INODES;
}

>
> I'll give the changes a proper test over the weekend.

Ok, thanks.
In case you accept the changes I did, this is the github repository
link with read-only access from where you can pull the changes from:

git://github.com/maurizio-lombardi/util-linux.git

Regards,
-- 
--------------------
Maurizio Lombardi
