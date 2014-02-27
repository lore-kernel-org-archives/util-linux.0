Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.130]:57713 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaB0JrF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Feb 2014 04:47:05 -0500
Message-ID: <530F0972.3040205@bernhard-voelker.de>
Date: Thu, 27 Feb 2014 10:46:26 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Util-Linux <util-linux@vger.kernel.org>
Subject: chcpu exit code?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Although the man page does not mention the exit status, I think
it's wrong that 'chcpu' exits OK when an action failed or
when a bad CPU number was specified:

   $ ./chcpu -d 0 ; echo $?
   CPU 0 is not hot pluggable
   0

   $ ./chcpu -g 3 ; echo $?
   CPU 3 is not configurable
   0

   $ ./chcpu -e 4 ; echo $?
   CPU 4 does not exist
   0

WDYT?

Have a nice day,
Berny
