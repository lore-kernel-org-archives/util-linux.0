Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43939 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756847AbaKSWh2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Nov 2014 17:37:28 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 095652118B
	for <util-linux@vger.kernel.org>; Wed, 19 Nov 2014 17:37:27 -0500 (EST)
Message-ID: <546D1BA7.9060501@dasyatidae.net>
Date: Wed, 19 Nov 2014 16:37:27 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>
CC: util-linux@vger.kernel.org
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com>
In-Reply-To: <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dale R. Worley wrote:
> This raises the related question of whether there should be codes to
> identify the partition type inside the LUKS partition.

(Dropping Debian bug from Cc for this.)

I don't think that really matches up with the way disklabel types
work any more than, say, identifying the type of data stored in a
filesystem would.  There actually _are_ GPT types in fdisk for
"Linux root (x86)", "Linux home" etc. but I consider these to be
anomalous and never use them as there's an infinite number of possible
nestings there.  If users want to mint their own GPT types for those
purposes, they can, of course.

My usual stance is that type identifiers should be shallow at each level
(one reason piercing through LUKS to get a type code is semantically bad)
and present at as many levels as necessary.  I might support an extension
proposal to allow (but not require) a type for the underlying volume to
be added as part of the _LUKS_ header, therefore (probably using a GPT
type just for convenience).  However, I also think the argument that it's
unnecessary because Linux wouldn't interpret it is much more valid there,
because LUKS is more or less defined by its use in Linux, whereas GPT and
MBR disklabels are not and have more stringent interop requirements with
other tools and OSes.

Either way, I don't think that's nearly as important.

   ---> Drake Wilson

