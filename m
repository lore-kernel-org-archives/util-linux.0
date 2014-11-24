Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58403 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733AbaKXPEh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 10:04:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9EBE320B6C
	for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 10:04:36 -0500 (EST)
Message-ID: <54734903.5080503@dasyatidae.net>
Date: Mon, 24 Nov 2014 09:04:35 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com> <5472B7E4.4040601@dasyatidae.net> <547341AD.4020702@ubuntu.com> <547342B2.2060509@dasyatidae.net> <54734522.7010807@dasyatidae.net> <547347A1.7080402@ubuntu.com>
In-Reply-To: <547347A1.7080402@ubuntu.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Phillip Susi wrote:
> Oh boy.  I hadn't noticed that util-linux had added so many silly type
> codes now that it supports GPT.  This mess really needs cleaned up.
> There should just be "Linux" and that's it.

I'd be fine with everything getting merged into a single "Linux" type.

If that happens, would it make sense to get rid of the listings for the
other Linux types in MBR mode too and loosely standardize on all 0x83
types there?  (Or interpret them for existing disklabels, and of course
don't forbid setting them, but remove them from the actively-displayed
list.)

> That's the only one we
> have in parted and it is quite sufficient.

In parted, really?  While I was chasing down the partman-lvm data flow
involved, it seemed to me that it was libparted that was setting flags
based on interpreting the LVM GPT type, which were later getting interpreted;
it wasn't obvious to me where to break the logic chain.  Is that part of
libparted a Debianism, or did you mean parted-the-tool as opposed to
libparted-the-library, or... ?

   ---> Drake Wilson
