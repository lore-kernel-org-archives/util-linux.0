Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:65415 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382AbbGBADY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Jul 2015 20:03:24 -0400
Received: from xd9ba0d5e.dyn.telefonica.de ([217.186.13.94]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0M6O1v-1YrW0v2OMt-00yRl1 for
 <util-linux@vger.kernel.org>; Thu, 02 Jul 2015 02:03:22 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: script, broken test options/return
Date: Thu, 2 Jul 2015 02:03:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201507020203.21632.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

on my system (interactive bash on openSUSE 13.1) the "return" subtest 
of "script/options" is broken since 54c6611d.

Seems that input from /dev/null makes the difference. Reproduce like
this:

$ export SCRIPT_DEBUG=all 
$ ./script --command "exit 1" out_good >/dev/null            2>dbg_good
$ ./script --command "exit 1" out_bad  >/dev/null </dev/null 2>dbg_bad
^C <abort ctrl-C>

$ head -n 20 dbg_good dbg_bad
==> dbg_good <==
25703: script:       IO: master fd: 3
25703: script:   SIGNAL: signal fd=5
25703: script:     POLL: calling poll()
25703: script:     POLL: poll() rc=1
25703: script:     POLL:  active pfd[signal].fd=5 POLLIN
25703: script:   SIGNAL: signal FD 5 active
25703: script:     MISC: waiting for child
25703: script:     POLL: calling poll()
25703: script:     POLL: poll() rc=0
25703: script:     POLL: setting die=1
25703: script:     POLL: poll() done
25703: script:     MISC: done!

==> dbg_bad <==
25708: script:       IO: master fd: 3
25708: script:   SIGNAL: signal fd=5
25708: script:     POLL: calling poll()
25708: script:     POLL: poll() rc=1
25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
25708: script:       IO: 0 FD active
25708: script:     POLL: calling poll()
25708: script:     POLL: poll() rc=1
25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
25708: script:       IO: 0 FD active
25708: script:     POLL: calling poll()
25708: script:     POLL: poll() rc=1
25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
25708: script:       IO: 0 FD active
25708: script:     POLL: calling poll()
25708: script:     POLL: poll() rc=1
25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
25708: script:       IO: 0 FD active
25708: script:     POLL: calling poll()
25708: script:     POLL: poll() rc=1
...

cu,
Rudi
