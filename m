Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48279 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751383AbbBXVNb (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 16:13:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 28D2120C5D
	for <util-linux@vger.kernel.org>; Tue, 24 Feb 2015 16:13:30 -0500 (EST)
Message-Id: <1424812410.4082705.231939245.08843DF4@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: wfp5p@worldbroken.com
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/8] fix spelling/typos in man pages
Date: Tue, 24 Feb 2015 22:13:30 +0100
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Feb 24, 2015, at 18:15, wfp5p@worldbroken.com wrote:
>   runuser.1: fix spelling implemenation -> implementation
>   scriptreplay.1: fix spelling overide -> override
>   unshare.1: fix spelling permamently -> permanently
>   last.1: fix spelling preferrable -> preferable
>   lslogins.1: fix spelling priviliges -> privileges
>   hwclock.8.in: fix spelling transfered -> transferred
>   prlimit.1: fix typo umlimited -> unlimited
>   agetty.8: fix typo unnsupported -> unsupported

It would be better to do this in a single patch instead, with subject:

docs: fix some spellos/typos in man pages

And then put the above eight lines in the commit message.

Benno

-- 
http://www.fastmail.com - Email service worth paying for. Try it for free

