Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:51541 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab2GXLYz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Jul 2012 07:24:55 -0400
Message-ID: <500E8603.3090002@bernhard-voelker.de>
Date: Tue, 24 Jul 2012 13:24:51 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: dmesg: SEEK_DATA undeclared error since v2.21-881-gc677ffb
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

UL doesn't compile here (OpenSuSE 12.1) anymore ;-/

git clean -xdf
./autogen.sh
./configure
make

sys-utils/dmesg.c: In function ‘init_kmsg’:
sys-utils/dmesg.c:867:22: error: ‘SEEK_DATA’ undeclared (first use in this function)
sys-utils/dmesg.c:867:22: note: each undeclared identifier is reported only once for each function it appears in


Have a nice day,
Berny
