Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37721 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752259Ab3ATNf2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Jan 2013 08:35:28 -0500
Message-Id: <1358688927.20076.140661179956885.59525AA5@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [patches] a bunch of textual fixes, plus -V for renice
Date: Sun, 20 Jan 2013 14:35:27 +0100
In-Reply-To: <CAG27Bk0TErNurB5fOaM9=3O4Wzy6dv7Gx7oHL-vzuv=NGEiVyA@mail.gmail.com>
References: <1358679376.31211.140661179923553.796CC6BD@webmail.messagingengine.com>
 <CAG27Bk0TErNurB5fOaM9=3O4Wzy6dv7Gx7oHL-vzuv=NGEiVyA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Sami,

On Sun, Jan 20, 2013, at 12:25, Sami Kerola wrote:
> +       fprintf(stderr, _("%s from %s\n"),
> +                       program_invocation_short_name, PACKAGE_STRING);
> 
> should use UL version printing macro.
> 
> +       fprintf(stderr, UTIL_LINUX_VERSION);

Ah.  Okay.  Then it is good to leave that out for now.  I will provide a
new patch for that later.

> In the patch 0007 the renice(1) adds -V short option along side with
> -v to print version. IMHO if the upper case option is added the lower
> case equivalent should be dropped.

I agree -v should be dropped for --version, but I didn't want to do that
right away.  Maybe one or two releases down the line?

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

