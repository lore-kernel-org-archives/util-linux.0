Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab2G0ITt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 04:19:49 -0400
Date: Fri, 27 Jul 2012 10:19:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] tests: update oddinput test
Message-ID: <20120727081943.GC14019@x2.net.home>
References: <50124D10.4080906@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50124D10.4080906@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 10:10:56AM +0200, Bernhard Voelker wrote:
> 
> From ca423116354d7ea1fb7604d838078a41840af19e Mon Sep 17 00:00:00 2001
> From: Bernhard Voelker <mail@bernhard-voelker.de>
> Date: Fri, 27 Jul 2012 10:10:10 +0200
> Subject: [PATCH] tests: update oddinput test
> 
> Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
> ---
>  tests/expected/fdisk/oddinput |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
> index 14f2528..a681d0d 100644
> --- a/tests/expected/fdisk/oddinput
> +++ b/tests/expected/fdisk/oddinput
> @@ -9,6 +9,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
>  I/O size (minimum/optimal): 512 bytes / 512 bytes
> 
>  Nonexistant file
> -lt-fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
> +fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
>  Too small file
> -lt-fdisk: cannot open oddinput.toosmall: Invalid argument
> +fdisk: cannot open oddinput.toosmall: Invalid argument

No, this is about libtool... it would be better to fix the tests to
always remove the lt- prefix from $TS_OUTPUT files.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
