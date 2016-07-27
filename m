Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51076 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754295AbcG0LXB (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Jul 2016 07:23:01 -0400
Message-Id: <1469618118.1670435.678129761.331B0F49@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20160727103457.3105-1-kerolasa@iki.fi>
References: <20160727103457.3105-1-kerolasa@iki.fi>
Subject: Re: [PATCH] getops: improve getopt-parse.bash example
Date: Wed, 27 Jul 2016 13:15:18 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


In the subject line: s/ops/opt/.

On Wed, Jul 27, 2016, at 12:34, Sami Kerola wrote:
> --- a/misc-utils/getopt-parse.bash
> +++ b/misc-utils/getopt-parse.bash
> @@ -3,45 +3,73 @@
>  # A small example program for using the new getopt(1) program.
>  # This program will only work with bash(1)
>  # An similar program using the tcsh(1) script language can be found

When here anyway, maybe fix a typo: s/An/A/.
Add a missing period: s/)/)./.
And adjust for the times: s/new //.

> -# as parse.tcsh
> +# as getopt-parse.tcsh

Also add period: s/tcsh/tcsh./

Benno

-- 
http://www.fastmail.com - Choose from over 50 domains or use your own

