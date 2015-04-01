Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57343 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbbDALnA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Apr 2015 07:43:00 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M3i8r-1ZTaU42LUv-00rJKE for
 <util-linux@vger.kernel.org>; Wed, 01 Apr 2015 13:42:57 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: question about hardcoded binary paths (swapon / mkswap)
Date: Wed, 1 Apr 2015 13:42:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201504011342.56546.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I wonder about some hardcoded binary paths.

Example swapon.c:

#define PATH_MKSWAP    "/sbin/mkswap"

There are a two problems.
1. It's wrong. We should use $sbindir from configure.
2. When called from our test-suite it will use a wrong (or
   non-existend, broken) binary. This happens in test swapon/fixpgsz.

The question is how to fix this.

I would prefer to use "mkwsap" from the same directory like swapon or to 
simply execvp "mkswap" from PATH. But don't know if we want this. If we 
really want to keep a hardcoded sbindir then we would need "#ifdef 
TEST_PROGRAM".

Any comments?

cu,
Rudi
