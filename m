Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:57896 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbaJHWfH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Oct 2014 18:35:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Xbzp2-0000xI-8L
	for util-linux@vger.kernel.org; Thu, 09 Oct 2014 00:35:04 +0200
Received: from fb-n15-11.unbelievable-machine.net ([94.198.62.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 09 Oct 2014 00:35:04 +0200
Received: from tg by fb-n15-11.unbelievable-machine.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 09 Oct 2014 00:35:04 +0200
To: util-linux@vger.kernel.org
From: Thorsten Glaser <tg@mirbsd.org>
Subject: script from 2.25.1 may be broken (hangs)
Date: Wed, 8 Oct 2014 22:25:38 +0000 (UTC)
Message-ID: <loom.20141009T001730-172@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I'm the upstream of https://www.mirbsd.org/mksh.htm whose regression tests
I normally run, in packages, under script(1) because they need a tty, which
automated build machines from distributions do not normally provide.

I notice that in both Debian sid and OpenSuSE Factory, util-linux 2.25.1
is used, and in both, attempts to build mksh hang.

Debian: building in jessie (util-linux 2.20.1) works,
building other packages in sid works

OpenSuSE: not using script(1) to run the testsuite works.

How to reproduce: download
https://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R50d.tgz
then extract and build it:

$ tar xzf mksh-R50d.tgz
$ cd mksh
$ sh Build.sh -r
$ script -qc './test.sh -v' </dev/null 2>&1 | tee log

This exits after expand-ugly. My OBS builds hang after
heredoc-weird-5 which is a bit later in check.t (the testsuite).

On Debian, downgrading the bsdutils package to 2.20.1
fixes the problem.

Please keep me in Cc when replying, I am not subscribed to the newsgroup.

Thanks for your consideration!

bye,
//mirabilos

