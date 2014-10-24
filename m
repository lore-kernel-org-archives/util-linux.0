Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56024 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756066AbaJXLdw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 07:33:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EDC1920E02
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 07:33:51 -0400 (EDT)
Message-Id: <1414150431.840372.182833341.74402120@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <5449BE57.9040203@gmx.com>
References: <5449BE57.9040203@gmx.com>
Subject: Re: [PATCH 2/5] hwclock: clean up message periods/full stops
Date: Fri, 24 Oct 2014 13:33:51 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 24, 2014, at 04:49, JWP wrote:
> 33% of message lines terminated with a period/full stop.

You mean 33% of hwclock messages, or 33% of util-linux messages?

> This is unsightly and difficult to read.

Ehm...  I would think the lack of periods would make things
more difficult to read.

> -		      ("The value of the --date option is not a valid date.\n"
> -		       "In particular, it contains quotation marks."));
> +		      ("The value of the --date option is not a valid date\n"
> +		       "In particular, it contains quotation marks"));

This is ugly.  Two lines of text and it's unclear that the first
sentence ends at the end of the line.  If you absolutely want
to get rid of the period, put a semicolon after "valid date" and
lowercase "in particular".

[...]

All just cosmetic changes, invalidating all the translations.
Not nice.

Benno

-- 
http://www.fastmail.fm - Same, same, but different...

