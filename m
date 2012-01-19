Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:51373 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab2ASL1O (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 19 Jan 2012 06:27:14 -0500
Message-ID: <4F17FE0D.4080901@bernhard-voelker.de>
Date: Thu, 19 Jan 2012 12:27:09 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: configure --prefix default
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Usually, software built via `configure && make && make install` uses /usr/local
as default for the prefix. Is there any reason for util-linux not to use the same?
If someone relies on /usr/local as the default, then she overwrites the native
version of the files of his distribution.

BTW: `configure --help` states that it would use /usr as default prefix:

  --prefix=PREFIX         install architecture-independent files in PREFIX
                          [/usr]

... but in fact e.g. chcpu is installed as "/sbin/chcpu" (i.e. without /usr).
This doesn't sound correct.

Have a nice day,
Berny
