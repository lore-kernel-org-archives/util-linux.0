Return-Path: <SRS0=xJlx=WX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B6C3A5A3
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A312D2077B
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 11:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfH0LRx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfH0LRx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Aug 2019 07:17:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDB3220261;
        Tue, 27 Aug 2019 11:17:52 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 082F51001B07;
        Tue, 27 Aug 2019 11:17:50 +0000 (UTC)
Date:   Tue, 27 Aug 2019 13:17:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/6] tests: remove reliance on buffer behaviour of
 stderr/stdout streams
Message-ID: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
References: <cover.1566555078.git.ps@pks.im>
 <cover.1566566906.git.ps@pks.im>
 <d503b30d13c847040a8343f0e7299ae1bf7cb120.1566566906.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d503b30d13c847040a8343f0e7299ae1bf7cb120.1566566906.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 27 Aug 2019 11:17:52 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Aug 23, 2019 at 03:32:53PM +0200, Patrick Steinhardt wrote:
> +	if [ "$TS_ENABLE_ASAN" == "yes" ]; then
> +		args+=(ASAN_OPTIONS='detect_leaks=1')
> +	fi
> +
>  	#
> -	# ASAN mode
> +	# Disable buffering of stdout
>  	#
> -	elif [ "$TS_ENABLE_ASAN" == "yes" ]; then
> -		ASAN_OPTIONS='detect_leaks=1' "$@"
> +	if [ -n "$UNBUFFERED" ]; then
> +		if type stdbuf >/dev/null 2>&1; then
> +			args+=(stdbuf --output=0)
> +		fi
> +	fi
>  
>  	#
> -	# Default mode
> +	# valgrind mode
>  	#
> -	else
> -		"$@"
> +	if [ -n "$TS_VALGRIND_CMD" ]; then
> +		args+=(libtool --mode=execute "$TS_VALGRIND_CMD" --tool=memcheck --leak-check=full)
> +		args+=(--leak-resolution=high --num-callers=20 --log-file="$TS_VGDUMP")
>  	fi
> +
> +	"${args[@]}" "$@"
>  }

Unfortunately, it seems "${args[@]}" does not work when environment
variable used:

  ASAN_OPTIONS=detect_leaks=1 stdbuf --output=0 /home/projects/util-linux/util-linux/mkswap --label 1234567890abcdef --uuid 12345678-abcd-abcd-abcd-1234567890ab /dev/sdc

ends with

  ./tests/ts/misc/../../functions.sh: line 465: ASAN_OPTIONS=detect_leaks=1: command not found


And it's more tricky, it seems ASAN binary cannot be executed by stdbuf

  # stdbuf --output=0 /home/projects/util-linux/util-linux/mkswap --label 1234567890abcdef --uuid 12345678-abcd-abcd-abcd-1234567890ab /dev/sdc
  ==28469==ASan runtime does not come first in initial library list; you should either link runtime to your application or manually preload it with LD_PRELOAD.

it's because stdbuf is hack based on LD_PRELOAD which makes it
difficult to use with ASAN...

I have tried to fix it by
https://github.com/karelzak/util-linux/commit/f612c4c674e8e07fc40644432d8147a05c62058e

... but it's really not perfect. I have used "unbuffer" (from expect)
rather than stdbuf. The question is how usable it will be... (but all
tests passed).

Note that you can try to use ASAN by ./configure --enable-asan, the
script tests/run.sh should be smart enough to detect it and then
individual tests are executed with --memcheck-asan.

So, merged -- please, test it with musl libc. 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
