Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:59408 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754168Ab1KIJcK convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Nov 2011 04:32:10 -0500
Received: from MCHP064A.global-ad.net (unknown [172.29.37.63])
	by senmx12-mx.siemens-enterprise.com (Server) with ESMTP id E03B423F048A
	for <util-linux@vger.kernel.org>; Wed,  9 Nov 2011 10:32:08 +0100 (CET)
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Wed, 9 Nov 2011 10:32:06 +0100
Subject: prlimit: SYS_prlimit undeclared on OpenSuSE 11.4
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D86B2EBA0@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Compiling the new prlimit (from latest git pull)
fails here on "openSUSE 11.4 (x86_64)":

  CC     prlimit.o
prlimit.c: In function 'prlimit':
prlimit.c:139:17: error: 'SYS_prlimit' undeclared (first use in this function)
prlimit.c:139:17: note: each undeclared identifier is reported only once for each function it appears in
make[2]: *** [prlimit.o] Error 1

Need more info?

Have a nice day,
Berny