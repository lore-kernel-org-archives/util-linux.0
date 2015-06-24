Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33905 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608AbbFXS6E (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Jun 2015 14:58:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 4D7FC20B4D
	for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 14:58:03 -0400 (EDT)
Message-Id: <1435172283.2271978.306821721.6AF80CD6@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Felix Neumann <felix.neumann@inka.de>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: Wording problem in man cal
Date: Wed, 24 Jun 2015 20:58:03 +0200
In-Reply-To: <CA+w_OVdqj9ZgM8cRL3t2EFsYTJ-ZzYJb2eJZw-pP0oBM+HNEJg@mail.gmail.com>
References: <CA+w_OVdqj9ZgM8cRL3t2EFsYTJ-ZzYJb2eJZw-pP0oBM+HNEJg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Jun 21, 2015, at 16:33, Felix Neumann wrote:
> Between Sept 2 and Sept 14, eleven dates are jumped; so the man page
> should read something like "eleven days following Sept 2 were
> eliminated";

True.  Upcoming patch fixes that, worded a bit differently.  Is it okay?

The ten days were elemininated when the reform happened in 1582;
when the reform was done much much later, eleven days needed to
be eliminated.  See also
https://en.wikipedia.org/wiki/Calendar_reform#Julian.2FGregorian_reforms

Benno

-- 
http://www.fastmail.com - mmm... Fastmail...

