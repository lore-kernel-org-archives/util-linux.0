Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46889 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750704AbaKWK1O (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 23 Nov 2014 05:27:14 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B714D20393
	for <util-linux@vger.kernel.org>; Sun, 23 Nov 2014 05:27:13 -0500 (EST)
Message-Id: <1416738433.2192551.194323673.28884C59@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "util-linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <5470FE32.9030805@gmx.com>
References: <5470FE32.9030805@gmx.com>
Subject: Re: RFC hwclock: refactoring
Date: Sun, 23 Nov 2014 11:27:13 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello JWP,

On Sat, Nov 22, 2014, at 22:20, JWP wrote:
> For example, do we need a workaround for the 1994 Award BIOS
> bug?

In my opinion machines with that BIOS are too old.  So no.
Also because I wondered a few times about this phrase:

>               hwclock warns you that you probably need --badyear  whenever  it
>               finds your Hardware Clock set to 1994 or 1995.

Nowhere in the source of hwclock can I find this warning.  But it
has been there in 2000, because this user reports having gotten it:
https://groups.google.com/d/msg/alt.lang.basic/ilp_6HwLvZE/sE1nBoiD_LcJ

Since no one ever complained that the above phrase in the man page
is incorrect, it most likely means that no one uses such machines
any more.

Benno

-- 
http://www.fastmail.com - Choose from over 50 domains or use your own

