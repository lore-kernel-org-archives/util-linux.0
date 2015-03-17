Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:62343 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932425AbbCQKwB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 06:52:01 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MTjua-1YyKBL0l6m-00QQjk for
 <util-linux@vger.kernel.org>; Tue, 17 Mar 2015 11:51:59 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: skip when logger --journald is not supported
Date: Tue, 17 Mar 2015 11:51:58 +0100
References: <1426588721-32688-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1426588721-32688-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201503171151.58456.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I see you've fixed this already, so forget about it.

On Tuesday 17 March 2015, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Followup a0fd24e0. "SKIP" instead of "KNOWN FAIL" to avoid ugly test
> diff in case we don't have --journald.
>
> CC: Sami Kerola <kerolasa@iki.fi>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tests/ts/logger/journald | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tests/ts/logger/journald b/tests/ts/logger/journald
> index 155aeae..cdc800c 100755
> --- a/tests/ts/logger/journald
> +++ b/tests/ts/logger/journald
> @@ -25,8 +25,13 @@ ts_init "$*"
>
>  ts_check_test_command "$TS_HELPER_LOGGER"
>
> -if ! $TS_HELPER_LOGGER --help | grep -q journald; then
> -	TS_KNOWN_FAIL="yes"
> +
> +# --help works and --journald is supported
> +if ! $TS_HELPER_LOGGER --help | grep -q -- "--version"; then
> +	ts_failed "logger --help"
> +fi
> +if ! $TS_HELPER_LOGGER --help | grep -q -- "--journald"; then
> +	ts_skip "option --journald not supported"
>  fi
>
>  printf "%s\n%s\n%s\n" MESSAGE_ID=b8f74e14bc714bfc8040a5106dc9376a
> MESSAGE="a b c 1 2 3" |
