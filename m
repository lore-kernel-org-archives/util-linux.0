Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36556 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754966AbaKPLkO convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 16 Nov 2014 06:40:14 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B603220783
	for <util-linux@vger.kernel.org>; Sun, 16 Nov 2014 06:40:13 -0500 (EST)
Message-Id: <1416138013.3540405.191555165.2F640DB3@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: =?ISO-8859-1?Q?Ville=20Skytt=E4?= <ville.skytta@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Subject: Re: [PATCH] Spelling fixes
Date: Sun, 16 Nov 2014 12:40:13 +0100
In-Reply-To: <1416084103-15931-1-git-send-email-ville.skytta@iki.fi>
References: <1416084103-15931-1-git-send-email-ville.skytta@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, Nov 15, 2014, at 21:41, Ville Skyttä wrote:
> --- a/Documentation/releases/v2.25-ReleaseNotes
> +++ b/Documentation/releases/v2.25-ReleaseNotes
> @@ -1146,7 +1146,7 @@ tests:
>     - allow to add or override test suite options  [Ruediger Meier]
>     - avoid executing dirname(1) command  [Sami Kerola]
>     - cal  do not let --week=<num> to adjust requested month  [Sami Kerola]
> -   - cal  take account week numbers when determing month lenght  [Sami Kerola]
> +   - cal  take account week numbers when determing month length  [Sami Kerola]

I don't think it's a good idea to spell-correct these automatically
generated release notes -- if anyone reads them, and they find
something they want to look, to see the diff, then their only option
is to search for the given commit message in 'git log -p'.  If this
string no longer matches...

But /if/ it is okay to make spelling fixes to the release notes, then
also s/determing/determining/, and s/take account week numbers/
take week numbers into account/.  Many of Sami's commit lines
would need to be tweaked -- sorry, Sami.  :)

Benno

-- 
http://www.fastmail.fm - Access your email from home and the web

