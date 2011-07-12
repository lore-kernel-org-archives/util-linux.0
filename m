Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46054 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab1GLTTK convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 Jul 2011 15:19:10 -0400
Received: by iwn6 with SMTP id 6so4910835iwn.19
        for <util-linux@vger.kernel.org>; Tue, 12 Jul 2011 12:19:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu>
References: <201107112259.55340.vapier@gentoo.org> <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu>
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 12 Jul 2011 15:18:50 -0400
Message-ID: <CAJaTeTpBxcZ8ofxSHd7B1aRbU3wtSH=ED6ZYKEPPs4q3fgc2nA@mail.gmail.com>
Subject: Re: `fsck -A` and fs-specific options
To: Theodore Tso <tytso@mit.edu>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 12, 2011 at 07:02, Theodore Tso wrote:
> On Jul 11, 2011, at 10:59 PM, Mike Frysinger wrote:
>> for example, some journaling file systems allow the journal to be stored
>> separately.  reiserfs has the "jdev=" mount option and the "--journal" fsck
>> option.  ext[34] have the "journal_dev=" mount option and the "-j" fsck
>> option.
>
> At least for ext[34] and external journals, e2fsck can find the external
> journal using the blkid library since the UUID of the external journal
> is in the superblock.   (In fact that's why the blkid library was originally
> written, and why it was originally included as part of e2fsprogs.)

when i read the kernel source, that seemed to be the case.  but i dont
think it's the case for reiserfs, and i think there's a very tiny edge
case with ext[34] related to moving the journal, but probably so small
we can ignore it :p.

>> another example is with loop mounts that take an offset.  fsck cannot operate
>> on the loop source as the start of the file is not the image.  it needs to
>> first setup the loop with the offset, and then do the fsck on the loop point.
>>       /tmp/foo.img /mnt/tmp ext3 loop,offset=10000
>
> How often are people using loopback mounts as a default, standard thing which
> need to be mounted and checked as part of the boot sequence?   I'm just
> curious what the use case is for this?

common enough that i got a report on it ;).  it was a mount point to
be checked/mounted during boot.

> I suppose if this was something people really did care about, the /etc/fstab
> format could be extended to add a new field at the end for fsck options ---
> but it's more complexity, and could break programs try to programmatically
> modify /etc/fstab.

right, which is why i was thinking that parsing the fstab's options
field is the lesser of two evils ...
-mike
