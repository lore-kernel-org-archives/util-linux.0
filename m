Return-Path: util-linux-owner@vger.kernel.org
Received: from bes.se.axis.com ([195.60.68.10]:45363 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbcANJNZ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Jan 2016 04:13:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 18FB82E182
	for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 10:04:27 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wzrmypfXiqUc for <util-linux@vger.kernel.org>;
	Thu, 14 Jan 2016 10:04:26 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 745112E175
	for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 10:04:25 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 590FB15CB
	for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 10:04:25 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 49FB412A2
	for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 10:04:25 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by thoth.se.axis.com (Postfix) with ESMTP id 4674D34213
	for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 10:04:25 +0100 (CET)
From: Fredrik Johnsson <fredrik.johnsson@axis.com>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Cyclic dependency with systemd?
Date: Thu, 14 Jan 2016 09:04:25 +0000
Message-ID: <1452762264910.97373@axis.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,


I am a bit concerned about the call to "sd_booted" in misc-util/logger.c:942. This would mean that util-linux depends on systemd, but systemd also depends on util-linux for libmount.


I have not run into any problems myself but can this be an issue? In theory: If you compile systemd without util-linux, it should fail because it needs libmount, and if you try to compile util-linux, it should also fail because it needs sd_booted from libsystemd.



Best regards,

Fredrik Johnsson
Axis Communication

