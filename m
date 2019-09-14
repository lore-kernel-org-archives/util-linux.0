Return-Path: <SRS0=yHlE=XJ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E54DC4CEC9
	for <util-linux@archiver.kernel.org>; Sat, 14 Sep 2019 14:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB2E206A4
	for <util-linux@archiver.kernel.org>; Sat, 14 Sep 2019 14:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbfINOAF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 14 Sep 2019 10:00:05 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:38500
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbfINOAF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 14 Sep 2019 10:00:05 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcuu-util-linux-ng-3@m.gmane.org>)
        id 1i98an-000xHc-My
        for util-linux@vger.kernel.org; Sat, 14 Sep 2019 16:00:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     util-linux@vger.kernel.org
From:   Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: [bug] renice not POSIX compliant
Date:   Sat, 14 Sep 2019 14:55:37 +0100
Message-ID: <20190914135537.yps2umfx2nsynyii@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: NeoMutt/20171215
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi, there are a few POSIX compliance issues with the "renice"
command from util-linux.

First and more importantly, per POSIX, like for "nice", "-n"
is meant to take an "increment"/"adjustment", not an absolute
value.

As in

renice -n 5 "$pid"

is meant to increase the nice value by 5. While the traditional,
BSD-style:

renice 5 "$pid"

sets its absolute value to 5.

util-linux added "-n" in 2009 for POSIX compliance (see
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=7cfbafda9c484a8cadefc47ee115086e803d9391),
but the "-n" is just ignored. Since 2010, the --help message
does say that -n/--priority takes an "increment"
(https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=296351b0f112c821bffbe8ce7aa35d716251051d)
but that's not what happens in practice (it still sets the
niceness to the value specified).

$ nice -n 1 sh -c 'renice -n 2 "$$"; ps -o nice,comm -p "$$"; exit'
29606 (process ID) old priority 1, new priority 2
 NI COMMAND
  2 sh


Also, a POSIX renice utility is meant to parse the options the
usual (getopt(3)) way. In particular,

renice -gn 1 -- 123

Is meant to increase the niceness of pgid 123 by 1, but fails in
util-linux renice.

$ renice -gn 1 -- "$$"
renice: invalid priorty '-gn'
Try 'renice --help' for more information.

-p, -g, -u are meant to specify how *all* operands are to be
interpreted, they are not options that take arguments.

renice +1 123
renice +1 123 -u me

are unspecified by POSIX, so it's fine for util-linux to handle
the BSD way, but

renice -n 1 -u me -p 123

Is meant to increase the niceness of users "me", "-p" and "123".

Also, calling it "--priority" is quite misleading as the
niceness is rather the opposite of priority. GNU "nice" uses
"--adjustment" as the long-option equivalent of "-n" (note that
FreeBSD also calls it "priority" though)..

IMO, the best way to handle it would be to do a BSD-style
parsing when the first argument matches the [-+]?\d+ RE, and do
a POSIX getopt_long parsing otherwise with:

Change the (POSIX style) options to:

  -n/--adjustment <num>: niceness increment
  -v/--value (deprecated: --priority) <num>: exact niceness value
  -g/--pgrp (no arg): interpret operands as gids.
  -u/--user (no arg): interpret operands as user names/ids
  -p/-pid (no arg): interpret operands as pids.
  --help/--version...

And keep the

renice niceness [[-p/--pid] pid ...] [[-g/--pgrp] pgid ...] [[-u/--user] user ...]

usage for backward compatibility and BSD compatibility.

Note that there's currently a bug in the latest version of the
POSIX specification in that it says that positive increments
should *decrease* the niceness
(http://austingroupbugs.net/view.php?id=1286).

See
https://unix.stackexchange.com/questions/541673/how-do-i-start-a-shell-the-way-all-the-processes-ran-from-within-it-and-processe/541691#541691
for more details.

-- 
Stephane

