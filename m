Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60703 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755026AbaJUTnO (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Oct 2014 15:43:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by gateway2.nyi.internal (Postfix) with ESMTP id 460B02051A
	for <util-linux@vger.kernel.org>; Tue, 21 Oct 2014 15:43:13 -0400 (EDT)
Message-Id: <1413920593.3703509.181691665.4864189E@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20141021090517.GE8057@x2.net.home>
References: <1413834738.3279286.181227401.682D2FFB@webmail.messagingengine.com>
 <20141021090517.GE8057@x2.net.home>
Subject: Re: the option --label-nested of sfdisk
Date: Tue, 21 Oct 2014 21:43:13 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Oct 21, 2014, at 11:05, Karel Zak wrote:
> The problem is that the original sfdisk version had "--nested" option,
> the option is no more supported, but I'd like to avoid misinterpretation.

Okay.  I retract the patch.  I will post just the wording fixes later.

Benno

-- 
http://www.fastmail.fm - Does exactly what it says on the tin

