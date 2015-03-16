Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39740 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbbCPNUB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 09:20:01 -0400
Date: Mon, 16 Mar 2015 14:19:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/8] tests: add test_logger helper command
Message-ID: <20150316131947.GM28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
 <1426424094-25451-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426424094-25451-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 12:54:49PM +0000, Sami Kerola wrote:
> +#ifndef TEST_LOGGER
>  	gettimeofday(&tv, NULL);
> +#else
> +	tv.tv_sec = 1234567890;
> +	tv.tv_usec = 123456;
> +#endif

I have replaced this with logger_gettimeofday() macro and read the
value for the tests from LOGGER_TEST_TIMEOFDAY env.variable (and so on
for hostname and pid), for example to be compatible with your tests:

export TZ="GMT"
export LOGGER_TEST_TIMEOFDAY="1234567890.123456"
export LOGGER_TEST_HOSTNAME="test-hostname"
export LOGGER_TEST_GETPID="98765"

I have applied your test without a change (except the environment):

./run.sh logger

-------------------- util-linux regression tests --------------------

                    For development purpose only.                    
                 Don't execute on production system!                 

       logger: options                        ...
                : simple                      ... OK
                : log_pid                     ... OK
                : log_pid_long                ... OK
                : log_pid_define              ... OK
                : log_pid_no_arg              ... OK
                : input_file_simple           ... OK
                : input_file_empty_line       ... OK
                : input_file_skip_empty       ... OK
                : input_file_prio_prefix      ... OK
           ... OK (all 9 sub-tests PASSED)


It would be also nice to have tests for --rfc5424[=...] messages formatting.

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
