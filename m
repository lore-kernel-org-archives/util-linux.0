Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f177.google.com ([209.85.220.177]:35529 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATLb3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 06:31:29 -0500
Received: by mail-vc0-f177.google.com with SMTP id m18so517554vcm.22
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 03:31:28 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1358679376.31211.140661179923553.796CC6BD@webmail.messagingengine.com>
References: <1358679376.31211.140661179923553.796CC6BD@webmail.messagingengine.com>
Date: Sun, 20 Jan 2013 11:25:21 +0000
Message-ID: <CAG27Bk0TErNurB5fOaM9=3O4Wzy6dv7Gx7oHL-vzuv=NGEiVyA@mail.gmail.com>
Subject: Re: [patches] a bunch of textual fixes, plus -V for renice
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 20, 2013 at 10:56 AM, Benno Schulenberg
<bensberg@justemail.net> wrote:
> Attached set of patches I had still lying around.  They have been
> rebased against current origin.
>
> The first three patches improve the wording or consistency of some
> help texts and error messages.  The fourth patch gettextizes several
> overlooked translatable strings, and improves some of them and some
> related others.  The fifth patch standardizes the reporting of the
> program name to "name from util-linux".  The  sixth patch improves
> the synopsis of renice to re-include the long option names and also
> improves the help text.  Finally, the seventh patch makes renice
> recognize also -V for --version (instead of just -v), documents it,
> and in the bargain improves the man page.

Hi Benno,

There is lots of good stuff in these patches, but as usual some things
could be bit better. For example the version strings which you wrote
to format

+       fprintf(stderr, _("%s from %s\n"),
+                       program_invocation_short_name, PACKAGE_STRING);

should use UL version printing macro.

+       fprintf(stderr, UTIL_LINUX_VERSION);

In the patch 0007 the renice(1) adds -V short option along side with
-v to print version. IMHO if the upper case option is added the lower
case equivalent should be dropped.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
