Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45096 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751649AbaKKUYq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Nov 2014 15:24:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9297420B2E
	for <util-linux@vger.kernel.org>; Tue, 11 Nov 2014 15:24:45 -0500 (EST)
Message-Id: <1415737485.1442296.189804205.189B69BC@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "util-linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] docs: improve wording and formatting of man page of hwclock
Date: Tue, 11 Nov 2014 21:24:45 +0100
In-Reply-To: <CAG27Bk0005eqTS+vFCmTR7K0uT1T14kxn=88cxd5fcQYu1wzkg@mail.gmail.com>
References: <1415561366-3111-1-git-send-email-bensberg@justemail.net>
 <CAG27Bk0005eqTS+vFCmTR7K0uT1T14kxn=88cxd5fcQYu1wzkg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Sami,

On Sun, Nov 9, 2014, at 21:11, Sami Kerola wrote:
> While looking the changes I started to wonder would a
> bit more formatting make lists better. See an attachment that should
> apply on top of your change. If you like the idea just incorporate my
> change into yours with Reviewed-by line.

Hmm... it makes these two "lists" stand out in the text, as if they
are quite important.  But they are in fact of very minor importance,
documenting internal stuff that most users do not need nor want to
know.  So I will not apply your patch on top of mine.

(But I'll keep the table formatting in mind, in case some other page
could profit from it.)

Regards,

Benno

-- 
http://www.fastmail.fm - mmm... Fastmail...

