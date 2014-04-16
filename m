Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32472 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152AbaDPKNX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Apr 2014 06:13:23 -0400
Date: Wed, 16 Apr 2014 12:13:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH 7/9] tests: check kill all user processes
Message-ID: <20140416101308.GG5786@x2.net.home>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
 <1397560535-14622-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397560535-14622-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 15, 2014 at 12:15:33PM +0100, Sami Kerola wrote:
> +ts_check_test_command "$TS_CMD_KILL"
> +ts_check_test_command "$TS_CMD_SU"

 ts_check_test_command "TS_HELPER_SIGRECEIVE"

> +if ! getent passwd nobody >/dev/null; then
> +	ts_skip "no nobody user"
> +fi
> +
> +TEST_PID=''
> +TS_CWD="${0%/*}"

Please, use $TS_OUTDIR. The tests should not write to another places.
The output/ is the directory that clean up our build system.

> +HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
> +ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
> +trap "rm -f $HELPER_SYMLINK" 0
> +
> +su nobody -s /bin/sh -c "$HELPER_SYMLINK $TS_CWD/nobody" >> "$TS_OUTPUT" 2>&1 &

I don't understand this idea, on my system Mr.Nobody can not write 
to my directories.

It would be also better to add --setgit and --setuid to the helper to
avoid extra su(1) process, then you can use TEST_PID=$!

> +# test_sigreceive needs time to start up
> +for i in 0.01 0.1 1 1 1 1; do
> +	test -f "$TS_CWD/nobody" && { up=1; break; }
> +	sleep $i
> +done

The question is if we really need to use the PID files. Would be
possible to use test_sigreceive that does not write anything?

You can for example to use 

   awk '/SigCgt/ { print $2}' /proc/<pid>/status 
   
to check if the signal handlers are already initialized (the final
mask is 800000027ffbfeff on my system).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
