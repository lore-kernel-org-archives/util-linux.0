Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44736 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754797AbbLGLm2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Dec 2015 06:42:28 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6EBEF20A96
	for <util-linux@vger.kernel.org>; Mon,  7 Dec 2015 06:42:27 -0500 (EST)
Message-Id: <1449488547.1561804.460168961.6EAB5576@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20151207112531.GB2353@ws.net.home>
References: <1447862680.1454629.443346489.1A298B99@webmail.messagingengine.com>
 <20151207112531.GB2353@ws.net.home>
Subject: Re: cfdisk cuts lines for logical partitions too short
Date: Mon, 07 Dec 2015 12:42:27 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Dec 7, 2015, at 12:25, Karel Zak wrote:
> On Wed, Nov 18, 2015 at 05:04:40PM +0100, Benno Schulenberg wrote:
> > In 2.27, the highlight bar of cfdisk is three or four characters
> > shorter than the width of the screen -- for logical partitions.
> > I noticed because on a 100-column terminal two letters of a
> > translation were bitten off.
> 
>  Probably fixed -- I'm not sure if I have found the same bugs like
>  you :-) 

Tested.  Looks good now.  Thanks!

Benno

-- 
http://www.fastmail.com - Accessible with your email software
                          or over the web

