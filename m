Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52029 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaEGUMX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 May 2014 16:12:23 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] tests: make kill to go-around when /proc is not available
Date: Wed, 7 May 2014 22:12:12 +0200
Cc: util-linux@vger.kernel.org
References: <1399482068-6460-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399482068-6460-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405072212.12680.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Sami,

On Wednesday 07 May 2014, Sami Kerola wrote:
> [PATCH] tests: make kill to go-around when /proc is not available

Do you really want to get it work when whole /proc is not available
or just if /proc/$pid/status is still missing?

> And change messaging to be easier to debug, if the outcome of the
> opportunistic sleep is unsuccessful test.  In such case one could
> assume the test_sigreceive was not successful when setting handler. 
> Maybe because of load on test server, or some other reason.
>
> Reference: https://travis-ci.org/rudimeier/util-linux/jobs/24561058
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  tests/ts/kill/kill_functions.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tests/ts/kill/kill_functions.sh
> b/tests/ts/kill/kill_functions.sh index 043b4cb..56ad98b 100644
> --- a/tests/ts/kill/kill_functions.sh
> +++ b/tests/ts/kill/kill_functions.sh
> @@ -5,6 +5,16 @@ function check_test_sigreceive {
>  	local pid=$1
>
>  	for i in 0.01 0.1 1 1 1 1; do
> +		if [ ! -f /proc/$pid/status ]; then
> +			# This message is visible in tests/run.sh output.
> +			# Do not direct to $TS_OUTPUT it would make test
> +			# fail, while with a bit of luck this might be
> +			# recoverable (after a sleep).

How could the test still succeed if we break the loop and return 1?
In this case the particular tests usually write "helper did not start"
to $TS_OUTPUT.

> +			echo "kill_functions.sh: /proc/$pid/status: No such file or directory" &&
> +			rc=1 && 

Shouldn't we return 0 here ...

> +			sleep 2 &&
> +			break

... or only continue the loop to hope that /proc/$pid/status will be
there next round?

> +		fi
>  		awk 'BEGIN { retval=1 }
>  		/^SigCgt/ {
>  			lbyte = strtonum("0x" substr($2, 16, 16))


cu,
Rudi
