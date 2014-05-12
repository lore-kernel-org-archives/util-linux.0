Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.24]:53419 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaELHFg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 12 May 2014 03:05:36 -0400
Message-ID: <537072BE.3090301@bernhard-voelker.de>
Date: Mon, 12 May 2014 09:05:34 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
CC: Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: [PATCH 01/12] tests: check /proc availability, and go-around
 if it is incomplete
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/11/2014 09:26 PM, Sami Kerola wrote:
> diff --git a/tests/ts/kill/kill_functions.sh b/tests/ts/kill/kill_functions.sh
> index 73fff05..a2a2483 100644
> --- a/tests/ts/kill/kill_functions.sh
> +++ b/tests/ts/kill/kill_functions.sh
> @@ -1,3 +1,5 @@
> +# kill tests, or command, will not when /proc is missing.
> +test /proc || ts_skip "/proc not available"

Ahem, this only ensures that '/proc' is a string, nothing else ...


>  # unfortunately we are using gawk features
>  type gawk >/dev/null 2>&1 || ts_skip "cannot find gawk"
> @@ -8,6 +10,17 @@ function check_test_sigreceive {
>  	local pid=$1
>  
>  	for i in 0.01 0.1 1 1 1 1; do
> +		if [ ! -f /proc/$pid/status ]; then
> +			# The /proc exists, but not status file. Because
> +			# the process already started it is unlikely the
> +			# file would appear after any amount of waiting.
> +			# Try to sleep for moment and hopefully
> +			# test_sigreceive is ready to be killed.
> +			echo "kill_functions.sh: /proc/$pid/status: No such file or directory"
> +			sleep 2
> +			rc=1
> +			break
> +		fi
>  		gawk 'BEGIN { retval=1 }
>  		/^SigCgt/ {
>  			lbyte = strtonum("0x" substr($2, 16, 16))
> 

Seeing all this /proc stuff going into the tests - it now even
requires gawk - I still personally think that a simple witness
file would have done it.
So Karel, if you really prefer this, then I'm okay with it, of course.

Have a nice day,
Berny
