Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39188 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745AbcDOH7Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Apr 2016 03:59:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 4AA7F20C0B
	for <util-linux@vger.kernel.org>; Fri, 15 Apr 2016 03:59:24 -0400 (EDT)
Message-Id: <1460707163.1560857.579528393.51AFCD05@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1460668650-8594-1-git-send-email-kerolasa@iki.fi>
References: <1460668650-8594-1-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH] docs: optinal option arguments should be long-only
Date: Fri, 15 Apr 2016 09:59:23 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Apr 14, 2016, at 23:17, Sami Kerola wrote:
> +.I \-n
> +and optional option
> +.IR \-o .

Those need to be .B and .BR -- they are literal arguments.

> +One will expect
> +.BI command \ \-no
> +and
> +.BI command \ \-on

Both just .B.

> +to be the same, but in fact the former is two separate options while later
> +will use
> +.I n
> +as option argument of
> +.I -n

.B n  and  .B -o

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin

