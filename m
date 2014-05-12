Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62864 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbaELSpV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 14:45:21 -0400
Received: from brln-4d0cc907.pool.mediaways.net ([77.12.201.7]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LqQTl-1XEZ8o2ffF-00e8tb
 for <util-linux@vger.kernel.org>; Mon, 12 May 2014 20:45:19 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: bugs on exotic archs
Date: Mon, 12 May 2014 20:45:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405122045.18801.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

If somebody of you wants to do some sports...

Here I have a list of failing tests on certain architectures. If you own 
such system you may want to confirm and fix the one or the other issue. 
IMO most interesting are the fdisk failures on ppc and ppc64 and 
utmpdump on aarch64 which are IMO real bugs. The other ones might be 
bugs in the test suite or broken build hosts.

Failing test on certain archs:

%ifarch ppc ppc64
  hexdump
  fdisk/bsd
%endif

%ifarch ppc
  fdisk/gpt
%endif

%ifarch armv6l armv7l aarch64
  misc/setarch
%endif

%ifarch armv6l aarch64
  fdisk/gpt
  fdisk/oddinput
  fdisk/sunlabel
  misc/ionice
  misc/swaplabel
  kill/name
  kill/print_pid
%endif

%ifarch aarch64
  utmpdump
%endif

You can get the build logs and test diffs here
https://build.opensuse.org/package/show/home:rudi_m:branches:Base:System/util-linux
(The build status usually shows "success" because I've marked these 
tests "known-fail" to be noticed when we would add more bugs.)

cu,
Rudi
