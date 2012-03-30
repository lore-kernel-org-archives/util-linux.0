Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932511Ab2C3NfG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Mar 2012 09:35:06 -0400
Date: Fri, 30 Mar 2012 15:34:59 +0200
From: Karel Zak <kzak@redhat.com>
To: "mail@bernhard-voelker.de" <mail@bernhard-voelker.de>
Cc: Simon de Vlieger <simon@ikanobori.jp>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hexdump: adjust -s and -n option in the man page [was:
 hexsyntax.c using strtol on the offset parameter]
Message-ID: <20120330133459.GD23437@x2.net.home>
References: <4F6B13F9.4020108@bernhard-voelker.de>
 <20120323171936.GH2040@x2.net.home>
 <1961842217.201279.1332754786305.JavaMail.open-xchange@email.1und1.de>
 <1832206888.202754.1332755406928.JavaMail.open-xchange@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1832206888.202754.1332755406928.JavaMail.open-xchange@email.1und1.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 26, 2012 at 11:50:06AM +0200, mail@bernhard-voelker.de wrote:
> 
> On March 26, 2012 at 11:39 AM "mail@bernhard-voelker.de"
> <mail@bernhard-voelker.de> wrote:
> 
> > * [PATCH 1/2] wipefs: use strtosize() for -o
> 
> 
> oops, sorry, there is an error in that patch.
> It was obviously not so trivial as at seemed to be.
> 
> Here's the correction.
> 
> Berny
> 
> From 531cb1ec623fc5c3ac0e95f897b712517b5b1167 Mon Sep 17 00:00:00 2001
> From: Bernhard Voelker <mail@bernhard-voelker.de>
> Date: Mon, 26 Mar 2012 11:48:57 +0200
> Subject: [PATCH] wipefs: use strtosize() for -o
> Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
> ---
> misc-utils/wipefs.c | 6 +++++-
> 1 files changed, 5 insertions(+), 1 deletions(-)
> diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
> index 74de3a3..5059c7c 100644
> --- a/misc-utils/wipefs.c
> +++ b/misc-utils/wipefs.c
> @@ -385,6 +385,7 @@ main(int argc, char **argv)
> {
> struct wipe_desc *wp0 = NULL, *wp;
> int c, all = 0, has_offset = 0, noact = 0, mode = 0, quiet = 0;
> + uintmax_t offset;
> 
> static const struct option longopts[] = {
> { "all", 0, 0, 'a' },
> @@ -414,7 +415,10 @@ main(int argc, char **argv)
> noact++;
> break;
> case 'o':
> - wp0 = add_offset(wp0, strtoll_offset(optarg), 1);

 strtoll_offset() uses strtosize() :-)

 Anyway, I'll add strtosize_or_err() to make it more usable in
 argv[] parsers.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
