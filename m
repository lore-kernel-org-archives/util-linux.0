Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42223 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932399AbaKSU7D (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Nov 2014 15:59:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C2CC8209C5
	for <util-linux@vger.kernel.org>; Wed, 19 Nov 2014 15:59:02 -0500 (EST)
Message-ID: <546D0495.2030803@dasyatidae.net>
Date: Wed, 19 Nov 2014 14:59:01 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: 770211@bugs.debian.org
Subject: LUKS partition types, redux
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Good day, folks of util-linux;

Summary: I would like to reopen the suggestion to add LUKS partition type codes
for MBR and for GPT to util-linux's fdisk.  In a previous discussion, it was
said that since Linux does not interpret partition types, there is no need for
this, but concrete data loss has now occurred as a result of a related bug in
other software combined with the lack of a user-visible LUKS type in a similar
partitioning program, and I believe that warrants re-examination of the situation.

Details:

I recently submitted Debian wishlist bug #770211 [1] suggesting to add e8 as the
MBR type code for LUKS to fdisk, per [2], mainly for consistency with my wishlist
item for gdisk at [3].  I was asked to ask about it here.  (I see now that fdisk
also handles GPT disklabels, which I wasn't previously aware of.)

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=770211
[2] http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=769631

I see now that there was a thread in January starting at [4] (message-ID
1390934933.15213.17.camel@heisenberg.scientia.net) about this, and the overall
result seemed to be that since Linux ignores partition type codes, there is
no reason to provide one for LUKS volumes.  The counterargument (which I agree
with) was roughly that since the type code slots exist in the first place, it
would be better to help the user semantically align them with the partition
contents, to prevent future issues from other type codes being used instead and
then misinterpreted by other systems.

[4] http://marc.info/?l=util-linux-ng&m=139093540719399&w=2

I would like to point out additional concrete evidence for the counterargument
now, in terms of harm minimization.  I previously tagged LUKS volumes on GPT with
a type code corresponding to the underlying volume type, as the closest thing I
could find (and a straw poll of some other Linux sysadmins I know says some of them
do the same).  I recently submitted Debian bug #768897 [5] in which partman-lvm,
a component of the Debian installer, overaggressively interprets the LVM type as a
normative request to make the partition contain an LVM PV, thus destroying all of
my existing LVM-on-LUKS volumes.  While I firmly believe that this is a bug in
partman-lvm and not in util-linux, had I used util-linux's fdisk to make the
partition tables, the presentation of a LUKS type code there would have
prevented significant data loss in this case.  (In my case, I used gdisk, but
I'm taking it up with them separately.)

[5] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=768897

I would thus like to re-propose adding a LUKS type.  Alternatively, if a LUKS
type is still considered a bad idea, I would like to suggest allocating a GPT ID
analogous to the "da = Non-FS data" MBR type code, which would at least allow the
user to choose a fallback that has a known null semantic, rather than tagging their
volumes with some arbitrary ID that may be misinterpreted; that would help avert
analogous problems for future types as well.

(I also believe more philosophically that the user should be supported in the
possibility of integrating with other partition management systems that may wish
to detect LUKS and do something special with it, without requiring all other such
systems to incorporate a blkid-like system for checking in several places for the
"basic nature" of a volume.  I mention this only for the record, since the previous
thread suggests the util-linux maintainers don't agree with this.)

Thanks for any (polite) replies.

   ---> Drake Wilson
