Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49784 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751414AbaKXEp0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 23 Nov 2014 23:45:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6E2AA207BE
	for <util-linux@vger.kernel.org>; Sun, 23 Nov 2014 23:45:25 -0500 (EST)
Message-ID: <5472B7E4.4040601@dasyatidae.net>
Date: Sun, 23 Nov 2014 22:45:24 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com>
In-Reply-To: <546E1A16.6050102@ubuntu.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Phillip Susi wrote:
[originally re Dale's question]
> Linux doesn't pay any attention to partition type codes anyhow and
> just uses blkid to identify the contents.

So---entirely aside from the _other_ subthread about types _inside_ LUKS---do
you still intend to provide this as a reason for not adding GPT/MBR LUKS
types to fdisk, even in light of the destructive interaction I mentioned in
my first post?  I'm worried that my having said anything else while replying
to Dale may have been a mistake and given the impression that "no types inside
LUKS" answers my original concern, which it doesn't.

As I mentioned, GPT and MBR have significant interop characteristics with
other tools, so I'm not convinced by the "Linux only uses blkid" there.  If
that's what you're truly going with after having seen the practical results,
I won't argue further, but I'd like to know.

   ---> Drake Wilson
