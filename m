Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:33569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeCIOrn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Mar 2018 09:47:43 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M8JyQ-1egTOB42Wg-00vxDq for <util-linux@vger.kernel.org>; Fri, 09 Mar 2018
 15:47:42 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: debug parallel root checks
Date: Fri, 9 Mar 2018 15:47:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201803091547.40271.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Our parallel root checks look already nice on the first view.
On the second view they fail the stress test, at least on my
system.

Mostly umounting fails due to "device in use" and similar. For me it
seems that "udevadm --settle" has no effect sometimes. Very often the
label, utab, context and recursive mount tests make problems. I've made
sure that udisks and similar devils are not running.

One may try to use my script sippet below to run a loop until it fails.
You should remove the "sort" from run.sh to get more failures:

patch tests/run.sh
-----
 printf "%s\n" ${comps[*]} |
-       sort |
        xargs -I '{}' -P $paraller_jobs -n 1 bash -c "'{}' \"$OPTS\" ||
                echo 1 >> $top_builddir/tests/failures"
-----



#### ultest.bash ###
## Attention, using sudo"

i=0
while true; do
    echo -e "\n#### run test loop: $((++i)) ####\n"

    ## select any interesting subset of all tests and shuffle
    mytests=$(git grep -l "^ts_skip_nonroot$" -- tests/ts/*/ \
                | sort --random-sort | sed "s@tests/ts/@@")
    test -n "$mytests" || { echo "empty tests!?"; break; }

    time sudo ./tests/run.sh --parallel=30 --exclude="some-bad-tests" $mytests \
        || break
done

echo -e "\n#### bad run: $i ####\n"

###############


cu,
Rudi
