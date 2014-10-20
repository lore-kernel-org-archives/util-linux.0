Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:55735 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbaJTXfT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Oct 2014 19:35:19 -0400
Message-ID: <54459C31.3060702@gmx.com>
Date: Mon, 20 Oct 2014 19:35:13 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] hwclock: hctosys drift compensation II
References: <5426D4C2.4060403@gmx.com> <5426D7C0.50108@gmx.com> <alpine.LNX.2.03.1409281829450.8884@iki.fi> <54298D46.6010101@gmx.com> <20141014090311.GM8057@x2.net.home> <544052E0.3080105@gmx.com> <20141020120550.GB8057@x2.net.home>
In-Reply-To: <20141020120550.GB8057@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 10/20/2014 08:05 AM, Karel Zak wrote:
> On Thu, Oct 16, 2014 at 07:21:04PM -0400, JWP wrote:
>> Repository created at GitHub:
>> https://github.com/jwpi/util-linux
>> git@github.com:jwpi/util-linux.git
>> https://github.com/jwpi/util-linux.git
> 
>  Thanks, merged. I have also added some (I hope correct) notes to
>  the begin of the hwclock man page.

Hello Karel,

Yes, what you wrote is correct. However, I think some of the wording
could be misinterpreted, especially:

"hwclock automatically compensates Hardware Clock to account for 
 systematic drift before using it to set the System Clock by --hctosys."

Someone may think the Hardware Clock itself was being compensated.

I have made a commit to change the wording slightly, I will send you a
pull request after I send this email.

Thank you for fixing hwclock's man page formatting! It was on my todo list.

Thank you for taking time to review and merge my work, and allowing me to
contribute to util-linux.

I have some util-linux workflow questions:

* Do you want pull requests sent to you via github?
* If yes, what, if anything, should be posted to the mailing list?

Will
