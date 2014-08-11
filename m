Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58555 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754670AbaHKUeF (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Aug 2014 16:34:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by gateway1.nyi.internal (Postfix) with ESMTP id 23B7F22D3B
	for <util-linux@vger.kernel.org>; Mon, 11 Aug 2014 16:34:05 -0400 (EDT)
Message-Id: <1407789244.2112503.151580837.566CF6FE@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] docs: improve the description of --size in the man page of
 zramctl
Date: Mon, 11 Aug 2014 22:34:04 +0200
In-Reply-To: <1407788619-4298-1-git-send-email-bensberg@justemail.net>
References: <1407788619-4298-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Aug 11, 2014, at 22:23, Benno Schulenberg wrote:
> The zram devices size is page size aligned.  When
> -requested
> -.I size
> -does match with page size the device be large enough to hold the reqested
> -.I size
> -plus length to next page boundary.

The above does not parse for me.  I am not in a position to test
zram devices, so to be sure that my replacement text is correct,
the following question: when one passes with --size a number that
is not a multiple of the memory-page size, does a subsequent call
of 'zramctl --raw' then print the aligned (rounded-up) number, or
does it still print the size that was specified although in fact
the aligned, bigger number is being used?

Benno

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service

