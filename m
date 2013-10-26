Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:57704 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab3JZKQk convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Oct 2013 06:16:40 -0400
Received: from 3capp-gmx-bs40.server.lan ([172.19.170.92]) by
 mrigmx.server.lan (mrigmx002) with ESMTP (Nemesis) id
 0MKwSE-1Va0v82cMa-0005nW for <util-linux@vger.kernel.org>; Sat, 26 Oct 2013
 12:16:38 +0200
MIME-Version: 1.0
Message-ID: <trinity-e7dfd7ef-b198-4b29-a28a-a1243935fd6a-1382782598509@3capp-gmx-bs40>
From: andreas.hanke@gmx-topmail.de
To: util-linux@vger.kernel.org
Subject: Support the new Linux /home partition GUID
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Oct 2013 12:16:38 +0200 (CEST)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

systemd has recently introduced a new GUID that is used to auto-mount /home partitions on Linux. [1] This is documented at [2] and [3] and already supported in gdisk [4], but not yet in fdisk. I think this would be a useful addition.

[1] http://cgit.freedesktop.org/systemd/systemd/commit/?id=1a14a53cfded6e78c6e8dfb73fdff0039971d642
[2] http://www.freedesktop.org/software/systemd/man/systemd-gpt-auto-generator.html
[3] https://en.wikipedia.org/w/index.php?title=GUID_Partition_Table&oldid=576037522#Partition_type_GUIDs
[4] http://sourceforge.net/p/gptfdisk/code/ci/0fde58b966f37807260ad0dd8997e3f0c824d39c/

Andreas
