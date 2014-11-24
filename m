Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45209 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754403AbaKXOhk (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 09:37:40 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 845A020B26
	for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 09:37:39 -0500 (EST)
Message-ID: <547342B2.2060509@dasyatidae.net>
Date: Mon, 24 Nov 2014 08:37:38 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com> <5472B7E4.4040601@dasyatidae.net> <547341AD.4020702@ubuntu.com>
In-Reply-To: <547341AD.4020702@ubuntu.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Phillip Susi wrote:
> I have to say that adding more type codes for no reason is something
> I'm against.  Like you said in your first post, the loss was caused by
> a bug in debian-installer coupled with the lvm type code.  If you
> simply use the normal "Linux" type code, then everything works out

Which "normal" "Linux" type code are you talking about?  The one that's
marked "Linux filesystem"?  That sounds like it's simply shifting the
potential for trouble somewhere else.  The one for "Linux reserved"?
If that's the intent of that one, perhaps it should be clearer that it's
"reserved for user" rather than "reserved for some unknown OS use".  If
there were a "Linux general/other" type code, then I agree that that
would be fine, but I don't see one in the list.

   ---> Drake Wilson
