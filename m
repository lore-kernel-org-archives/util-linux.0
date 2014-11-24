Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54321 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754308AbaKXOsE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 09:48:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 648F12085C
	for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 09:48:03 -0500 (EST)
Message-ID: <54734522.7010807@dasyatidae.net>
Date: Mon, 24 Nov 2014 08:48:02 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com> <5472B7E4.4040601@dasyatidae.net> <547341AD.4020702@ubuntu.com> <547342B2.2060509@dasyatidae.net>
In-Reply-To: <547342B2.2060509@dasyatidae.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Drake Wilson wrote:
> Which "normal" "Linux" type code are you talking about?  The one that's
> marked "Linux filesystem"?
[etc.]

To clarify, that's in the GPT list, not the MBR one.  I see that the MBR one
names 0x83 "Linux", at least.  Does that mean that {0FC63DAF-8483-4772-8E79-3D69D8477DE4}
should also be named "Linux" rather than "Linux filesystem"?

I'm still a little suspicious of this in the context of "all the other Linux
types are more discriminating", but if that's really the "Linux everything-else"
type and _not_ merely the "Linux ext2/XFS/etc./things-that-store-files" type, then
making sure that's documented somewhere everyone can see suffices for me (and a
rename in the list is probably enough for that, assuming the more specific
backcompat case of "someone already made this assumption" (rather than "someone
may assume this in the future") is narrow enough that it can be ignored).

   ---> Drake Wilson

