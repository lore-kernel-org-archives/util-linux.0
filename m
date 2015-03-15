Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36166 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752455AbbCOP0q (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Mar 2015 11:26:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 4B57F207D2
	for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 11:26:44 -0400 (EDT)
Message-Id: <1426433205.3225343.240610937.5D55876F@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <550337F0.3050100@gmx.com>
References: <5503364E.6010302@gmx.com> <550337F0.3050100@gmx.com>
Subject: Re: [PATCH 3/5] hwclock: remove depreciated ntpdate
Date: Sun, 15 Mar 2015 16:26:45 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Mar 13, 2015, at 20:18, J William Piggott wrote:
> Replace references to the depreciated ntpdate with sntp.

s/depreciated/deprecated/

> -.BR \%ntpdate\ \-q " , or " \%date\ \-Ins
> +.BR \%sntp ", or " \%date\ \-Ins

Hmm, maybe it's a bit to early to delete the mention of ntpdate?
My fairly recent Linux Mint doesn't have sntp yet.  Maybe add
sntp to the list instead of replacing ntpdate?

Oh, in the previous patch you used an inconsistent capital in
the subject line.  And the same s/system/system's/ applies.

Benno

-- 
http://www.fastmail.com - Accessible with your email software
                          or over the web

