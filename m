Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.131]:60772 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbaDMWW3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Apr 2014 18:22:29 -0400
Message-ID: <534B0E1B.4040208@bernhard-voelker.de>
Date: Mon, 14 Apr 2014 00:22:19 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 4/7] tests: check kill is converting signals names correctly
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi> <1397298524-3364-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-5-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/12/2014 12:28 PM, Sami Kerola wrote:
> +	$TS_HELPER_SIGRECEIVE &
> +	TEST_PID=$(jobs -p)
> +	# test_sigreceive needs time to start up
> +	sleep 0.01
> +	$TS_CMD_KILL -$SIG ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
> +	wait $TEST_PID
> +	if [ $? -ne $EXPECTED ]; then
> +		echo "$SIG returned $? while $EXPECTED was expected" >> $TS_OUTPUT
> +		all_ok=false
> +	fi

This is racy. Although this might work in most cases, one can not
determine that the SIGRECEIVE process had enough time to startup
and register all signal handlers before the signal arrives.
Usually this would fail more likely with high system load,
e.g. on build servers with massive parallel builds.

The only chance is that the SIGRECEIVE program indicates that it
has fully come up, e.g. by creating a file which did not exist
beforehand. The second part of avoiding unwanted behavior is to
wait for such a witness file to appear in the parent test script
... but avoiding to wait infinitely (because other unknown reasons
may have prevented the creation of the witness file).

In the test-suite of coreutils, there are a few complex (and yet
necessary) snippets to do this:
a) test case waiting for the inspected program to be ready:
  http://git.savannah.gnu.org/cgit/coreutils.git/tree/tests/tail-2/retry.sh#n45
b) utility function to retry with increasing delay until a
maximum number has reached:
  http://git.savannah.gnu.org/cgit/coreutils.git/tree/init.cfg#n597

Maybe a solution like the above is too heavy for this situation (unless
it could be reused in other tests), so something like the following may
suffice here - assuming that $TS_HELPER_SIGRECEIVE will successfully
perform a 'creat("witnessfile", mode)':

  rm -f witnessfile   || fail=1
  test -f witnessfile && fail=1
  $TS_HELPER_SIGRECEIVE & TEST_PID=$!
  up=0
  while i in 0.01 0.1 1 2 ; do
    test -f witnessfile && { up=1; break; }
    sleep $i
  done
  test $up = 1 || fail=1
  $TS_CMD_KILL -$SIG ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
  ...

WDYT?

Thank you & have a nice day,
Berny
