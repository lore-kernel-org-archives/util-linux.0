Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35319 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782AbbAKV1U (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 16:27:20 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 7450A2016C
	for <util-linux@vger.kernel.org>; Sun, 11 Jan 2015 16:27:20 -0500 (EST)
Message-Id: <1421011640.3997112.212536661.5BB22B38@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Peter Cordes <peter@cordes.ca>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: questions on util-linux translation
Date: Sun, 11 Jan 2015 22:27:20 +0100
In-Reply-To: <20150108040504.GT29504@cordes.ca>
References: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com>
 <1420490268.1408121.209893057.48A620D9@webmail.messagingengine.com>
 <CAO7R9g8aGM48RzU-ed-cYyAdUEPbX7B4QSsVTdLx90poPtKwhQ@mail.gmail.com>
 <1420577328.1786767.210387085.321E0759@webmail.messagingengine.com>
 <20150108040504.GT29504@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Jan 8, 2015, at 05:05, Peter Cordes wrote:
>  So I'd suggest keeping the "partition #%d already doesn't exist".  As
> a native English speaker, I agree it sounds slightly clumsy, but it
> gets the point across quickly and unambiguously.  You could maybe lose
> the word "already", and say
> "partition #%d doesn't exist"

Agreed.  Corresponding patch is coming up.

Benno

-- 
http://www.fastmail.com - mmm... Fastmail...

