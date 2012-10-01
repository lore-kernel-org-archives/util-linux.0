Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:57331 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab2JAHjt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Oct 2012 03:39:49 -0400
Message-ID: <506948C3.9050704@bernhard-voelker.de>
Date: Mon, 01 Oct 2012 09:39:47 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: fdisks/fdisk{bsd,sgi,dos}label.c: new warnings
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Just FYI ...
It seems that one of the latest commits has introduced
a bunch of new warnings:

  CC     fdisks/fdisk-fdiskmaclabel.o
fdisks/fdiskbsdlabel.c: In function ‘xbsd_set_parttype’:
fdisks/fdiskbsdlabel.c:860:52: warning: unused parameter ‘cxt’ [-Wunused-parameter]
  CC     fdisks/fdisk-fdisksgilabel.o
fdisks/fdisksgilabel.c: In function ‘generic_swap’:
fdisks/fdisksgilabel.c:402:13: warning: wrong type argument to increment [-Wpointer-arith]
fdisks/fdisksgilabel.c:403:13: warning: wrong type argument to increment [-Wpointer-arith]
fdisks/fdisksgilabel.c: In function ‘sort’:
fdisks/fdisksgilabel.c:421:27: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:421:37: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:421:41: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:423:27: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:423:37: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:425:22: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:425:32: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:431:27: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:435:27: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:435:37: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:435:41: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:437:27: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:437:37: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:439:22: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
fdisks/fdisksgilabel.c:439:32: warning: pointer of type ‘void *’ used in arithmetic [-Wpointer-arith]
  CC     fdisks/fdisk-fdisksunlabel.o
  CC     fdisks/fdisk-fdiskdoslabel.o
fdisks/fdiskdoslabel.c: In function ‘dos_set_parttype’:
fdisks/fdiskdoslabel.c:844:51: warning: unused parameter ‘cxt’ [-Wunused-parameter]

My HEAD is on v2.22-80-gd964b66.

Have a nice day,
Berny
