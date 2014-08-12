Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50299 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754465AbaHLUXd (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 16:23:33 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway1.nyi.internal (Postfix) with ESMTP id 28E462197E
	for <util-linux@vger.kernel.org>; Tue, 12 Aug 2014 16:23:33 -0400 (EDT)
Message-Id: <1407875012.2455823.152004429.12D0C846@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/3] docs: make the man-page licenses of chrt and taskset
 match their intent
Date: Tue, 12 Aug 2014 22:23:32 +0200
In-Reply-To: <1407874518-12776-1-git-send-email-bensberg@justemail.net>
References: <1407874518-12776-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Aug 12, 2014, at 22:15, Benno Schulenberg wrote:
>  .\" This is free documentation; you can redistribute it and/or
> -.\" modify it under the terms of the GNU General Public License as
> -.\" published by the Free Software Foundation; either version 2 of
> -.\" the License.

The intent seems to have been to reduce the text "either version 2 of
the License, or (at your option) any later version." to just "version 2 of
the License." but forgetting to remove the word "either".  It would make
sense, because the corresponding .c files are licensed under version 2 too.
I've asked the original author about his intent, but he did not respond.

It seems there has been a version 2.1 of the GPL, but I cannot find it
on gnu.org.  If it did exist, then "either version 2 of the License" could
make sense, but would still allow to relicense it under just version 2.
So I think the change is correct in all cases.

Benno

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service

