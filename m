Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:40473 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753682Ab2DWJbN convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 05:31:13 -0400
Received: from MCHP063A.global-ad.net (unknown [172.29.37.61])
	by senmx12-mx.siemens-enterprise.com (Server) with ESMTP id 933BB23F0425
	for <util-linux@vger.kernel.org>; Mon, 23 Apr 2012 11:31:11 +0200 (CEST)
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: util-linux <util-linux@vger.kernel.org>
Date: Mon, 23 Apr 2012 11:31:11 +0200
Subject: eject on Cygwin?
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A097@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Is there a specific reason for this line in configure.ac?
  UL_REQUIRES_LINUX([eject])

Can't Cygwin handle /dev/scd0 correctly? 

Have a nice day,
Berny