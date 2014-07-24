Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:60560 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaGXEzO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Jul 2014 00:55:14 -0400
Received: from [192.168.4.12] (athenae [192.168.4.12])
	by Ishtar.hs.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id s6O4Wrug058112
	for <util-linux@vger.kernel.org>; Wed, 23 Jul 2014 21:32:55 -0700
Message-ID: <53D08C77.6010500@tlinx.org>
Date: Wed, 23 Jul 2014 21:32:55 -0700
From: "Linda A. Walsh" <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Q: (RFE?)  How do you specify the 'no-canonicalize' option in fstab?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While it works interactively, that leaves out using it when most of the file
systems are loaded -- how can one specify -no-canonicalize in /etc/fstab?

Thx!
Linda

