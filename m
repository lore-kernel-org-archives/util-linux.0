Return-Path: util-linux-owner@vger.kernel.org
Received: from b.a.painless.aa.net.uk ([81.187.30.65]:51242 "EHLO
	b.a.painless.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbaLRJse (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Dec 2014 04:48:34 -0500
From: Adam Sampson <ats@offog.org>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: RFC [patch] adding docstrings
References: <1418847631-8317-1-git-send-email-bensberg@justemail.net>
Date: Thu, 18 Dec 2014 09:20:26 +0000
In-Reply-To: <1418847631-8317-1-git-send-email-bensberg@justemail.net> (Benno
	Schulenberg's message of "Wed, 17 Dec 2014 21:20:31 +0100")
Message-ID: <y2ah9wtwbz9.fsf@cartman.at.offog.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Benno Schulenberg <bensberg@justemail.net> writes:

> This patch adds a docstring (a one-line description) to each of the
> utilities.

Is it worth synchronising these descriptions with the one-liners in the
"NAME" sections of the man pages (i.e. what apropos shows)? I think the
one you've come up with for addpart is clearer than the existing one in
the man page, for example...

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
